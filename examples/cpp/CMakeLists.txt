CMAKE_MINIMUM_REQUIRED(VERSION 2.8)


ADD_SUBDIRECTORY(base64) # contains a standard C++ library package 

# Example of a header only C++ library package
CPP_LIBRARY(
  NAME      headerlib
  HEADERS   handy_header_lib.hpp
  LIB_TYPE  HEADER
)           

# Example of a C++ binary that uses both a standard and header only library  
CPP_BINARY(
  NAME      hello_snap
  SOURCES   hello_snap.cpp   
  PACKAGES  //examples/cpp/base64:base64  # a static lib  
            //examples/cpp:headerlib  # a header only lib                          
)           


