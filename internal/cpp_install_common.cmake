
# only add install rules if the target is built
IF(${BUILD_${target}})
    STRING(REGEX REPLACE "${CMAKE_SOURCE_DIR}/(.*)" "\\1" dest_dir ${CMAKE_CURRENT_SOURCE_DIR})
    INSTALL(TARGETS ${target} DESTINATION ${dest_dir} PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE)
    INSTALL(FILES ${_DATA} DESTINATION ${dest_dir} PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE)      
ENDIF()

 