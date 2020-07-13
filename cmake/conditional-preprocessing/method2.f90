program method2

implicit none

CHARACTER(len=10) version   


! Method 2 : Fortran Preprocessing. Works with ifort but not gfortran !!
! ======================================================================

!DEC$ if defined (_WIN32)

    ! WIN32 is turned on for 32 and 64 bits architectures
    print *, 'Hello from Windows OS!'

!DEC$ elseif defined (__linux)

    print *, "Hello from Linux OS"

!DEC$ else

    print *, 'Hello from an unknown exploitation system'

!DEC$ endif



!DEC$ if defined (__GFORTRAN__)

    write ( version, '(i1,".",i1,".",i1)' ) __GNUC__, __GNUC_MINOR__, __GNUC_PATCHLEVEL__
    print *, 'This code was compiled with GNU gfortran Compiler ' // trim( version ) // '.'
    ! ask "gfortran -cpp -dM -E" in terminal for more preprocessor predefined macros

!DEC$ elseif defined (__INTEL_COMPILER)

    print *, 'This code was compiled using Intel Fortran Compiler'

!DEC$ elseif defined (__PGI)

    write ( version, '(i2,".",i2,".",i1)' ) __PGIC__, __PGIC_MINOR__, __PGIC_PATCHLEVEL__
    print *, 'This code was compiled using PGI Compiler ' // trim( version ) // '.'
    ! ask "pgcc -dM -E" in terminal for more preprocessor predefined macros

!DEC$ else 

    print *, 'This code was compiled using an unknown compiler...'

!DEC$ endif


end program method2