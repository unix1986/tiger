#include "common/framework/include/tiger.h"
// Framework Entrance
int main(int argc, char *argv[]) {
    gflags::SetUsageMessage("Tiger Framework for C++ Server Application");
    gflags::ParseCommandLineFlags(&argc, &argv, true);
    return tiger_main(argc, argv);
}
