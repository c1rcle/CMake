#

# check for some ANSI flags in the CXX compiler if it is not gnu
IF(NOT CMAKE_COMPILER_IS_GNUCXX)
  INCLUDE(${CMAKE_ROOT}/Modules/TestCXXAcceptsFlag.cmake)
  SET(CMAKE_TRY_ANSI_CXX_FLAGS "")
  IF(CMAKE_SYSTEM MATCHES "IRIX.*")
    SET(CMAKE_TRY_ANSI_CXX_FLAGS "-LANG:std")
  ENDIF(CMAKE_SYSTEM MATCHES "IRIX.*")
  IF(CMAKE_SYSTEM MATCHES "OSF.*")
    SET(CMAKE_TRY_ANSI_CXX_FLAGS "-std strict_ansi -nopure_cname")
  ENDIF(CMAKE_SYSTEM MATCHES "OSF.*")
  # if CMAKE_TRY_ANSI_CXX_FLAGS has something in it, see
  # if the compiler accepts it
  IF( CMAKE_TRY_ANSI_CXX_FLAGS MATCHES ".+")
    CHECK_CXX_ACCEPTS_FLAG(${CMAKE_TRY_ANSI_CXX_FLAGS} CMAKE_CXX_ACCEPTS_FLAGS)
    # if the compiler liked the flag then set CMAKE_ANSI_CXXFLAGS
    # to the flag
    IF(CMAKE_CXX_ACCEPTS_FLAGS)
      SET(CMAKE_ANSI_CXXFLAGS ${CMAKE_TRY_ANSI_CXX_FLAGS})
    ENDIF(CMAKE_CXX_ACCEPTS_FLAGS)
  ENDIF( CMAKE_TRY_ANSI_CXX_FLAGS MATCHES ".+")
ENDIF(NOT CMAKE_COMPILER_IS_GNUCXX)

INCLUDE(${CMAKE_ROOT}/Modules/TestForANSIStreamHeaders.cmake)
INCLUDE(${CMAKE_ROOT}/Modules/CheckIncludeFileCXX.cmake)
INCLUDE(${CMAKE_ROOT}/Modules/TestForSTDNamespace.cmake)
INCLUDE(${CMAKE_ROOT}/Modules/TestForANSIForScope.cmake)
CHECK_INCLUDE_FILE_CXX("sstream" CMAKE_HAS_ANSI_STRING_STREAM)
IF(NOT CMAKE_HAS_ANSI_STRING_STREAM)
  SET(  CMAKE_NO_ANSI_STRING_STREAM 1 CACHE INTERNAL 
       "Does the compiler support sstream or stringstream.")
ENDIF(NOT CMAKE_HAS_ANSI_STRING_STREAM)
