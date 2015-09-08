# macro for using protoc to compile *.proto files
macro(COMPILE_PB_FILE pb_file)
    find_file(CMAKE_PB_COMPILER NAMES protoc
        PATHS ${TIGER_TOOL_PATH}/protobuf NO_DEFAULT_PATH)
    find_file(CMAKE_PB_COMPILER NAMES protoc)
    get_filename_component(pb_file_path ${pb_file} DIRECTORY)
    if(CMAKE_PB_COMPILER)
        execute_process(COMMAND mkdir -p ${TIGER_PB_OUTPUT_PATH})
        execute_process(COMMAND ${CMAKE_PB_COMPILER}
            --proto_path=${PROJECT_SOURCE_DIR}
            --cpp_out=${TIGER_PB_OUTPUT_PATH} ${pb_file})
    else()
        message(FATAL_ERROR "CMAKE_PROTOC=${CMAKE_PB_COMPILER} is not valid proto compiler!")
    endif()
endmacro()

macro(COMPILE_PB_FILES pb_files)
    foreach(pb_file ${pb_files})
        COMPILE_PB_FILE(${pb_file})
    endforeach()
endmacro()

macro(COMPILE_PB_PATH pb_path)
    file(GLOB pb_files "${pb_path}/*.proto")
    COMPILE_PB_FILES(${pb_files})
endmacro()

macro(COMPILE_PB_PATH_RECURSE pb_path)
    file(GLOB_RECURSE pb_files "${pb_path}/*.proto")
    COMPILE_PB_FILES(${pb_files})
endmacro()
