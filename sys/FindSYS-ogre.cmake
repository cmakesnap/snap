FIND_SNAP_SYS_PACKAGE(
  NAME                  SYS-ogre
  LIBRARY_NAMES         libOgreMain.so libOgrePaging.so libOgreProperty.so libOgreRTShaderSystem.so libOgreTerrain.so
  LIBRARY_SEARCH_PATHS  /usr/local/lib                       
  PATH_TO_A_HEADER      Ogre.h
  INCLUDE_SEARCH_PATHS  /usr/local/include/OGRE/   
)


#Plugin_BSPSceneManager.so
#Plugin_CgProgramManager.so
#Plugin_OctreeSceneManager.so
#Plugin_OctreeZone.so
#Plugin_ParticleFX.so
#Plugin_PCZSceneManager.so
