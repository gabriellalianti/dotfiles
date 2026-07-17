// adapted from:
// https://github.com/FelixKratz/SketchyBar/discussions/454

#pragma once

#include <bootstrap.h>
#include <mach/mach.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct sketchybar_mach_message
{
    mach_msg_header_t header;
    mach_msg_size_t descriptor_count;
    mach_msg_ool_descriptor_t descriptor;
};

static mach_port_t sketchybar_port = MACH_PORT_NULL;

static inline mach_port_t get_sketchybar_port(void)
{
    mach_port_t bootstrap_port;

    if (task_get_special_port(
            mach_task_self(),
            TASK_BOOTSTRAP_PORT,
            &bootstrap_port) != KERN_SUCCESS)
    {
        return MACH_PORT_NULL;
    }

    const char *bar_name = getenv("BAR_NAME");

    if (bar_name == NULL)
    {
        bar_name = "sketchybar";
    }

    char service_name[128];

    int written = snprintf(
        service_name,
        sizeof(service_name),
        "git.felix.%s",
        bar_name);

    if (written < 0 || (size_t)written >= sizeof(service_name))
    {
        return MACH_PORT_NULL;
    }

    mach_port_t port = MACH_PORT_NULL;

    if (bootstrap_look_up(
            bootstrap_port,
            service_name,
            &port) != KERN_SUCCESS)
    {
        return MACH_PORT_NULL;
    }

    return port;
}

static inline bool send_mach_message(
    mach_port_t port,
    char *message,
    uint32_t length)
{
    if (port == MACH_PORT_NULL || message == NULL || length == 0)
    {
        return false;
    }

    struct sketchybar_mach_message mach_message = {0};

    mach_message.header.msgh_remote_port = port;
    mach_message.header.msgh_local_port = MACH_PORT_NULL;
    mach_message.header.msgh_id = 0;
    mach_message.header.msgh_bits = MACH_MSGH_BITS_SET(
        MACH_MSG_TYPE_COPY_SEND,
        MACH_MSG_TYPE_MAKE_SEND,
        0,
        MACH_MSGH_BITS_COMPLEX);
    mach_message.header.msgh_size = sizeof(mach_message);

    mach_message.descriptor_count = 1;
    mach_message.descriptor.address = message;
    mach_message.descriptor.size = length;
    mach_message.descriptor.copy = MACH_MSG_VIRTUAL_COPY;
    mach_message.descriptor.deallocate = false;
    mach_message.descriptor.type = MACH_MSG_OOL_DESCRIPTOR;

    kern_return_t result = mach_msg(
        &mach_message.header,
        MACH_SEND_MSG,
        sizeof(mach_message),
        0,
        MACH_PORT_NULL,
        MACH_MSG_TIMEOUT_NONE,
        MACH_PORT_NULL);

    return result == KERN_SUCCESS;
}

static inline uint32_t format_sketchybar_message(
    const char *message,
    char *formatted)
{
    char outer_quote = '\0';
    uint32_t output_index = 0;
    size_t message_length = strlen(message);

    for (size_t i = 0; i <= message_length; i++)
    {
        char character = message[i];

        if (character == '"' || character == '\'')
        {
            if (outer_quote == character)
            {
                outer_quote = '\0';
            }
            else if (outer_quote == '\0')
            {
                outer_quote = character;
            }

            continue;
        }

        if (character == ' ' && outer_quote == '\0')
        {
            formatted[output_index] = '\0';
        }
        else
        {
            formatted[output_index] = character;
        }

        output_index++;
    }

    return output_index;
}

static inline bool sketchybar_send(const char *message)
{
    if (message == NULL)
    {
        return false;
    }

    char formatted_message[strlen(message) + 1];

    uint32_t length = format_sketchybar_message(
        message,
        formatted_message);

    if (length == 0)
    {
        return false;
    }

    if (sketchybar_port == MACH_PORT_NULL)
    {
        sketchybar_port = get_sketchybar_port();
    }

    if (send_mach_message(
            sketchybar_port,
            formatted_message,
            length))
    {
        return true;
    }

    /*
     * SketchyBar may have restarted and received a new Mach port.
     */
    sketchybar_port = get_sketchybar_port();

    if (send_mach_message(
            sketchybar_port,
            formatted_message,
            length))
    {
        return true;
    }

    /*
     * SketchyBar is no longer running.
     * Stop the persistent helper instead of leaving it alive.
     */
    exit(EXIT_SUCCESS);
}