set( PROJECT_NAME main )
cmake_minimum_required(VERSION 3.1)
Project(${PROJECT_NAME} LANGUAGES Fortran)

file( GLOB_RECURSE

srcFile

main.f90

)

add_executable( ${PROJECT_NAME} ${srcFile}  )

enable_testing()

# add_test(NAME "Test 1" )
add_test( nofail main 1 1 )
add_test( fail main 1 a )



# Si le mot "Erreur" apparait dans la console dans le log, alors le test fail
add_test( NOERROR main 7 6 )
set_tests_properties( NOERROR PROPERTIES 
    PASS_REGULAR_EXPRESSION "Erreur"  
    WILL_FAIL true
    )