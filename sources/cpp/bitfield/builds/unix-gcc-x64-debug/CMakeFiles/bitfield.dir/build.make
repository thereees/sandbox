# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.2

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
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/vagrant/cpp/bitfield

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/vagrant/cpp/bitfield/builds/unix-gcc-x64-debug

# Include any dependencies generated for this target.
include CMakeFiles/bitfield.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/bitfield.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/bitfield.dir/flags.make

CMakeFiles/bitfield.dir/main.cxx.o: CMakeFiles/bitfield.dir/flags.make
CMakeFiles/bitfield.dir/main.cxx.o: ../../main.cxx
	$(CMAKE_COMMAND) -E cmake_progress_report /home/vagrant/cpp/bitfield/builds/unix-gcc-x64-debug/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object CMakeFiles/bitfield.dir/main.cxx.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/bitfield.dir/main.cxx.o -c /home/vagrant/cpp/bitfield/main.cxx

CMakeFiles/bitfield.dir/main.cxx.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/bitfield.dir/main.cxx.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/vagrant/cpp/bitfield/main.cxx > CMakeFiles/bitfield.dir/main.cxx.i

CMakeFiles/bitfield.dir/main.cxx.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/bitfield.dir/main.cxx.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/vagrant/cpp/bitfield/main.cxx -o CMakeFiles/bitfield.dir/main.cxx.s

CMakeFiles/bitfield.dir/main.cxx.o.requires:
.PHONY : CMakeFiles/bitfield.dir/main.cxx.o.requires

CMakeFiles/bitfield.dir/main.cxx.o.provides: CMakeFiles/bitfield.dir/main.cxx.o.requires
	$(MAKE) -f CMakeFiles/bitfield.dir/build.make CMakeFiles/bitfield.dir/main.cxx.o.provides.build
.PHONY : CMakeFiles/bitfield.dir/main.cxx.o.provides

CMakeFiles/bitfield.dir/main.cxx.o.provides.build: CMakeFiles/bitfield.dir/main.cxx.o

# Object files for target bitfield
bitfield_OBJECTS = \
"CMakeFiles/bitfield.dir/main.cxx.o"

# External object files for target bitfield
bitfield_EXTERNAL_OBJECTS =

bin/bitfield: CMakeFiles/bitfield.dir/main.cxx.o
bin/bitfield: CMakeFiles/bitfield.dir/build.make
bin/bitfield: CMakeFiles/bitfield.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX executable bin/bitfield"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/bitfield.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/bitfield.dir/build: bin/bitfield
.PHONY : CMakeFiles/bitfield.dir/build

CMakeFiles/bitfield.dir/requires: CMakeFiles/bitfield.dir/main.cxx.o.requires
.PHONY : CMakeFiles/bitfield.dir/requires

CMakeFiles/bitfield.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/bitfield.dir/cmake_clean.cmake
.PHONY : CMakeFiles/bitfield.dir/clean

CMakeFiles/bitfield.dir/depend:
	cd /home/vagrant/cpp/bitfield/builds/unix-gcc-x64-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/vagrant/cpp/bitfield /home/vagrant/cpp/bitfield /home/vagrant/cpp/bitfield/builds/unix-gcc-x64-debug /home/vagrant/cpp/bitfield/builds/unix-gcc-x64-debug /home/vagrant/cpp/bitfield/builds/unix-gcc-x64-debug/CMakeFiles/bitfield.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/bitfield.dir/depend

