# ###############################################
# MACRO FOR USING PROTOC TO COMPILE *.proto FILES
# ###############################################
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

# NOT RECOMMENDED, SUBDIRECTORY WILL OVERIDE PARENT DIRECTORY
macro(COMPILE_PB_PATH_RECURSE pb_path)
    file(GLOB_RECURSE pb_files "${pb_path}/*.proto")
    COMPILE_PB_FILES("${pb_files}")
endmacro()

# ################################################
# MACRO FOR USING THRIFT TO COMPILE *.thrift FILES
# ################################################
macro(COMPILE_TF_FILE tf_file)
    find_file(CMAKE_TF_COMPILER NAMES thrift
        PATHS ${TIGER_TOOL_PATH}/thrift NO_DEFAULT_PATH)
    find_file(CMAKE_TF_COMPILER NAMES thrift)
    get_filename_component(tf_file_path ${tf_file} DIRECTORY)
    if(CMAKE_TF_COMPILER)
        string(LENGTH ${PROJECT_SOURCE_DIR} beg_len)
        string(LENGTH ${tf_file_path} end_len)
        if(end_len GREATER beg_len)
            math(EXPR sub_len "${end_len} - ${beg_len}")
            string(SUBSTRING ${tf_file_path} ${beg_len} ${sub_len} sub_str)
            set(O_PATH "${TIGER_TF_OUTPUT_PATH}${sub_str}")
        else()
            set(O_PATH "${TIGER_TF_OUTPUT_PATH}")
        endif()
        execute_process(COMMAND mkdir -p ${O_PATH})
        execute_process(COMMAND ${CMAKE_TF_COMPILER}
            --gen cpp -out ${O_PATH} ${tf_file})
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

# NOT RECOMMENDED, SUBDIRECTORY WILL OVERIDE PARENT DIRECTORY
macro(COMPILE_TF_PATH_RECURSE tf_path)
    file(GLOB_RECURSE tf_files "${tf_path}/*.thrift")
    COMPILE_TF_FILES("${tf_files}")
endmacro()

# ###################################################
# UTIL MACRO
# ###################################################
# REMOVE ITEM INCLUDING _regex FROM _list
macro(REMOVE_ITEM_REGEX _list _regex)
    foreach(item ${${_list}})
        string(REGEX MATCH ${_regex} match_item ${item})
	if(match_item)
            list(REMOVE_ITEM ${_list} ${item})
	endif()
    endforeach()
endmacro()

# DETACH DEBUG INFO TO A SINGLE FILE
macro(DETACH_DEBUG_INFO_BY_PATH tgt elf_path)
    add_custom_target(${tgt}
        COMMAND rm -rf *.dbg &>/dev/null
        COMMAND ls | xargs -i objcopy --only-keep-debug {} {}.dbg &>/dev/null
        COMMAND ls -I*.dbg | xargs -i objcopy --strip-debug {} &>/dev/null
        COMMAND ls -I*.dbg | xargs -i objcopy --add-gnu-debuglink={}.dbg {} &>/dev/null
        COMMAND ls *.dbg | xargs -i chmod 0664 {} &>/dev/null
        WORKING_DIRECTORY ${elf_path}
        COMMENT "Detach debug info from binaries. Workdir:${elf_path}")
endmacro()

# USE EXUBERANT-CTAGS TO MAKE TAGS FOR SOURCE FILES
macro(ADD_CTAGS)
    find_program(__tiger_ctags_found__ ctags)
    if(__tiger_ctags_found__)
        foreach(item ${ARGV})
            list(APPEND __tiger_ctags_dir__ "${PROJECT_SOURCE_DIR}/${item}")
        endforeach()
        if(ARGC EQUAL 0)
            set(__tiger_ctags_dir__ "${PROJECT_SOURCE_DIR}")
        endif()
        add_custom_target(tags
            COMMAND find -L ${__tiger_ctags_dir__} -name *.cpp -or -name *.cc -or -name *.c
                -or -name *.proto -or -name *.thrift -or -name *.h -or -name *.inl 2>/dev/null
                |xargs ctags --langmap=c++:+.inl.proto.thrift
            COMMENT "Ctags for source files. Workdir:${__tiger_ctags_dir__}")
    else()
        message(STATUS "Ctags not found. Can't use make tags...")
    endif()
endmacro()
