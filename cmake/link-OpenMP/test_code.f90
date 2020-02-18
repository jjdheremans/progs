program test_code

    use, intrinsic :: ieee_arithmetic, only: IEEE_Value, IEEE_QUIET_NAN
    !$ use OMP_LIB
    
    implicit none 
    
    integer             :: NbModes, NbNodes, i, j, N
    real                :: dx, nan, phi
    DOUBLE PRECISION :: ti, tf
    real, pointer       :: pta, ptb, a, b
    real, dimension(:,:), allocatable :: Xmod, mat
    real, dimension(:), allocatable :: vec


    N = 10000
    NbModes = 1000
    NbNodes = 1000
    print *,  "-------------------------------------------------------------------"
    print *, "Timing code performance in single-threading..."
    allocate( Xmod(N, NbNodes) )
    allocate( mat( NbNodes, NbModes ) )
    allocate( vec( NbModes) )
    
    call random_number( mat )
    call random_number( vec )

    ti = omp_get_wtime(  )

    do i = 1, N
        call random_number( phi )
        Xmod(i,:) = matmul( mat, phi * vec)
    end do
    
    ! call affiche_tab( Xmod, [N, NbNodes] )
    tf = omp_get_wtime(  )

    write (*, '("Solution 1 --> Total Elapsed time: ",f8.4," seconds")') tf - ti
    print *,  "-------------------------------------------------------------------"
    print *, "Timing code performance in multi-threading..."

    ti =  omp_get_wtime()

    !$OMP PARALLEL DO
    do i = 1, N
        call random_number( phi )
        Xmod(i,:) = matmul( mat, phi * vec)
    end do
    !$OMP END PARALLEL DO

    ! call affiche_tab( Xmod, [N, NbNodes] )
    tf =  omp_get_wtime()

    write (*, '("Solution 2 --> Total Elapsed time: ",f8.4," seconds")') tf - ti
    print *,  "-------------------------------------------------------------------"

end program test_code