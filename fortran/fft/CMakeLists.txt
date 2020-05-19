# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% #
# Nom du projet, et nom de l'executable
set( PROJECT_NAME test_code )
# set( LIB_NAME psd )
# set( CMAKE_BUILD_TYPE dev) 
# set( PROG_VERSION 1.0.0 )
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% #

# Set custom compiler for Windows OS.
if ( WIN32 )
    set( COMPILER_NAME "pgfortran" ) # set here your compiler name
    set( PATH_TO_COMPILER "/opt/pgi/linux86-64/19.10/bin/" ) # set here your path to fortran compiler.
    set( CMAKE_Fortran_COMPILER ${COMPILER_NAME} CACHE PATH ${PATH_TO_COMPILER} )
endif()

# Prevent from compiling in the source directory
file(TO_CMAKE_PATH "${PROJECT_BINARY_DIR}/CMakeLists.txt" LOC_PATH)
if(EXISTS "${LOC_PATH}")
    message(FATAL_ERROR "You cannot build in a source directory (or any directory with a CMakeLists.txt file). Please make a build subdirectory. Feel #free to remove CMakeCache.txt and CMakeFiles.")
endif()

# Version requise de CMAKE pour faire tourner le code
cmake_minimum_required( VERSION 3.9 )

#Definition du projet + Language du code à compiler + Version du Code compilé
Project(${PROJECT_NAME} LANGUAGES Fortran)

# set( EXECUTABLE_OUTPUT_PATH "${CMAKE_BINARY_DIR}/${CMAKE_BUILD_TYPE}/bin" )
# set( LIBRARY_OUTPUT_PATH "${CMAKE_BINARY_DIR}/${CMAKE_BUILD_TYPE}/lib" )
# set( CMAKE_Fortran_MODULE_DIRECTORY "${CMAKE_BINARY_DIR}/${CMAKE_BUILD_TYPE}/modules" )

file( GLOB_RECURSE

srcFile

test_code.f90

)

# Search for lapack/blas libraries.
if ( WIN32 )
    find_library ( LAPACK_LIBRARIES 
        NAMES liblapack.lib
        PATHS "C:/Program Files/PGI/win64/19.10/lib" )

    find_library ( BLAS_LIBRARIES 
        NAMES libblas.lib
        PATHS "C:/Program Files/PGI/win64/19.10/lib" )
    elseif()
    find_package(LAPACK REQUIRED)
message("LAPACK_LIBRARIES=${LAPACK_LIBRARIES}")
endif()

message("Blas Library Used: ${BLAS_LIBRARIES}")         # /!\ Used Symbolic link might be confusing.
message("Lapack Library Used: ${LAPACK_LIBRARIES}")     # /!\ Used Symbolic link might be confusing.
# -------- --------- ---------- #


# Adding Libraries
set( LIB_FFT fftpack5.1 )
set( src_fft fftpack5.1.f90 )
add_library( ${LIB_FFT} SHARED ${src_fft} )

# Adding an executable target
add_executable( ${PROJECT_NAME} ${srcFile}  )

# The executable must be linked with used library (/!\ library name!)
target_link_libraries( ${PROJECT_NAME} ${LIB_FFT} )
target_link_libraries( ${PROJECT_NAME} ${BLAS_LIBRARIES} )
target_link_libraries( ${PROJECT_NAME} ${LAPACK_LIBRARIES} )


# The following command provide the possibility to execute the executable by typing "make run" after make
add_custom_target( run ./${PROJECT_NAME} )

