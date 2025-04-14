module ncinfo

    use iso_c_binding
    use str2f, only : str_c2f90
    use netcdf

    implicit none

    private
    public :: finfo, ncopen, ncclose, varname_list


    type finfo
        private
        integer        :: ncid
        character(256) :: file
    end type finfo


    interface
        function NC_INQ_VARNAME(ncid, varid, name) bind(C, name="nc_inq_varname")
            use iso_c_binding
            implicit none
            integer(c_int), value  :: ncid
            integer(c_int), value  :: varid
            character(kind=c_char) :: name(*)
            integer(c_int)         :: NC_INQ_VARNAME
        end function NC_INQ_VARNAME
    end interface


    contains


    subroutine ncopen(ftype, file)
        type(finfo) , intent(out) :: ftype
        character(*), intent(in)  :: file

        integer :: stat

        !! OPEN
        stat = NF90_OPEN(PATH=file        , &  !! IN
                       & MODE=NF90_NOWRITE, &  !! IN
                       & NCID=ftype%ncid    )  !! OUT

        if (stat /= NF90_NOERR) then
            write(0,'(A)') '<ERROR STOP>'
            write(0,'(A)') trim(file) // ' : no such file'
            STOP
        endif

        ftype%file          = trim(file)
    
    end subroutine ncopen


    subroutine ncclose(ftype)
        type(finfo), intent(inout) :: ftype
        
        integer :: stat

        stat = NF90_CLOSE(ftype%ncid)  !! IN

        ftype%ncid = -999999
        ftype%file = 'CLOSED'

    end subroutine ncclose


    subroutine varname_list(ftype)
        type(finfo), intent(in) :: ftype
        integer :: i
        integer :: stat
        character(256) :: cvarname
        character(256) :: fvarname

        i = 0
        write(*,'(A3,3X,A)') 'ID', 'VARIABLE'
        do
            stat = NC_INQ_VARNAME(NCID=ftype%ncid, &
                                & VARID=i        , &
                                & NAME=cvarname    )
            if (stat /= NF90_NOERR) then
                exit
            endif

            call str_c2f90(cvarname, &  !! IN
                         & fvarname  )  !! OUT
            write(*,'(I3,A)') i, ' : ' // trim(fvarname)
            i = i + 1
        enddo

    end subroutine varname_list


end module ncinfo

