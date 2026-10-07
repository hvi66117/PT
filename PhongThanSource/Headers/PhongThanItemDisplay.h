#ifndef PHONGTHAN_ITEM_DISPLAY_H
#define PHONGTHAN_ITEM_DISPLAY_H
#include <string.h>

// VNG names use single-byte Vietnamese font encoding. Do not recode bytes.
// Plain UI labels must not receive the source's prefix or rich-text tags.
inline void PhongThanPlainItemName(const char* source, char* target, int capacity)
{
    if (!target || capacity <= 0) return;
    int written = 0;
    if (!source) source = "";
    while (*source == '#' || *source == '$') ++source;
    while (*source && written < capacity - 1)
    {
        if (written == 0 && (*source == '#' || *source == '$'))
            { ++source; continue; }
        if (*source == '<' &&
            (!strncmp(source, "<color", 6) || !strncmp(source, "<bclr", 5) ||
             !strncmp(source, "</color", 7) || !strncmp(source, "</bclr", 6)))
        {
            const char* end = strchr(source, '>');
            if (end) { source = end + 1; continue; }
        }
        target[written++] = *source++;
    }
    target[written] = 0;
}
#endif
