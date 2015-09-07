#include <stdio.h>
#include <stdlib.h>
#include "common/framework/include/tiger.h"
// Framework Entrance
DEFINE_string(zlog_conf, "", "main zlog configure file");
DEFINE_string(zlog_cat, "default", "main zlog configure default setting");
int main(int argc, char *argv[]) {
    gflags::SetUsageMessage("Tiger Framework for C++ Server Application");
    gflags::ParseCommandLineFlags(&argc, &argv, true);
    if (dzlog_init(FLAGS_zlog_conf.c_str(), FLAGS_zlog_cat.c_str()) != 0) {
        fprintf(stderr, "[file:%s, line:%d] "
            "dzlog_init error!\n", __FILE__, __LINE__);
        exit(EXIT_FAILURE);
    }
    int ret = tiger_main(argc, argv);
    zlog_fini();
    return ret;
}
