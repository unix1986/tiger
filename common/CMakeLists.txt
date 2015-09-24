set(COMMON_SRC_LIST
    src/color_printf.cpp
    src/tiger.cpp
)
add_library(common STATIC ${COMMON_SRC_LIST})
target_include_directories(common
PUBLIC ${TIGER_THIRDPARTY_LIB_PATH}/zlog/include
PUBLIC ${TIGER_THIRDPARTY_LIB_PATH}/gflags/include
PUBLIC ${TIGER_THIRDPARTY_LIB_PATH}/protobuf/include
)
target_link_libraries(common
-Wl,-Bstatic
-L${TIGER_THIRDPARTY_LIB_PATH}/zlog/lib -lzlog
-L${TIGER_THIRDPARTY_LIB_PATH}/gflags/lib -lgflags
-L${TIGER_THIRDPARTY_LIB_PATH}/protobuf/lib -lprotobuf
-Wl,-Bdynamic
)
