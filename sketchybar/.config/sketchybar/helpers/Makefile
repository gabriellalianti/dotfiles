CC := clang
CFLAGS := -std=c99 -Wall -Wextra -Wpedantic -O2
FRAMEWORKS := -framework CoreFoundation

TARGET := sketchybar-calendar
SOURCE := calendar.c
HEADER := sketchybar.h

.PHONY: all clean rebuild

all: $(TARGET)

$(TARGET): $(SOURCE) $(HEADER)
	$(CC) $(CFLAGS) $(SOURCE) $(FRAMEWORKS) -o $(TARGET)

clean:
	rm -f $(TARGET)

rebuild: clean all