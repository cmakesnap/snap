CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

JAVA_LIBRARY (
  NAME       mylib
  SOURCES    MyLib.java  
)

JAVA_BINARY (
  NAME       hellosnap
  SOURCES    HelloSnap.java
  MAIN_CLASS HelloSnap
)

