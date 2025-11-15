
#[[

  CMakeLists.txt

  This file is part of fizmo.

  ---

  Copyright (c) 2010-2025 Christoph Ender.
  All rights reserved.

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions
  are met:
  1. Redistributions of source code must retain the above copyright
  notice, this list of conditions and the following disclaimer.
  2. Redistributions in binary form must reproduce the above copyright
  notice, this list of conditions and the following disclaimer in the
  documentation and/or other materials provided with the distribution.
  3. Neither the name of the copyright holder nor the names of its
  contributors may be used to endorse or promote products derived
  from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

  ---

  This is fizmo-remglk's main buildfile.

  -DLIBREMGLK_INCLUDE_DIRS=${HOME}/opt/remglk
  -DLIBREMGLK_LIBRARY_DIRS=${HOME}/opt/remglk
  -DLIBREMGLK_LIBRARIES=-lremglk

]]


cmake_minimum_required(VERSION 3.10)

include(FindPkgConfig)


project(fizmo-remglk
  LANGUAGES C
  HOMEPAGE_URL https://fizmo.spellbreaker.org
  DESCRIPTION "fizmo remglk frontend"
  VERSION 0.3.0)


# Create position-independent code.
set(CMAKE_POSITION_INDEPENDENT_CODE ON)


find_package(PkgConfig REQUIRED)


# We need libfizmo >= 0.9.
pkg_check_modules(LIBFIZMO REQUIRED libfizmo>=0.9.0)

# We need libglkif.
pkg_check_modules(LIBGLKIF REQUIRED libglkif)

# We need "glk.h".
if(NOT GLK_H_INCLUDE_DIR)
  message(FATAL_ERROR "You have to set \"GLK_H_INCLUDE_DIR\" in order to processed.")
endif()

# We need libtlkermw.
if(NOT LIBREMGLK_INCLUDE_DIRS
    AND NOT LIBREMGLK_LIBRARY_DIR
    AND NOT LIBREMGLK_LIBRARIES)
  pkg_check_modules(LIBREMGLK REQUIRED libremglk)
endif()


# Enabling tracing will cause fizmo to write a really, really large amount
# of debug data to disk while running. Furthermore, after every single
# write, fizmo will invoke an fsync(), meaning that performance will
# quite suffer. This is only useful for debugging and should be disabled
# in all other cases.
option(ENABLE_TRACING "Enable tracing" OFF)
if (ENABLE_TRACING)
  add_definitions(-DENABLE_TRACING)
endif()


# Store filenames of all files-to-be-compiled in "C_FILES"
set (c_sources
  src/fizmo-remglk/fizmo-remglk.c)


# Tell CMake we're going to build an executable "fizmo-remglk" with the
# given ".c" files, and specify libs and includes.
add_executable(fizmo-remglk ${c_sources})

target_include_directories(${PROJECT_NAME} PUBLIC
  ${LIBFIZMO_INCLUDE_DIRS}
  ${LIBGLKIF_INCLUDE_DIRS}
  ${LIBREMGLK_INCLUDE_DIRS}
  ${GLK_H_INCLUDE_DIR})

target_link_directories(${PROJECT_NAME} PUBLIC
  ${LIBFIZMO_LIBRARY_DIRS}
  ${LIBGLKIF_LIBRARY_DIRS}
  ${LIBREMGLK_LIBRARY_DIRS})

set(merged_libs
  ${LIBFIZMO_LIBRARIES}
  ${LIBGLKIF_LIBRARIES}
  ${LIBREMGLK_LIBRARIES})

list(REMOVE_DUPLICATES merged_libs)

target_link_libraries(${PROJECT_NAME} PRIVATE
  ${merged_libs})


install(TARGETS ${PROJECT_NAME})

