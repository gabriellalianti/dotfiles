#include "sketchybar.h"

#include <CoreFoundation/CoreFoundation.h>
#include <stdint.h>
#include <stdio.h>
#include <time.h>

static void update_calendar(CFRunLoopTimerRef timer, void *info)
{
    (void)timer;
    (void)info;

    time_t current_time = time(NULL);

    struct tm local_time;
    if (localtime_r(&current_time, &local_time) == NULL)
    {
        return;
    }

    char date_buffer[64];

    if (strftime(
            date_buffer,
            sizeof(date_buffer),
            "%a %d %b %I:%M:%S %p",
            &local_time) == 0)
    {
        return;
    }

    char message[128];

    int written = snprintf(
        message,
        sizeof(message),
        "--set calendar label=\"%s\"",
        date_buffer);

    if (written < 0 || (size_t)written >= sizeof(message))
    {
        return;
    }

    sketchybar_send(message);
}

int main(void)
{
    /*
     * Truncate the fractional part and add one second so the timer starts
     * exactly at the beginning of the next system-clock second.
     */
    CFAbsoluteTime next_second =
        (int64_t)CFAbsoluteTimeGetCurrent() + 1.0;

    CFRunLoopTimerRef timer = CFRunLoopTimerCreate(
        kCFAllocatorDefault,
        next_second,
        1.0,
        0,
        0,
        update_calendar,
        NULL);

    if (timer == NULL)
    {
        fprintf(stderr, "Failed to create calendar timer\n");
        return 1;
    }

    /*
     * Display the current value immediately rather than waiting until the
     * next second boundary.
     */
    update_calendar(NULL, NULL);

    CFRunLoopAddTimer(
        CFRunLoopGetMain(),
        timer,
        kCFRunLoopCommonModes);

    CFRunLoopRun();

    CFRelease(timer);
    return 0;
}