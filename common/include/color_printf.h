#ifndef __COLOR_PRINTF_H__
#define __COLOR_PRINTF_H__

namespace tiger { namespace common {

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

} // namespace common
} // namespace tiger

#endif // __COLOR_PRINTF_H__
