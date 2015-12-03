#include <stdio.h>
#include <stdlib.h>
#include "common/include/tiger.h"

DEFINE_string(test_str, "hello tiger!", "gflags test");

int tiger_main(int argc, char *argv[]) {
    dzlog_warn("%s", FLAGS_test_str.c_str());
    return 0;
}
