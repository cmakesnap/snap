# Defines a macro to make it easy to build SWIG ruby bindings for a library 
#
# Required Parameters:
# TARGET _NAME of the python binding
# SOURCES list of source files
# PACKAGES list of packages directly used by the target
#
# Features:
 
FUNCTION(SWIG_PYTHON)
    SET(argList "${ARGN}")
    CMAKE_PARSE_ARGUMENTS("" # Arg prefix is just "_" 
                          "" # Option type arguments
                          "NAME;SOURCE;WRAP_PACKAGE_URI;" # Single value arguments
                          "" # List valued arguments 
                          ${argList} )
    REQUIRE_NOT_EMPTY(_NAME _SOURCE _WRAP_PACKAGE_URI)
    IF(_UNPARSED_ARGUMENTS)
      MESSAGE(FATAL_ERROR "unexpected arguments: ${_UNPARSED_ARGUMENTS}")
    ENDIF()
        
    PACKAGE_BASENAME_TO_URI(${_NAME} target_uri)
    URI_TO_TARGET_NAME(${target_uri} target) # uri of the new bindings package to be created
    URI_TO_TARGET_NAME(${_WRAP_PACKAGE_URI} wrap_target_name) # uri of the package to be wrapped
    
    # Compute all package dependencies (transitively)
    COMPUTE_PACKAGE_TRANSITIVE_CLOSURE("${_WRAP_PACKAGE_URI}" missing_package_uris required_package_uris required_libraries required_includes)
    RECORD_MISSING_PACKAGES(${target} "${missing_package_uris}")
    # Use cmake's system install SWIG module
    FIND_PACKAGE(SWIG)
    INCLUDE(${SWIG_USE_FILE})
    
    # Keep from cluttering the CMake UI
    MARK_AS_ADVANCED(SHARED_PTHREAD_LIBRARY SWIG_DIR SWIG_EXECUTABLE SWIG_VERSION)
    
    FIND_PACKAGE(PythonLibs)
    INCLUDE_DIRECTORIES(${PYTHON_INCLUDE_PATH} ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_SOURCE_DIR} ${required_includes})
    SET(CMAKE_SWIG_FLAGS "")
    SET_SOURCE_FILES_PROPERTIES(${_SOURCE} PROPERTIES CPLUSPLUS ON)
    SWIG_ADD_MODULE(${_NAME} python ${_SOURCE}) #TODO(heathkh): modifty SWIG_ADD_MODULE to use our custom target name scheme but preserve the output filename
    
    #TODO(heathkh): Reenable this once the SWIG macro is reconfigured to user our target names
    #ADD_LIBRARY_TARGET_BUILD_FLAG(${SWIG_MODULE_${_NAME}_REAL_NAME})
    
    # This makes sure CMAKE knows to build all of our dependencies first
    URIS_TO_TARGET_NAMES("${required_package_uris}" required_package_target_names)
    SWIG_LINK_LIBRARIES(${_NAME} ${PYTHON_LIBRARIES} ${required_libraries})
    ADD_DEPENDENCIES(${SWIG_MODULE_${_NAME}_REAL_NAME} ${required_package_target_names})
    
    SET("${target}_DIR" ${CMAKE_CURRENT_BINARY_DIR} CACHE PATH "Path to package ${target_uri}" FORCE)
    MARK_AS_ADVANCED("${target}_DIR")
    CONFIGURE_FILE("${cmakesnap_DIR}/internal/config.cmake.in"
                    ${CMAKE_CURRENT_BINARY_DIR}/${target}Config.cmake @ONLY IMMEDIATE)
    
    CREATE_PYTHON_INIT_FILES()
    STRING(REGEX REPLACE "${CMAKE_SOURCE_DIR}/(.*)" "\\1" dest_dir ${CMAKE_CURRENT_SOURCE_DIR})    
    INSTALL(FILES "${CMAKE_CURRENT_BINARY_DIR}/${_NAME}.py" DESTINATION ${dest_dir} PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE)
    INSTALL(FILES "${CMAKE_CURRENT_BINARY_DIR}/_${_NAME}.so" DESTINATION ${dest_dir} )
    INCLUDE(${cmakesnap_DIR}/internal/cpp_compiler_tweaks.cmake)    
    
    # Update status message
    DISPLAY_PACKAGE_STATUS(
      TYPE         "PY SWIG"
      URI          ${target_uri}     
      MISSING_URIS ${missing_package_uris}
    )    

ENDFUNCTION()










