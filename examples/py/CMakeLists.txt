CMAKE_MINIMUM_REQUIRED(VERSION 2.6)

CPP_LIBRARY(
  NAME     breaking_news
  SOURCES  breaking_news.cpp
  HEADERS  breaking_news.h
  PACKAGES //examples:myproto  # a proto library        
  LIB_TYPE STATIC_AND_SHARED
  SWIG_PY  py_breaking_news.i
)

PY_BINARY(
  NAME      test_breaking_news
  SOURCES   test_breaking_news.py
  PACKAGES  //examples/py:py_breaking_news  # a c++ library with python bindings  
  TEST_SIZE small            
)
