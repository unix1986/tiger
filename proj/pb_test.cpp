#include "common/framework/include/tiger.h"
#include "proj/pb_files/test.pb.h"

int tiger_main(int argc, char *argv[]) {
    Test t;
    dzlog_warn("proto: %u", t.i());
    return 0;
}
