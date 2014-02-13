
# Load support for any CPP tools
FILE(GLOB toolList ${CMAKE_CURRENT_LIST_DIR}/tools/*Tools.cmake)
FOREACH(tool ${toolList})
    #MESSAGE("including tool: ${tool}")
    INCLUDE(${tool})    
    IF(TOOL_ERROR)                 
        RETURN()   
    ENDIF()    
ENDFOREACH(tool ${toolList})


# Compute the uri and target name
PACKAGE_BASENAME_TO_URI(${_NAME} target_uri)
URI_TO_TARGET_NAME(${target_uri} target)

# Compute all package dependencies (transitively)
COMPUTE_PACKAGE_TRANSITIVE_CLOSURE("${_PACKAGES}" missing_package_uris required_package_uris required_libraries required_includes)

RECORD_MISSING_PACKAGES(${target} "${missing_package_uris}")

# Reconfigure the compiler with more helpful default settings
INCLUDE(${cmakesnap_DIR}/internal/cpp_compiler_tweaks.cmake)

# Create symlinks for all the DATA files
SYMLINK_TO_BINARY_DIR("${_DATA}")



