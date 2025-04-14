EXE = ncvars
OBJ = arg_status.o str2f.o  ncinfo.o main.o

FC = ifort
FLAGS = -O2 -warn all -traceback

INC = 
LIB = 
INSTALL = 

%.o : %.f90
	${FC} -c $< ${FLAGS} ${INC}

all : ${EXE}

${EXE} : ${OBJ}
	${FC} -o $@ $^ ${LIB}


.PHONY : clean re install

clean :
	rm -fv *.o *.mod ${EXE}

re : clean all

install :
	cp ${EXE} ${INSTALL}/

