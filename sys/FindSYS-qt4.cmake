FIND_SNAP_SYS_PACKAGE(
  NAME                  SYS-qt4
  LIBRARY_NAMES         libQtCore.so  libQtGui.so   libQtNetwork.so   libQtXml.so
                        #libQt3Support.so  libQtCLucene.so  libQtDBus.so libQtScript.so   libQtSql.so  libQtTest.so libQtDeclarative.so  libQtDesigner.so libQtDesignerComponents.so     libQtHelp.so  libQtOpenGL.so   libQtScriptTools.so  libQtSvg.so  libQtXmlPatterns.so  
  LIBRARY_SEARCH_PATHS  /usr/local/lib /usr/lib/x86_64-linux-gnu                       
  PATH_TO_A_HEADER      Qt/qwidget.h
  INCLUDE_SEARCH_PATHS  /usr/include/qt4/                
)


