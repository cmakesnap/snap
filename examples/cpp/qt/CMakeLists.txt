CMAKE_MINIMUM_REQUIRED(VERSION 2.8)


CPP_LIBRARY(
  NAME    qttestwindow
  SOURCES MainWindowA.cpp
  HEADERS MainWindowA.h
  LIB_TYPE SHARED
  TOOLS   qt
  QT_UI   MainWindow.ui
)


CPP_BINARY(
  NAME    qttest
  SOURCES main.cpp
          MainWindow.cpp
  HEADERS MainWindow.h
  TOOLS   qt
  QT_UI   MainWindow.ui
)



