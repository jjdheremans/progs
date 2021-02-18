! This program calculates the eigen values and vectors of a given real symmetric matrix.
program test_code

    use, intrinsic :: ieee_arithmetic, only: IEEE_Value, IEEE_QUIET_NAN

    implicit none 
    
    integer             :: NbModesLooper, i, NbVec, NbHisto
    real                :: dx, nan


    ! ============================
    !! eigen values decomposition
    ! Scalar Arguments
    CHARACTER(len=1) :: JOBZ, RANGE, UPLO
    INTEGER :: IL, INFO, IU, LDA, LDZ, LWORK, M, N
    double precision :: ABSTOL, VL, VU
    ! Array Arguments
    INTEGER, dimension(:), allocatable :: IFAIL, IWORK
    double precision, dimension(:), allocatable :: W, RWORK
    double complex, dimension(:), allocatable :: WORK

    ! A and z can be allocatable or pointers.
    double complex, dimension(:,:), pointer ::  A, z
    ! REAL, dimension(:,:), allocatable ::  A, z

    ! ============================
    NbModesLooper = 10

    dx = 10.



    
    print *,  "-------------------------------------------------------------------"
    allocate( A(3,3) )

    A(1,1) = cmplx(0.948393,0.000000) 
    A(1,2) = cmplx(0.871405,0.553410) 
    A(1,3) = cmplx(0.407925,0.331334) 
    A(2,1) = cmplx(0.871405,-0.553410) 
    A(2,2) = cmplx(1.586483,0.000000) 
    A(2,3) = cmplx(0.625496,0.078590) 
    A(3,1) = cmplx(0.407925,-0.331334) 
    A(3,2) = cmplx(0.625496,-0.078590) 
    A(3,3) = cmplx(0.570422,0.000000) 

    NbVec = 2
    NbHisto = 3

    ! CALCUL DES VALEURS PROPRES.
    JOBZ = 'V'  ! compute EV and ev
    RANGE = 'I' ! intervalle
    UPLO = 'U'  ! not used anymore
    N = 3       ! Matrix Order
    LDA = N
    IL = 1
    IU = NbVec
    ABSTOL = 0
    M = IU - IL + 1
    allocate( W(N) )
    allocate( Z(NbHisto,NbVec) )
    LDZ = NbHisto
    LWORK = -1
    allocate( WORK(1) )
    allocate( IWORK(5*N) )
    allocate( IFAIL(N) )
    allocate( RWORK(7*N) )
    call zheevx( JOBZ, RANGE, UPLO, N, A, LDA, VL, VU, IL, IU, ABSTOL, M, W, Z, LDZ, WORK, LWORK, RWORK, IWORK, IFAIL, INFO)
    LWORK = int( WORK(1) )
    deallocate( WORK )
    allocate( WORK(LWORK) )
    call zheevx( JOBZ, RANGE, UPLO, N, A, LDA, VL, VU, IL, IU, ABSTOL, M, W, Z, LDZ, WORK, LWORK, RWORK, IWORK, IFAIL, INFO)

    nan = IEEE_VALUE(nan, IEEE_QUIET_NAN)
    write (*,'("Number Of Eigen Values found:",2x,i3)') M

    do i = 1, M
        write (*,'("Eigen Value",1x,i3,":",2x,f8.3)') i, W(i)
    end do

    print *, ""

    
    
end program test_code