
#
#
# Purpose, make a macro to automaticly convert files to headers for inclusion with cross platform support
#
#

# TODO, fix embed adding cmake-embed target but not compiling the headers with the command
# FIX, just compile the embed program and make your stuff manually

set(embed_target_dir ${CMAKE_CURRENT_LIST_DIR})
macro(embed_files)
  set(args ${ARGN})
  if(NOT TARGET cmake-embed)
    project(cmake-embed)
    add_executable(cmake-embed ${embed_target_dir}/embed.cpp)
  endif()
  foreach(i ${ARGN})
    get_filename_component(WORKING_DIR ${i} DIRECTORY)
    add_custom_command(
      TARGET ${project}
      PRE_BUILD
      COMMAND "cmake-embed ${CMAKE_SOURCE_DIR}/${WORKING_DIR}/${i} ${CMAKE_SOURCE_DIR}/${WORKING_DIR}/${i}.h"
      DEPENDS ${CMAKE_SOURCE_DIR}/${WORKING_DIR}/${i}
      COMMENT "Generating header for: ${i}.h"
      WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
      VERBATIM
    )
    #add_dependencies(${project} "${CMAKE_SOURCE_DIR}/${WORKING_DIR}/${i}.h")
  endforeach()
endmacro()

# add_custom_command that doesnt really let us make it a dependancy of
#add_custom_command(
#  COMMAND "cmake-embed ${CMAKE_SOURCE_DIR}/${WORKING_DIR}/${i} ${CMAKE_SOURCE_DIR}/${WORKING_DIR}/${i}.h"
#  DEPENDS cmake-embed
#  DEPENDS ${CMAKE_SOURCE_DIR}/${WORKING_DIR}/${i}
#  COMMENT "Generating header for: ${i}.h"
#  OUTPUT "${CMAKE_SOURCE_DIR}/${WORKING_DIR}/${i}.h"
#  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
#  VERBATIM
#)
