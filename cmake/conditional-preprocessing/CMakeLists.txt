# Compile the method1.f90 file, and set the appropriate compilation flag depending on the situation.
set( PROJECT_NAME foo )
project( ${PROJECT_NAME} LANGUAGES Fortran )
enable_language( Fortran )
cmake_minimum_required(VERSION 3.0)
set( srcfiles "method1.f90" )
add_executable( ${PROJECT_NAME} ${srcfiles} )

message( "Compilateur ID: ${CMAKE_Fortran_COMPILER_ID}" )

if ( ${CMAKE_Fortran_COMPILER_ID} MATCHES "Intel" )
    SET( CMAKE_Fortran_FLAGS "-fpp" )

elseif( ${CMAKE_Fortran_COMPILER_ID} MATCHES "GNU" )
    SET( CMAKE_Fortran_FLAGS "-cpp" )

elseif( ${CMAKE_Fortran_COMPILER_ID} MATCHES "PGI" )
    SET( CMAKE_Fortran_FLAGS "-cpp" )

endif()