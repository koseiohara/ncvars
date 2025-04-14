module arg_status

    implicit none

    private
    public :: get_argnum

    contains


    subroutine get_argnum(argnum)
        integer, intent(out) :: argnum

        argnum = command_argument_count()
        if (argnum == 0) then
            write(0,'(A)') 'ncvars [file]'
            write(0,'(A)') 'No command line argument specified'
            STOP
        endif

    end subroutine get_argnum


end module arg_status

