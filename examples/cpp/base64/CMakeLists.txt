CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

CPP_LIBRARY(
  NAME      base64 
  SOURCES   cdecode.cpp
            cencode.cpp 
  HEADERS   cdecode.h
            cencode.h
            decode.h
            encode.h
  LIB_TYPE  STATIC
)

CPP_BINARY(
  NAME      base64_test
  SOURCES   base64_test.cpp   
  PACKAGES  //examples/cpp/base64:base64                        
  TEST_SIZE small
)           






