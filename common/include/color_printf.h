#ifndef __COLOR_PRINTF_H__
#define __COLOR_PRINTF_H__

namespace tiger { namespace common { namespace util {

enum PF_Color {
    BLACK = 30,
    RED,
    GREEN,
    YELLOW,
    BLUE,
    PURPLE,
    DARK_GREEN,
    WHITE
};

int color_printf(PF_Color color, const char *format, ...);

} // namespace tiger
} // namespace common
} // namespace util

#endif // __COLOR_PRINTF_H__
