# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.0

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /home/wangjingjing/tools/cmake/bin/cmake

# The command to remove a file.
RM = /home/wangjingjing/tools/cmake/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/wangjingjing/tiger

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/wangjingjing/tiger/build

# Include any dependencies generated for this target.
include proj/CMakeFiles/main.dir/depend.make

# Include the progress variables for this target.
include proj/CMakeFiles/main.dir/progress.make

# Include the compile flags for this target's objects.
include proj/CMakeFiles/main.dir/flags.make

proj/CMakeFiles/main.dir/main.o: proj/CMakeFiles/main.dir/flags.make
proj/CMakeFiles/main.dir/main.o: ../proj/main.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/wangjingjing/tiger/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object proj/CMakeFiles/main.dir/main.o"
	cd /home/wangjingjing/tiger/build/proj && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/main.dir/main.o -c /home/wangjingjing/tiger/proj/main.cpp

proj/CMakeFiles/main.dir/main.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/main.dir/main.i"
	cd /home/wangjingjing/tiger/build/proj && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/wangjingjing/tiger/proj/main.cpp > CMakeFiles/main.dir/main.i

proj/CMakeFiles/main.dir/main.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/main.dir/main.s"
	cd /home/wangjingjing/tiger/build/proj && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/wangjingjing/tiger/proj/main.cpp -o CMakeFiles/main.dir/main.s

proj/CMakeFiles/main.dir/main.o.requires:
.PHONY : proj/CMakeFiles/main.dir/main.o.requires

proj/CMakeFiles/main.dir/main.o.provides: proj/CMakeFiles/main.dir/main.o.requires
	$(MAKE) -f proj/CMakeFiles/main.dir/build.make proj/CMakeFiles/main.dir/main.o.provides.build
.PHONY : proj/CMakeFiles/main.dir/main.o.provides

proj/CMakeFiles/main.dir/main.o.provides.build: proj/CMakeFiles/main.dir/main.o

# Object files for target main
main_OBJECTS = \
"CMakeFiles/main.dir/main.o"

# External object files for target main
main_EXTERNAL_OBJECTS =

bin/main: proj/CMakeFiles/main.dir/main.o
bin/main: proj/CMakeFiles/main.dir/build.make
bin/main: proj/CMakeFiles/main.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX executable ../bin/main"
	cd /home/wangjingjing/tiger/build/proj && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/main.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
proj/CMakeFiles/main.dir/build: bin/main
.PHONY : proj/CMakeFiles/main.dir/build

proj/CMakeFiles/main.dir/requires: proj/CMakeFiles/main.dir/main.o.requires
.PHONY : proj/CMakeFiles/main.dir/requires

proj/CMakeFiles/main.dir/clean:
	cd /home/wangjingjing/tiger/build/proj && $(CMAKE_COMMAND) -P CMakeFiles/main.dir/cmake_clean.cmake
.PHONY : proj/CMakeFiles/main.dir/clean

proj/CMakeFiles/main.dir/depend:
	cd /home/wangjingjing/tiger/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/wangjingjing/tiger /home/wangjingjing/tiger/proj /home/wangjingjing/tiger/build /home/wangjingjing/tiger/build/proj /home/wangjingjing/tiger/build/proj/CMakeFiles/main.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : proj/CMakeFiles/main.dir/depend

