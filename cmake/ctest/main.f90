! This program calculates the eigen values and vectors of a given real symmetric matrix.
program test_code

    use, intrinsic :: ieee_arithmetic, only: IEEE_Value, IEEE_QUIET_NAN

    implicit none 
    
    character(len=50) :: arg1, arg2
    integer              :: x, y, z

    CALL get_command_argument( 1, arg1 )   ! read first argument
    CALL get_command_argument( 2, arg2 )   ! read second argument

    read( arg1, * ) x
    read( arg2, * ) y

    z = x + y 


    write ( *,  "('x=',i1)") x
    write ( *,  "('y=',i1)") y
    write ( *,  "('x+y=',i1)") z

    if ( z > 10 ) then 
        print *, "Erreur" 
    end if
    
end program test_code