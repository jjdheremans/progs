module debugging_tools

    implicit none

    contains 


    ! write matrix of single precision
    subroutine write_matrix_sp( filename, matrix )

        character(len=*), intent(in) :: filename
        real,  dimension(:,:), intent(in) :: matrix
        integer :: fileunit

        open( unit = fileunit, file = filename )

        write( fileunit, * ) matrix

        ! import this matrix with "read_vector_matrixF" function in python (from debugging_tools)
        ! import this matrix with "" in matlab

    end subroutine


    ! write matrix of double precision
    subroutine write_matrix_dp( filename, matrix )

        character(len=*), intent(in) :: filename
        double precision,  dimension(:,:), intent(in) :: matrix
        integer :: fileunit

        open( unit = fileunit, file = filename )

        write( fileunit, * ) matrix

        ! import this matrix with "read_vector_matrixF" function in python (from debugging_tools)
        ! import this matrix with "" in matlab

    end subroutine

    
    ! write matrix of single precision complex numbers
    subroutine write_matrix_spc( filename, matrix )

        character(len=*), intent(in) :: filename
        complex, dimension(:,:), intent(in) :: matrix
        integer :: fileunit, i, j 

        open( unit = fileunit, file = filename )

        do j = 1, size(matrix, 2)
            do i = 1, size( matrix, 1)
                write( fileunit, '(F12.4," + ",F12.4,"*1i")' ) real( matrix(i,j) ), imag( matrix(i,j) )
            end do 
        end do

        ! import this matrix with "read_vector_matrixF" function in python (from debugging_tools)
        ! import this matrix with "" in matlab
        
    end subroutine


    ! write matrix of double precision complex numbers
    subroutine write_matrix_dpc( filename, matrix )

        character(len=*), intent(in) :: filename
        double complex, dimension(:,:), intent(in) :: matrix
        integer :: fileunit, i, j 

        open( unit = fileunit, file = filename )

        do i = 1, size(matrix,2)
            do j = 1, size( matrix, 1)
                write( fileunit, '(F12.4," + ",F12.4,"*1i")' ) real( matrix(i,j) ), imag( matrix(i,j) )
            end do 
        end do

        ! import this matrix with "read_vector_matrixF" function in python (from debugging_tools)
        ! import this matrix with "" in matlab
        
    end subroutine


end module