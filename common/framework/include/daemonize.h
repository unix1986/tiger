#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <signal.h>
#include <sys/resource.h>

void daemonize(const char *root_dir = NULL) {
    /**
     * Clear file creation mask.
     */
    umask(0);
    /**
     * Get maximum number of file descriptors.
     */
    struct rlimit max_num;
    if (getrlimit(RLIMIT_NOFILE, &max_num) < 0) {
        fprintf(stderr, "can't get file max number limit!\n");
        exit(EXIT_FAILURE);
    }
    /**
     * Become a session leader to lose controlling TTY.
     */
    int pid = 0;
    if ((pid = fork()) < 0) { // error
        fprintf(stderr, "first fork error!\n");
        exit(EXIT_FAILURE);
    } else if (pid > 0) { // parent
        exit(EXIT_SUCCESS);
    }
    setsid();
    /**
     * Ensure future opens won't allocate controlling TTYs.
     */
    struct sigaction sa;
    sa.sa_handler = SIG_IGN;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = 0;
    if (sigaction(SIGHUP, &sa, NULL) < 0) {
        fprintf(stderr, "can't ignore SIGHUP\n");
        exit(EXIT_FAILURE);
    }
    if ((pid = fork()) < 0) { // error
        fprintf(stderr, "second fork error!\n");
        exit(EXIT_FAILURE);
    } else if (pid > 0) { // parent
        exit(EXIT_SUCCESS);
    }
    /**
     * Change current workdir to root_dir
     */
    if (root_dir != NULL && root_dir[0] != 0) {
        if (chdir(root_dir) < 0) {
            fprintf(stderr, "can't change dir to [%s]", root_dir);
            exit(EXIT_FAILURE);
        }
    }
}
