
        SUBROUTINE GRIDAER 

        INCLUDE '../INCLUDECLIM/parND.inc'
	CHARACTER dircoup*2
        
        REAL  Z(10000), NPART(10000),RPART(10000),ctop,cdeck,N

        INCLUDE '../INCLUDECLIM/comALTBLOK.inc'
        INCLUDE '../INCLUDECLIM/comCPART.inc'

c A. Zsom
c the cloud file is read in from CHEMCLIM/IO/cloud.dat
	dircoup = 'IO'
      	OPEN(UNIT=234,FILE= dircoup//'/cloud.dat')
	read(234,*)N
	if (N.gt.10000) then
		write(*,*)'The size of arrays Z, NPART, RPART are not large enough.'
		stop
	endif
	write(*,*)N
	DO i=1,N
		read(234,*)Z(i),RPART(i),NPART(i)
	enddo
	close(234)


        DO I =1,18
         RPART(I) = RPART(I)
        ENDDO 
        DO IL = 1,ND
        	I = 1
        	IF (ALT(IL).LE.Z(I)) THEN
        		PARTICLES(IL) = 0.
        		RAER(IL) = RPART(I)
        		GOTO 4
        	ENDIF
    1   	IF (ALT(IL).GT.Z(I)) THEN
        		I = I+1
        		GOTO 1
        	ENDIF

        	PARTICLES(IL) = NPART(I-1)+((NPART(I)-NPART(I-1))/
     &  		(Z(I)-Z(I-1)))*(ALT(IL)-Z(I-1))
        	RAER(IL) = RPART(I-1)+((RPART(I)-RPART(I-1))/
     &  		(Z(I)-Z(I-1)))*(ALT(IL)-Z(I-1))
    4   ENDDO
c A. Zsom: WHY is it divided by 100?    
        DO IL = 1,ND
        	PARTICLES(IL) = PARTICLES(IL)/100.
        ENDDO
c A. Zsom: printing the cloud properties
	DO i=1,ND
		if (RAER(i).gt.0.) then
			write(*,*)ALT(i),RAER(i),PARTICLES(i)
		endif
	enddo

        RETURN
        END
