     
        SUBROUTINE INTERPAR1(RAER)
       
        INCLUDE '../INCLUDECLIM/parND.inc'
        INCLUDE '../INCLUDECLIM/parNF.inc'
        INCLUDE '../INCLUDECLIM/parNSOL_NSOLUV.inc'
       
        DIMENSION RAER(ND)

        INCLUDE '../INCLUDECLIM/comHYDROCARB.inc'
        INCLUDE '../INCLUDECLIM/comSOLARBLK.inc'
        INCLUDE '../INCLUDECLIM/comIRBLK.inc'
c A. Zsom	
	REAL minrad,maxrad,minr,maxr
c A. Zsom: stupidity check: are the given particle sizes inside the table?
c fortran 77 can't find the min or max of an array using the intrinsic min or max functions...
	minrad=radstand(1)
	maxrad=0.
	minr=RAER(1)
	maxr=0.
	
	DO i=1,100
		minrad=min(minrad,radstand(i))
		maxrad=max(maxrad,radstand(i))
	ENDDO
	DO i=1,ND-1
		minr=min(minr,RAER(i))
		maxr=max(maxr,RAER(i))
	ENDDO
	if ((minr.lt.minrad).and.(minr.gt.0.)) then
		write(*,*)'your droplet radius is outside the range of the tables.'
		write(*,*)'the minimum droplet size in the table is ',minrad
		write(*,*)'the smallest size you specified is ',minr
		stop
	endif
	if (maxr.gt.maxrad) then
		write(*,*)'your droplet radius is outside the range of the tables.'
		write(*,*)'the maximum droplet size in the table is ',maxrad
		write(*,*)'the largest size you specified is ',maxr
		stop	
	endif		

     
****** IR fitting
        DO i = 1,55
        	DO j = 1,ND-1
        		DO k = 1,99
        			IF ((RAER(j).GE.radstand(k)).and.(RAER(j).LT.radstand(k+1)))
     &   				THEN

        				dra = RAER(j) - radstand(k)
        				dr = radstand(k+1) - radstand(k)
        				QEXTIR(i,j)=Qextirst(k,i)+((Qextirst(k+1,i)-Qextirst(k,i))
     &  					/dr)*dra
        				OMG0AIR(i,j)=w0irst(k,i)+((w0irst(k+1,i)-w0irst(k,i))
     &  					/dr)*dra
        				ASYAIR(i,j)=girst(k,i)+((girst(k+1,i)-girst(k,i))
     &  					/dr)*dra
C        ELSE
C        QEXTIR(i,j) = Qextirst(1,i)
C        OMG0AIR(i,j) = w0irst(1,i)
C        ASYAIR(i,j) = girst(1,i)
        			ENDIF
        		ENDDO
        	ENDDO
        ENDDO
****** SOLAR fitting 
        DO i = 1,38
        	DO j = 1,ND-1
        		DO k = 1,99
        			IF ((RAER(j).GE.radstand(k)).and.(RAER(j).LT.radstand(k+1)))
     &   				THEN

				        dra = RAER(j) - radstand(k)
        				dr = radstand(k+1) - radstand(k)
        				QEXT(i,j)=Qextsolst(k,i)+((Qextsolst(k+1,i)-Qextsolst(k,i))
     &  					/dr)*dra
        				OMG0A(i,j)=w0solst(k,i)+((w0solst(k+1,i)-w0solst(k,i))
     &  					/dr)*dra
        				ASYA(i,j)=gsolst(k,i)+((gsolst(k+1,i)-gsolst(k,i))
     &  					/dr)*dra
        			ENDIF
C        IF (RAER(j).LT.radstand(1)) THEN
C        QEXT(i,j) = Qextsolst(1,i)
C        OMG0A(i,j) = w0solst(1,i)
C        ASYA(i,j) = gsolst(1,i)
C        ENDIF
        		ENDDO
        	ENDDO
        ENDDO
        RETURN
        END
