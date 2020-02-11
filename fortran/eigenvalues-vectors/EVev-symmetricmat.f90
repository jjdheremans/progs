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
    REAL :: ABSTOL, VL, VU
    ! Array Arguments
    INTEGER, dimension(:), allocatable :: IFAIL, IWORK
    REAL, dimension(:), allocatable :: W, WORK
    REAL, dimension(:,:), allocatable :: Z, A

    ! ============================
    NbModesLooper = 10

    dx = 10.



    
    print *,  "-------------------------------------------------------------------"

    ! Zeros for the lower triangular matrix (more compact because of symmetry of matrix A)
    A = reshape ( [8.1472,0.,0.,2.2690,9.0579,0.,1.2253,0.2001,1.2699], [3,3])
    ! A = reshape ( [8.1472,2.2690,1.2253,2.2690,9.0579,0.2001,1.2253,0.2001,1.2699], [3,3]) ! gives the same result

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
    call ssyevx( JOBZ, RANGE, UPLO, N, A, LDA, VL, VU, IL, IU, ABSTOL, M, W, Z, LDZ, WORK, LWORK, IWORK, IFAIL, INFO)
    LWORK = nint( WORK(1) )
    deallocate( WORK )
    allocate( WORK(LWORK) )
    call ssyevx( JOBZ, RANGE, UPLO, N, A, LDA, VL, VU, IL, IU, ABSTOL, M, W, Z, LDZ, WORK, LWORK, IWORK, IFAIL, INFO)

    nan = IEEE_VALUE(nan, IEEE_QUIET_NAN)
    write (*,'("Number Of Eigen Values found:",2x,i3)') M

    do i = 1, M
        write (*,'("Eigen Value",1x,i3,":",2x,f8.3)') i, W(i) 
    end do

    print *, ""

    
    
end program test_code