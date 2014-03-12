FIND_SNAP_SYS_PACKAGE(
  NAME                  SYS-avcodec
  LIBRARY_NAMES         libavcodec.so  libavutil.so
  LIBRARY_SEARCH_PATHS  /usr/lib/x86_64-linux-gnu /usr/local/lib/                        
  PATH_TO_A_HEADER      libavcodec/avcodec.h
  INCLUDE_SEARCH_PATHS  /usr/include                        
)

