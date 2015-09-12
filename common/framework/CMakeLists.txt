set(SRC_LIST src/tiger.cpp)
add_library(tiger STATIC ${SRC_LIST})
target_include_directories(tiger
PUBLIC ${TIGER_THIRDPARTY_LIB_PATH}/zlog/include
PUBLIC ${TIGER_THIRDPARTY_LIB_PATH}/gflags/include
PUBLIC ${TIGER_THIRDPARTY_LIB_PATH}/protobuf/include
)
target_link_libraries(tiger
-Wl,-Bstatic
-L${TIGER_THIRDPARTY_LIB_PATH}/zlog/lib -lzlog
-L${TIGER_THIRDPARTY_LIB_PATH}/gflags/lib -lgflags
-L${TIGER_THIRDPARTY_LIB_PATH}/protobuf/lib -lprotobuf
-Wl,-Bdynamic
)
