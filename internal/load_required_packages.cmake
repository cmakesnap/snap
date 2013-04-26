# Multiple-inclusion guard
IF(__LOAD_REQUIRED_PACKAGES_INCLUDED)    
    RETURN()
ENDIF()
SET(__LOAD_REQUIRED_PACKAGES_INCLUDED TRUE)

FUNCTION(COMPUTE_PACKAGE_TRANSITIVE_CLOSURE 
  query_package_uris 
  missing_package_uris_out 
  required_package_uris_out 
  required_libraries_out 
  required_includes_out
)
  # Clear output variables
  SET(required_package_uris "")
  SET(missing_package_uris "")
  SET(required_libraries "")
  SET(required_includes "")
  
  IF(NOT query_package_uris)
    RETURN()
  ENDIF()
  
  # Initialize stack for transitive closure search
  SET(uri_stack "")
  FOREACH(uri ${query_package_uris})
    # Ensure uris are in cannonical format: <scheme>://<path1>/<path2>/:<basename>      
    TO_CANONICAL_URI(${uri} cannonical_uri)
    LIST(APPEND uri_stack ${cannonical_uri})    
  ENDFOREACH()  
  
  # Construct transitive closure  
  LIST(LENGTH uri_stack uri_stack_size)  
  WHILE(NOT ${uri_stack_size} EQUAL 0)    
    # Pop package uri from stack and add to the transitive closure
    LIST(GET uri_stack 0 uri)
    LIST(REMOVE_ITEM uri_stack ${uri})
    LIST(APPEND required_package_uris ${uri})
    
    # Find package metadata
    PARSE_URI(${uri} uri_scheme uri_path uri_basename)    
    URI_TO_TARGET_NAME(${uri} target_name)
    
    IF("${uri_scheme}" STREQUAL "PRJ")
      IF(DEFINED ${target_name}_DIR )
        FIND_PACKAGE(${target_name} QUIET NO_MODULE)  #don't let a FindFoo.cmake module file overide a specifed location in Foo_DIR        
      ENDIF()            
    ELSEIF("${uri_scheme}" STREQUAL "SYS")
      IF (NOT DEFINED ${target_name}_FOUND)    
        FIND_PACKAGE(${target_name} QUIET) # should find these in the /internal/modules path
      ENDIF()             
    ELSE()
      MESSAGE(FATAL_ERROR "unknown uri scheme: ${uri_scheme}")
    ENDIF()
    
    # If a package metadata not found, mark it as a missing package     
    IF(NOT ${target_name}_FOUND)      
      LIST(APPEND missing_package_uris ${uri})
      UNSET(${target_name}_DIR CACHE)
      BREAK() # exit the while loop
    # Otherwise, add the package's dependencies to the queue
    ELSE()
      LIST(APPEND required_libraries ${${target_name}_LIBRARIES})
      LIST(APPEND required_includes ${${target_name}_INCLUDE_DIRS})
      # add any packages required by this package if they haven't been processed
      IF(${target_name}_REQUIRED_PACKAGES)      
        # NOTE: This is tricky... This is non-optimal because a package could be
        # repeated... However, the simple optimization of removing the redundant
        # packages may not provide the required link order...     
        LIST(APPEND uri_stack ${${target_name}_REQUIRED_PACKAGES})
      ENDIF()
    ENDIF()   
    LIST(LENGTH uri_stack uri_stack_size)   
  ENDWHILE()
  
  LIST(REMOVE_DUPLICATES missing_package_uris)
  LIST(REMOVE_DUPLICATES required_package_uris)  
  LIST(REMOVE_DUPLICATES required_includes)
  #LIST(REMOVE_DUPLICATES required_libraries) # DONT DO THIS!!! This screws up the link order and will break everything... in a subtle and hard to find way!
  
  # Copy to output variables (notice PARENT_SCOPE required when using function instead of macro)
  set(${missing_package_uris_out} ${missing_package_uris} PARENT_SCOPE)
  set(${required_package_uris_out} ${required_package_uris} PARENT_SCOPE)  
  set(${required_libraries_out} ${required_libraries} PARENT_SCOPE)
  set(${required_includes_out} ${required_includes} PARENT_SCOPE)
ENDFUNCTION()

