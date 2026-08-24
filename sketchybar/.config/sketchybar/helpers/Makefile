CC := clang
CFLAGS := -std=c99 -Wall -Wextra -Wpedantic -O2
FRAMEWORKS := -framework CoreFoundation

TARGET := sketchybar-clock
SOURCE := clock.c
HEADER := sketchybar.h

.PHONY: all clean rebuild

all: $(TARGET)

$(TARGET): $(SOURCE) $(HEADER)
	$(CC) $(CFLAGS) $(SOURCE) $(FRAMEWORKS) -o $(TARGET)

clean:
	rm -f $(TARGET)

rebuild: clean all
