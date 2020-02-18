# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% #
# Nom du projet, et nom de l'executable
set( PROJECT_NAME test_code )
# set( LIB_NAME psd )
# set( CMAKE_BUILD_TYPE dev) 
# set( PROG_VERSION 1.0.0 )
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% #


# Prevent from compiling in the source directory
file(TO_CMAKE_PATH "${PROJECT_BINARY_DIR}/CMakeLists.txt" LOC_PATH)
if(EXISTS "${LOC_PATH}")
    message(FATAL_ERROR "You cannot build in a source directory (or any directory with a CMakeLists.txt file). Please make a build subdirectory. Feel #free to remove CMakeCache.txt and CMakeFiles.")
endif()

# Version requise de CMAKE pour faire tourner le code
cmake_minimum_required( VERSION 3.9 )
# Nom du projet, et nom de l'executable

#Definition du projet + Language du code � compiler + Version du Code compilé
Project(${PROJECT_NAME} LANGUAGES Fortran)

file( GLOB_RECURSE

srcFile

affiche_tab.f90 test_code.f90

)


# -------- OPTION #1 ---------- # --> for cmake version older than 3.9

# find_package( OpenMP REQUIRED )
# # Adding an executable target
# add_executable( ${PROJECT_NAME} ${srcFile}  )
# # The executable must be linked with used library (/!\ library name!)
# target_link_libraries( ${PROJECT_NAME} PRIVATE "${OpenMP_Fortran_FLAGS}")
# # Adding flag to compile options
# target_compile_options( ${PROJECT_NAME} PRIVATE "${OpenMP_Fortran_FLAGS}")

# -------- --------- ---------- #



# -------- OPTION #2 ---------- # --> for cmake versions newer than 3.9

find_package(OpenMP REQUIRED)
# Adding an executable target
add_executable( ${PROJECT_NAME} ${srcFile}  )
# The executable must be linked with used library (/!\ library name!)
target_link_libraries( ${PROJECT_NAME} PRIVATE OpenMP::OpenMP_Fortran )

# -------- --------- ---------- #



# The following command provide the possibility to execute the executable by typing "make run" after make
add_custom_target( run ./${PROJECT_NAME} )

