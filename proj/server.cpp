#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <fcntl.h>

#include "thirdparty/libevent/include/event2/event.h"
#include "thirdparty/libevent/include/event2/buffer.h"
#include "thirdparty/libevent/include/event2/bufferevent.h"

#include <assert.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <errno.h>

void read_cb(struct bufferevent *bev, void *ctx) {
    struct evbuffer *input, *output;
    input = bufferevent_get_input(bev);
    output = bufferevent_get_output(bev);
    char *line = NULL;
    size_t len = 0;
    printf("Enter read_cb\n");
    while ((line = evbuffer_readln(input, &len, EVBUFFER_EOL_LF)) != NULL) {
        evbuffer_add(output, "Tks.", strlen("Tks."));
        evbuffer_add(output, line, len);
        evbuffer_add(output, "\n", 1);
        free(line);
    }
    printf("Leave read_cb\n");
}

void write_cb(struct bufferevent *bev, void *ctx) {
    printf("Enter write_cb\n");
    
    printf("Enter write_cb\n");
}

void error_cb(struct bufferevent *bev, short error, void *ctx) {
    struct sockaddr_in *sin = (struct sockaddr_in *)ctx;
    char *ip = inet_ntoa(sin->sin_addr);
    if (error & BEV_EVENT_EOF) {
        printf("%s closed.\n", ip);
    } else if (error & BEV_EVENT_ERROR) {
        perror(ip);
    } else if (error & BEV_EVENT_TIMEOUT) {
        printf("%s timeout.\n", ip);
        return;
    }
    bufferevent_free(bev);
}

void accept_cb(evutil_socket_t fd, short event, void *arg) {
    struct event_base *base = (struct event_base *)arg;
    struct sockaddr_storage ss;
    socklen_t sslen = sizeof(ss);
    evutil_socket_t read_fd = accept(fd, (struct sockaddr *)&ss, &sslen);
    if (read_fd < 0) {
        perror("accept error.");
        return;
    }
    evutil_make_socket_nonblocking(read_fd);
    struct bufferevent *bev = bufferevent_socket_new(base, read_fd, BEV_OPT_CLOSE_ON_FREE);
    if (bev == NULL) {
        printf("bufferevent_new error.\n");
        return;
    }
    bufferevent_setcb(bev, read_cb, write_cb, error_cb, (void *)&ss);
    bufferevent_enable(bev, EV_READ|EV_WRITE);
}

void run() {
    evutil_socket_t listener;
    struct sockaddr_in sin;
    struct event_base *base;
    struct event *listener_event;

    sin.sin_family = AF_INET;
    sin.sin_port = htons(20202);
    sin.sin_addr.s_addr = 0;

    listener = socket(AF_INET, SOCK_STREAM, 0);
    if (listener < 0) {
        printf("%s\n", strerror(errno));
        exit(EXIT_FAILURE);
    }
    evutil_make_socket_nonblocking(listener);
    int one = 1;
    setsockopt(listener, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one));
    if (bind(listener, (struct sockaddr *)&sin, sizeof(sin)) < 0) {
        printf("%s\n", strerror(errno));
        exit(EXIT_FAILURE);
    }
    base = event_base_new();
    if (base == NULL) {
        printf("base == NULL\n");
        exit(EXIT_FAILURE);
    }
    if (listen(listener, 16) < 0) {
        printf("%s\n", strerror(errno));
        exit(EXIT_FAILURE);
    }
    listener_event = event_new(base, listener, EV_READ|EV_PERSIST, accept_cb, (void *)base);
    if (listener_event == NULL) {
        printf("listener_event == NULL\n");
        exit(EXIT_FAILURE);
    }
    event_add(listener_event, NULL);
    event_base_dispatch(base);
}

int main(int argc, char *argv[]) {
    setvbuf(stdout, NULL, _IONBF, 0);
    run(); 
    return 0;
}
