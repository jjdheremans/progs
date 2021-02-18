! Second option - DFTI from Intel MKL Library. --> for intel Compiler only

program test_code

    use MKL_DFTI

    use, intrinsic :: ieee_arithmetic, only: IEEE_Value, IEEE_QUIET_NAN
    
    implicit none 
    
    integer            :: i, N, SIZ, MODE
    double precision, dimension(2) :: tmp2
    double precision, dimension(:), allocatable :: xt
    double complex, dimension(:), allocatable :: Xw, tmp

    ! Own to call to FFT FUNCTIONS
    integer :: lensav, lenwrk, ier, inc 
    double precision, DIMENSION(:), allocatable :: work, wsave

    ! FFTW function 
    type(DFTI_DESCRIPTOR), pointer :: fft_descriptor
    integer :: status 




    N = 100
    SIZ = N/2

    allocate( xt(N) )   ! Temporal representation




    call random_number( xt )
    print *, "Initial vector (time domain):"
    print *, ""
    do i = 1, N
        print *, xt(i)
    end do
    print *, ""

    
    Xw = xt

    ! Configure a Descriptor
    status = DftiCreateDescriptor( fft_descriptor, DFTI_DOUBLE, DFTI_COMPLEX, 1, N )
    status = DftiCommitDescriptor( fft_descriptor )

    ! %% FORWARD FFT %%
    status = DftiComputeForward(fft_descriptor, Xw ) ! get the forward FFT in Xw

    print *, "Intermediate vector (frequency domain):"
    do i = 1, N
        write( *, *) Xw(i)
    end do

    ! %% BACKWARD FFT %%
    status = DftiComputeBackward(fft_descriptor, Xw ) ! get the backward fft in Xw


    ! xt can be recovered dividing by N (non scaled DFFT)
    Xw = Xw / N

    print *, ""
    print *, "Final vector (time domaine)"
    do i = 1, N
        write( *, * ) Xw(i) ! The imag part should be imag
    end do




    deallocate( xt )
    status = DftifreeDescriptor( fft_descriptor )


end program test_code