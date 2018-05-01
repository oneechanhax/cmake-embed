
#
#
# Purpose, make a macro to automaticly convert files to headers with cross platform support
#
#

macro(embed_files)
  if(NOT TARGET cmake-embed)
    project(cmake-embed)
    add_executable(nekohook embed.cpp)
  endif()
  for()
  foreach(i IN LISTS ARGN)
    get_filename_component(WORKING_DIR ${i} DIRECTORY)
    add_custom_command(
      TARGET ${i}.h
      PRE_BUILD
      cmake-embed "${i}" "${i}.h"
      WORKING_DIRECTORY ${WORKING_DIR}
    )
  endforeach()
endmacro()
