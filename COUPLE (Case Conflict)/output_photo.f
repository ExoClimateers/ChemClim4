C------------------------------------------------------------------------------
C-KK	Code added Sept 27 2001 for integration with the photochemical code
C-KK 	atm_chem.f   
C------------------------------------------------------------------------------
  
      SUBROUTINE OUTPUT_PHOTO(T,FI,water,ALT,O3save,JCOLD,DZPHOT)
      INCLUDE '../CLIMA/INCLUDECLIM/parND.inc'
      INCLUDE '../ATMCHEM/INCLUDECHEM/parNZ.inc'
     
      DIMENSION T(ND), FI(4,ND), alt_new(NZ), T_new(NZ)
      DIMENSION water(NZ), ALT(ND)
      INCLUDE '../CLIMA/INCLUDECLIM/comCBLOK.inc'

        DZkm = DZPHOT/1.e5

	alt_new(NZ) = DZkm/2.
	do i = (NZ-1), 1, -1
C	  interpolate temperatures at correct altitudes
	  alt_new(i) = alt_new(i+1) + DZkm
	end do

	ISTART = ND
	
	DO J = NZ, 1, -1
	 DO i = ISTART,1,-1
	   IS = i
	   IF (ALT(IS) .GT. alt_new(J)) GOTO 350
	 END DO
  350  CONTINUE
	IS1 = IS+1
	ISTART = IS
	DZI = ALT(IS) - ALT(IS1)
	DZJ = ALT(IS) - alt_new(J)
	FR = DZJ/DZI
C-KK			begin temperature interpolation
	T1log=ALOG(T(IS))
	T2log=ALOG(T(IS1))
	T_temp = FR*T2log + (1-FR)*T1log
	T_new(J) = EXP(T_temp)
C-KK			begin water interpolation
	FH1log = ALOG(FI(1,IS))
	FH2log = ALOG(FI(1,IS1))
	water_temp = FR*FH2log + (1-FR)*FH1log
	water(J) = EXP(water_temp)
	END DO

       DO J=NZ,1,-1
       
        if(ALT(JCOLD).lt.alt_new(J)) then
          JTROP= (alt_new(j)/DZkm)+0.5
          goto 410
        endif
       ENDDO
C
 410    JTROP=JTROP-1
        do J=NZ,1,-1
	WRITE(54,*) alt_new(J), T_new(J), water(J)
        enddo
        CLOSE(54)

	write(*,*)'********************'
	write(*,*)'alt_new'
	write(*,*)alt_new
	write(*,*)'********************'

	write(*,*)'********************'
	write(*,*)'Tnew'
	write(*,*)T_new
	write(*,*)'********************'
	

	write(*,*)'********************'
	write(*,*)'water'
	write(*,*)water
	write(*,*)'********************'

	FCH4 = FI(3,ND)
	FCO2 = FI(2,ND)	
        WRITE(55,102) FAR, FCH4, FCO2, FO2, JTROP, O3save
  102	FORMAT(1PE10.3,10x,'!Argon'/,1PE10.3,10x,'!Methane'/
     &  ,1PE10.3,10x,'!Carbon Dioxide'/,1PE10.3,10x,'!Oxygen'/,
     &  I3,17x,'!Tropopause layer',/,1PE12.4,10x,'!O3 column depth')
        close(55)
	END
