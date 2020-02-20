program test_code

    use, intrinsic :: ieee_arithmetic, only: IEEE_Value, IEEE_QUIET_NAN
    !$ use OMP_LIB
    
    implicit none 
    
    integer            :: i, N, SIZ, MODE
    real, dimension(2) :: tmp2
    real, dimension(:), allocatable :: xt
    complex, dimension(:), allocatable :: Xw, tmp

    ! Own to call to FFT FUNCTIONS
    integer :: lensav, lenwrk, ier, inc 
    real, DIMENSION(:), allocatable :: work, wsave





    N = 100
    SIZ = N/2

    allocate( xt(N) )   ! Temporal representation
    allocate( Xw(N) )   ! Frequency representation
    allocate( tmp(N) )  ! Complex temporary vector






    MODE = 3

    IF ( MODE == 1 ) then ! FORWARD FFT 

        call random_number( xt )
        print *, "Initial vector (time domain):"
        print *, ""
        do i = 1, N
            print *, xt(i)
        end do
        print *, ""

        ! %% FORWARD FFT %%
        ! 3rd input to cfft1f is a in/out argument. For this reason, the input must be given as a complex number even if imag. part is zero.
        tmp = xt ! 
        lensav = 2*N + int ( log ( real ( n , kind=4 ) ) / log ( 2. ) ) + 4
        lenwrk = 2*N
        inc = 1
        allocate( work(lenwrk))
        allocate( wsave(lensav))

        call cfft1i ( N, wsave, lensav, ier )                               ! Prepare call to fft
        call cfft1f ( N, inc, tmp, N, wsave, lensav, work, lenwrk, ier )    ! forward fft. 
        
        ! The output Xw of cfft1f is equivalent to the output of "fft(xt)/N" in matlab:
        Xw = tmp 

        print *, ""
        print *, "Final vector (frequency domain):"
        do i = 1, N
            write( *, '(f8.4,"+",f8.4,"i")') Xw(i)
        end do

    end if






    IF ( MODE == 2 ) then ! BACKWARD FFT 


        print *, "Initial vector (frequency domain):"
        print *, ""
        do i = 1, N
            call random_number( tmp2 )
            Xw(i) = cmplx( tmp2(1), tmp2(2) )
            write( *, '(f8.4,"+",f8.4,"i")') Xw(i)
        end do
        print *, ""

        ! %% BACKWARD FFT %%
        tmp = Xw ! 
        lensav = 2*N + int ( log ( real ( n , kind=4 ) ) / log ( 2. ) ) + 4
        lenwrk = 2*N
        inc = 1
        allocate( work(lenwrk))
        allocate( wsave(lensav))

        call cfft1i ( N, wsave, lensav, ier )                               ! Prepare call to fft
        call cfft1f ( N, inc, tmp, N, wsave, lensav, work, lenwrk, ier )    ! forward fft. 
        
        ! The output xt of cfft1f is equivalent to the output of "ifft(Xw)*N" in matlab:
        xt = real( tmp )

        print *, ""
        print *, "Final vector (time domaine)"
        do i = 1, N
            write( *, '(f8.4,"+",f8.4,"i")') tmp(i) ! The imag part should be imag
        end do

    END IF







    IF ( MODE ==3 ) then 


        call random_number( xt )
        print *, "Initial vector (time domain):"
        print *, ""
        do i = 1, N
            print *, xt(i)
        end do
        print *, ""

        ! %% FORWARD FFT %%
        ! 3rd input to cfft1f is a in/out argument. For this reason, the input must be given as a complex number even if imag. part is zero.
        tmp = xt ! 
        lensav = 2*N + int ( log ( real ( n , kind=4 ) ) / log ( 2. ) ) + 4
        lenwrk = 2*N
        inc = 1
        allocate( work(lenwrk))
        allocate( wsave(lensav))

        call cfft1i ( N, wsave, lensav, ier )                               ! Prepare call to fft
        call cfft1f ( N, inc, tmp, N, wsave, lensav, work, lenwrk, ier )    ! forward fft. 
        
        ! The output Xw of cfft1f is equivalent to the output of "fft(xt)/N" in matlab:
        Xw = tmp 

        print *, "Intermediate vector (frequency domain):"
        do i = 1, N
            write( *, '(f8.4,"+",f8.4,"i")') Xw(i)
        end do


        ! %% BACKWARD FFT %%
        call cfft1b ( N, inc, tmp, N, wsave, lensav, work, lenwrk, ier )    ! backward fft. 

        ! The output xt of cfft1b is equivalent to the output of "ifft(Xw)*N" in matlab:
        xt = real( tmp )

        print *, ""
        print *, "Final vector (time domaine)"
        do i = 1, N
            write( *, '(f8.4,"+",f8.4,"i")') tmp(i) ! The imag part should be imag
        end do


    end if


end program test_code