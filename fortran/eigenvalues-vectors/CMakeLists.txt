# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% #
# Nom du projet, et nom de l'executable
set( PROJECT_NAME Eigenvalues )

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% #

# Version requise de CMAKE pour faire tourner le code
cmake_minimum_required(VERSION 3.1)

#Definition du projet + Language du code � compiler + Version du Code compilé
Project(${PROJECT_NAME} LANGUAGES Fortran)

file( GLOB_RECURSE

srcFile

EVev-hermitianmat.f90

)

# -------- OPTION #1 ---------- #
# Native way of linking LAPACK/BLAS libraries in Linux (=automatic reasearch)
find_package(LAPACK REQUIRED)
message("LAPACK_LIBRARIES=${LAPACK_LIBRARIES}")
# -------- --------- ---------- #

# # -------- OPTION #2 ---------- #
# # If another LAPACK/BLAS version must be found, find_library must be used. Their path must be specified.
# # Example: Here, Open version of lapack and Blas are seeked:
# find_library ( LAPACK_LIBRARIES 
#     NAMES liblapack.so
#     PATHS /usr/lib/x86_64-linux-gnu/openblas )

# find_library ( BLAS_LIBRARIES 
#     NAMES libblas.so
#     PATHS /usr/lib/x86_64-linux-gnu/openblas )

# message("Blas Library Used: ${BLAS_LIBRARIES}")         # /!\ Used Symbolic link might be confusing.
# message("Lapack Library Used: ${LAPACK_LIBRARIES}")     # /!\ Used Symbolic link might be confusing.
# # -------- --------- ---------- #

# Adding an executable target
add_executable( ${PROJECT_NAME} ${srcFile}  )

# The executable must be linked with used library (/!\ library name!)
target_link_libraries( ${PROJECT_NAME} ${LAPACK_LIBRARIES} )

# The following command provide the possibility to execute the executable by typing "make run" after make
add_custom_target( run ./${PROJECT_NAME} )

