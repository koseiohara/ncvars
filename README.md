# NCVARS

## Test Environment
CentOS Linux 7  
NetCDF C 4.9.3  
NetCDF Fortran 4.6.2  

## Install and Build
Install the source code by cloning this repository:
```sh
git clone https://github.com/koseiohara/ncvars.git
cd ncvars
```

### Makefile
Rewrite the Makefile for your environment.  
You can change the definisions of `INC`, `LIB`, and `INSTALL`.
`INC` and `LIB` are the include-path and library-path for NetCDF-Fortran.
You may be able to check these settings using commands below:
```sh
nf-config --fflags
nf-config --flibs
```
If these commands are available, copy these results to `INC` and `LIB`.  
`INSTALL` is the path to which you want to copy the executable file.  

After makeing these settings, execute the Makefile
```sh
make
make install
```
`ncvars` will be made and copied to the directory specified by `INSTALL`.  

Add the `INSTALL` directory to the environment variable `PATH`
```sh
export PATH="your-path:${PATH}"
```

## Usage
```sh
ncvars file1.nc file2.nc ...
```
You can specify any number of NetCDF files.


