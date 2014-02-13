#check if we use Qt

SET(cur_tool qt)
LIST(APPEND validConfigFlags ${cur_tool}) 
LIST_CONTAINS("${_TOOLS}" ${cur_tool} tool_requested)
#MESSAGE(STATUS "_TOOLS ${_TOOLS}")
    
IF(tool_requested)
    #MESSAGE(STATUS "Configuring project to use Qt")
    #MESSAGE(STATUS "Qt Forms files (QT_UI): ${_QT_UI}")
                      
    SET(Qt4_FIND_QUIETLY TRUE) #TODO(heathkh): Check if this is a built-in command in modern cmake?
    FIND_PACKAGE(Qt4) #load macros we need
    mark_as_advanced(FORCE QT_QMAKE_EXECUTABLE)
            
    IF(NOT QT4_FOUND)
        SET(TOOL_ERROR TRUE)
        SET(TOOL_ERROR_MSG "Qt4 not found.  Requested TOOL 'qt' unavailable.")
    ELSE()                
        LIST(APPEND _PACKAGES "SYS://qt4") #add to list of packges to link against
            
        IF(_HEADERS)
            QT4_WRAP_CPP(generatedSources ${_HEADERS})            
            LIST(APPEND _SOURCES ${generatedSources})    
        ENDIF()
            
        IF(_QT_UI)
          QT4_WRAP_UI(generateHeaders ${_QT_UI} )
          LIST(APPEND _HEADERS ${generateHeaders})
        ENDIF()
        #MESSAGE("sources : ${sources}")
        #MESSAGE("headers : ${headers}")
        
        # Don't forget to include output directory, otherwise
        # the UI file won't be wrapped!
        include_directories(${CMAKE_CURRENT_BINARY_DIR})    
    ENDIF()
                
ENDIF()



