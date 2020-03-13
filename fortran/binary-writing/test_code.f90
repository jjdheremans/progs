program test_code

    use, intrinsic :: ieee_arithmetic, only: IEEE_Value, IEEE_QUIET_NAN
    !$ use OMP_LIB
    
    implicit none 
    
    integer  :: N,M, i, j
    real, dimension(:,:), allocatable :: mat
    CHARACTER(len=8) :: filename
    
    M = 10
    N = 4

    allocate( mat(M,N) )
    call random_number( mat )
    mat = mat * 100.
    print *, mat

    ! OPEN THE FILE AS UNFORMATTED (ONE LONG ARRAY WILL BE STORED), WITH STREAM ACCESS.
    filename = "bin_file" 
    open(unit=1, file = FileName,form='unformatted',access='stream',status="replace" )

    ! METHOD 1: Loop over element
    write(1) M
    write(1) N
    do  j = 1, N
        do i = 1, M
            write(1) mat(i,j)
        end do
    end do

    ! METHOD 2: without loop
    write(1) M
    write(1) N
    write(1) mat

    ! METHOD 1 AND 2 GIVE THE SAME RESULTS.
    
end program test_code