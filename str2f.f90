module str2f

    use iso_c_binding, only : C_NULL_CHAR

    implicit none

    private
    public :: str_c2f90

    contains


    pure elemental subroutine str_c2f90(input, output)
        character(*), intent(in)  :: input
        character(*), intent(out) :: output

        integer :: fstrlen
        integer :: last
        integer :: null_idx

        fstrlen = len(output)

        null_idx = SCAN(input, C_NULL_CHAR)
        if (null_idx <= 1) then
            output = trim(input)
            return
        endif

        if (null_idx > fstrlen) then
            last = fstrlen
        else
            last = null_idx - 1
        endif

        output = input(1:last)

    end subroutine str_c2f90


end module str2f

