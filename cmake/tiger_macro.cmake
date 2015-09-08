# macro for using protoc to compile *.proto files
macro(COMPILE_PB_FILE pb_file)
    find_file(CMAKE_PB_COMPILER NAMES protoc
        PATHS ${TIGER_TOOL_PATH}/protobuf NO_DEFAULT_PATH)
    find_file(CMAKE_PB_COMPILER NAMES protoc)
    if(CMAKE_PB_COMPILER)
        execute_process(COMMAND mkdir -p ${TIGER_PB_OUTPUT_PATH})
        execute_process(COMMAND ${CMAKE_PB_COMPILER}
            --proto_path=${PROJECT_SOURCE_DIR}
            --cpp_out=${TIGER_PB_OUTPUT_PATH} ${pb_file})
    else()
        message(FATAL_ERROR "CMAKE_PB_COMPILER=${CMAKE_PB_COMPILER} is not valid proto compiler!")
    endif()
endmacro()

macro(COMPILE_PB_FILES pb_files)
    foreach(pb_file ${pb_files})
        COMPILE_PB_FILE(${pb_file})
    endforeach()
endmacro()

macro(COMPILE_PB_PATH pb_path)
    file(GLOB pb_files "${pb_path}/*.proto")
    COMPILE_PB_FILES("${pb_files}")
endmacro()

macro(COMPILE_PB_PATH_RECURSE pb_path)
    file(GLOB_RECURSE pb_files "${pb_path}/*.proto")
    COMPILE_PB_FILES("${pb_files}")
endmacro()

#macro for using thrift to compile *.thrift files
macro(COMPILE_TF_FILE tf_file)
    find_file(CMAKE_TF_COMPILER NAMES thrift
        PATHS ${TIGER_TOOL_PATH}/thrift NO_DEFAULT_PATH)
    find_file(CMAKE_TF_COMPILER NAMES thrift)
    if(CMAKE_TF_COMPILER)
        execute_process(COMMAND mkdir -p ${TIGER_TF_OUTPUT_PATH})
        execute_process(COMMAND ${CMAKE_TF_COMPILER}
            --gen cpp -out ${TIGER_TF_OUTPUT_PATH} ${tf_file})
    else()
        message(FATAL_ERROR "CMAKE_TF_COMPILER=${CMAKE_TF_COMPILER} is not valid thrift compiler!")
    endif()
endmacro()

macro(COMPILE_TF_FILES tf_files)
    foreach(tf_file ${tf_files})
        COMPILE_TF_FILE(${tf_file})
    endforeach()
endmacro()

macro(COMPILE_TF_PATH tf_path)
    file(GLOB tf_files "${tf_path}/*.thrift")
    COMPILE_TF_FILES("${tf_files}")
endmacro()

macro(COMPILE_TF_PATH_RECURSE tf_path)
    file(GLOB_RECURSE tf_files "${tf_path}/*.thrift")
    COMPILE_TF_FILES("${tf_files}")
endmacro()
