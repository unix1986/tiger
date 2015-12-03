#include "common/include/color_printf.h"
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string>
namespace tiger { namespace common {

int color_printf(PF_Color color, const char *format, ...) {
    char color_format[4096];
    snprintf(color_format, 4095, "\e[%dm%s\e[0m", color, format);
    va_list arg_ptr;
    va_start(arg_ptr, format);
    int ret = vprintf(color_format, arg_ptr);
    va_end(arg_ptr);
    return ret;
}

} }
