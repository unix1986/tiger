#include <stdio.h>
#include <stdlib.h>
#include "thirdparty/zlog/include/zlog.h"

const static char *zlog_conf = "/home/milo/tiger/proj/config/zlog.conf";
int main(int argc, char *argv[]) {
    if (dzlog_init(zlog_conf, "default") != 0) {
        fprintf(stderr, "dzlog_init error!\n");
        exit(1);
    }
    dzlog_warn("Hello Tiger!");
    return 0;
}
