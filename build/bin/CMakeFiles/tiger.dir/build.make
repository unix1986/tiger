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
include bin/CMakeFiles/tiger.dir/depend.make

# Include the progress variables for this target.
include bin/CMakeFiles/tiger.dir/progress.make

# Include the compile flags for this target's objects.
include bin/CMakeFiles/tiger.dir/flags.make

bin/CMakeFiles/tiger.dir/main.o: bin/CMakeFiles/tiger.dir/flags.make
bin/CMakeFiles/tiger.dir/main.o: ../proj/main.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/wangjingjing/tiger/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object bin/CMakeFiles/tiger.dir/main.o"
	cd /home/wangjingjing/tiger/build/bin && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/tiger.dir/main.o -c /home/wangjingjing/tiger/proj/main.cpp

bin/CMakeFiles/tiger.dir/main.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/tiger.dir/main.i"
	cd /home/wangjingjing/tiger/build/bin && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/wangjingjing/tiger/proj/main.cpp > CMakeFiles/tiger.dir/main.i

bin/CMakeFiles/tiger.dir/main.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/tiger.dir/main.s"
	cd /home/wangjingjing/tiger/build/bin && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/wangjingjing/tiger/proj/main.cpp -o CMakeFiles/tiger.dir/main.s

bin/CMakeFiles/tiger.dir/main.o.requires:
.PHONY : bin/CMakeFiles/tiger.dir/main.o.requires

bin/CMakeFiles/tiger.dir/main.o.provides: bin/CMakeFiles/tiger.dir/main.o.requires
	$(MAKE) -f bin/CMakeFiles/tiger.dir/build.make bin/CMakeFiles/tiger.dir/main.o.provides.build
.PHONY : bin/CMakeFiles/tiger.dir/main.o.provides

bin/CMakeFiles/tiger.dir/main.o.provides.build: bin/CMakeFiles/tiger.dir/main.o

# Object files for target tiger
tiger_OBJECTS = \
"CMakeFiles/tiger.dir/main.o"

# External object files for target tiger
tiger_EXTERNAL_OBJECTS =

bin/tiger: bin/CMakeFiles/tiger.dir/main.o
bin/tiger: bin/CMakeFiles/tiger.dir/build.make
bin/tiger: bin/CMakeFiles/tiger.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX executable tiger"
	cd /home/wangjingjing/tiger/build/bin && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/tiger.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
bin/CMakeFiles/tiger.dir/build: bin/tiger
.PHONY : bin/CMakeFiles/tiger.dir/build

bin/CMakeFiles/tiger.dir/requires: bin/CMakeFiles/tiger.dir/main.o.requires
.PHONY : bin/CMakeFiles/tiger.dir/requires

bin/CMakeFiles/tiger.dir/clean:
	cd /home/wangjingjing/tiger/build/bin && $(CMAKE_COMMAND) -P CMakeFiles/tiger.dir/cmake_clean.cmake
.PHONY : bin/CMakeFiles/tiger.dir/clean

bin/CMakeFiles/tiger.dir/depend:
	cd /home/wangjingjing/tiger/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/wangjingjing/tiger /home/wangjingjing/tiger/proj /home/wangjingjing/tiger/build /home/wangjingjing/tiger/build/bin /home/wangjingjing/tiger/build/bin/CMakeFiles/tiger.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : bin/CMakeFiles/tiger.dir/depend

