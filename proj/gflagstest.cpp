#include <stdio.h>
#include <stdlib.h>

#include "thirdparty/gflags/include/gflags/gflags.h"

DEFINE_int32(test, 5, "test int");
int main(int argc, char *argv[]) {
    gflags::SetUsageMessage("Hello gflags!");
    gflags::ParseCommandLineFlags(&argc, &argv, true);
    fprintf(stderr, "%d\n", FLAGS_test);
    FLAGS_test=7;
    fprintf(stderr, "%d\n", FLAGS_test);

    return 0;
}
