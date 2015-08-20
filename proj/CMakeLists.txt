add_executable(tiger main.cpp)
target_link_libraries(tiger zlog pthread)
add_executable(server server.cpp)
target_link_libraries(server event)
