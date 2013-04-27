# Defines a macro to make it easy to build a java library 

MACRO(JAVA_LIBRARY)
  SET(argList "${ARGN}")
  INCLUDE(${cmakesnap_DIR}/internal/java_common.cmake)
  FIND_PACKAGE(Java)
  INCLUDE(UseJava)
  ADD_JAR(${target} ${_SOURCES})
  ADD_LIBRARY_TARGET_BUILD_FLAG(${target})
  DISPLAY_PACKAGE_STATUS(
    TYPE         "JAVA LIB"
    URI          ${target_uri}
    MISSING_URIS ${missing_package_uris}
  )
ENDMACRO(JAVA_LIBRARY)










