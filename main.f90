program ncvars

    use netcdf
    use arg_status, only : get_argnum
    use ncinfo    , only : finfo, ncopen, ncclose, varname_list

    implicit none

    integer :: i
    integer :: argnum
    character(256) :: filename
    type(finfo) :: refer

    call get_argnum(argnum)

    do i = 1, argnum
        write(*,*)
        call get_command_argument(i       , &
                                & filename  )  !! OUT
        write(*,'(A)') trim(filename)

        call ncopen(refer   , &  !! OUT
                  & filename  )  !! IN

        call varname_list(refer)  !! IN

        call ncclose(refer)
    enddo

end program ncvars
    

