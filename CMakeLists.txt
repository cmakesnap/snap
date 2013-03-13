CMAKE_MINIMUM_REQUIRED(VERSION 2.8)
# enables CMakeSNAP support in all subdirectories..
SET(cmakesnap_DIR ${CMAKE_CURRENT_SOURCE_DIR})
FIND_PACKAGE(cmakesnap)
ADD_SUBDIRECTORY(examples) 
