       subroutine clima(ALBP,ncouple,SOLCON,IRCHOICE,ICOUPLE,dt0,NSTEPS,
     & dtmax,TSTOP,TIME)
c       
C  This program is a modified version of the climate model SURFTEM made 
c  by James Kasting. The program has been modified by Michael Mischna (mm),
c  Alex Pavlov (AP), Kara Krelove (KK), Hilary Justh (HJ) and Antigona 
c  Segura (AS). Some changes are identified with the initials of the author.

c  The code is mostly written in f77 but is compiled in f90 and it 
c  contains some f90 features.

c  This code is a 1-D, cloud-free, radiative-convective climate model.
c  The calculation of temperature profiles begins with an initial 
c  temperature-pressure profile and a solar constant. 

c  The net absorbed solar radiation is calculated by a delta two-stream
c  approximation (Toon, et al. JGR Vol. 94, 16287-16301, 1989). It uses
c  4-term correlated k coefficients to parameterize absorption by O3,
c  CO2, H2O, O2 and CH4 in 38 spectral intervals.

c  The IR is calculated by the RRTM routine developed by Mlawer et. al
c  (JGR, Vol.102 (D14), 16663-16682, 1997). It uses 16 term sums in 
c  each of its spectral bands in which the k-coefficients are concentrated 
c  in areas of most rapidly changing absorption. The version 3.0 of RRTM 
c  was implemeted on August/2003 (www.rtweb.aer.com).

c  When the mixing ratio of CO2 is greater than CO2MAX, the maximum dov
c  level of CO2 that RRTM can manage, the former IR subroutine is used.
c  (Pavlov et al. J. Geophys. Res. 105: 11,981-11,990, 2000).

c  Units in cgs unless otherwise is stated.
   
c  Temperature in each layer is calculated from:
c              dT/dt = - (g/c_p) dF/dp
c  in this case the derivates are partial. T= temperature, t= time, 
c  g= gravitational constant, F=Flux, c_p= Heat capacity, p=pressure.

c  Two types of reach convergence have been set up. One uses a non-strict
c  time stepping mode which is faster and better for high O2-low CO2 runs,
c  like present Earth. The other one is slower but needed on high CO2 
c  atmospheres. 

c  This model can work alone or coupled to a photochemical model. 
c  Modifications for the coupled mode were made by Kara Krelove.  

c Input data files required by the program are:
C     Unit   File
C      3     H2O_tables.pdat
C      4     solar_data_38.pdat (Read by 2-stream code)
C      8     nearir_expsums.pdat
c      9     CO2_tables.pdat
c     20     ir_expsums.pdat

C
C   THE VERTICAL GRID IS STAGGERED BETWEEN TEMPERATURE AND FLUX
C   GRID POINTS.  THE FLUX GRID IS DEFINED FROM THE VERY TOP OF THE
C   ATMOSPHERE (J=1) TO THE GROUND (J=ND).  THE TEMPERATURE GRID POINTS
C   ARE HALFWAY BETWEEN THE FLUX POINTS, EXCEPT FOR T(ND) WHICH IS
C   LOCATED AT THE GROUND.
C
C   PARAMETERS:
C   ND = # OF ALTITUDE POINTS  (J)
C   NF = # OF FREQUENCIES  (N)
C   NGS = # OF CHEMICAL SPECIES
c   NS1 = # OF CHEMICAL SPECIES, O2 NOT INCLUDED   
C   NT = # OF TEMPERATURES IN THE STEAM TABLE
C   NSOL = # OF SOLAR FREQUENCIES
C
C   T = TEMPERATURE (K)
C   P = PRESSURE (bar)
C   Z = LOG PRESSURE + A CONSTANT (ZCON)
C   PF = PRESSURE AT FLUX GRID POINTS
C   DZ = LOG P AT FLUX POINTS
C   ALT = ALTITUDE (KM)
C   GAM = DTDZ
C   BVK = PLANCK FUNCTION
C   LAM = WAVELENGTHS (MICRONS)
C   AV = FREQUENCIES (1/S)
C   TAU = SLANT OPTICAL DEPTH TO OTHER PRESSURE LEVELS
C   FI = SPECIES MIXING RATIOS
C   FH2O - H2O MIXING RATIO
C   T,TN - TEMPERATURES
C   FLAGCONVEC - Tags for the type of convection
c                1. = Water moist adiabat
c                2. = Water dry diabat
c                3. = CO2 adiabat 
c                0. = Non convective layer
 
C-KK	NLAYERS is a translation parameter between this climate model
C-KK    and Mlawer's RRTM code. 
C_KK    SurfTem indexes from 1 at the top to ND at the ground, while 
C_KK    RRTM indexes from 0 at the ground to NLAYERS at the top.
C-KK	NZ is the number of layers being carried in atm_chem. 
c      PARAMETER(ND=52, NF=55, NA=1, NLAYERS=51, NZ=64)
c      PARAMETER(NS=3, NS1=NS+1, NS4=NS+5)
c      PARAMETER(NT=76, MT=36)
c      PARAMETER(NSOL=38, NGS=5,NSOLUV=16)
       
      INCLUDE 'INCLUDECLIM/parND.inc'
      INCLUDE 'INCLUDECLIM/parNLAYERS.inc'

       INCLUDE 'INCLUDECLIM/parNF.inc'
      INCLUDE '../ATMCHEM/INCLUDECHEM/parNZ.inc'
      INCLUDE 'INCLUDECLIM/parNS_NS4.inc'
      INCLUDE 'INCLUDECLIM/parNS1.inc'
      INCLUDE 'INCLUDECLIM/parNT.inc'
      INCLUDE 'INCLUDECLIM/parMT.inc'
      INCLUDE 'INCLUDECLIM/parNGS.inc'
      INCLUDE 'INCLUDECLIM/parNSOL_NSOLUV.inc'

      CHARACTER*3 :: STARR
      CHARACTER*11 :: AA
      CHARACTER :: DIRINOUT*8,DIRDATA*10,dircoup*14

      DIMENSION TRAD(ND), DZ(ND),P(ND),PF(ND)    
      DIMENSION pphot(NZ), water(NZ), O3(NZ)
      DIMENSION TOLD(ND),FTOTAL(ND),FTIR(ND),
     &  FI(NS1,ND),FTSO(ND),PF1(ND),DELT(ND),DELTRAD(ND),TN(ND),
     &  dt(ND),CPNT(ND),TCOOL(ND),THEAT(ND)   
      DIMENSION FSATURATION(ND),FSATUR(ND),FSAVE(ND)
      DIMENSION HEATNET(ND),BETA(ND),FCO2V(ND),FH2O(ND)
      dimension AV(NF), CGAS(ND,NGS)

      REAL FLAGCONVEC(ND),LAM(NF)
c A. Zsom: initial water and ozone mixing ratios
      REAL Fwater, FO3 
c      INTEGER imax,imin       


c common file added for the coupled mode
      INCLUDE '../INCLUDECOUP/comCLIM.inc'
      INCLUDE '../INCLUDECOUP/comFLUXCLIMA.inc'
      INCLUDE '../INCLUDECOUP/comSTR.inc'

      INCLUDE 'INCLUDECLIM/comABLOK1.inc'
      INCLUDE 'INCLUDECLIM/comALTBLOK.inc'
      INCLUDE 'INCLUDECLIM/comCBLOK.inc'
      INCLUDE 'INCLUDECLIM/comCPART.inc'
      INCLUDE 'INCLUDECLIM/comEBLOK.inc'
      INCLUDE 'INCLUDECLIM/comFBLOK.inc'
      INCLUDE 'INCLUDECLIM/comGBLOK1.inc'
      INCLUDE 'INCLUDECLIM/comSBLOK.inc'
      INCLUDE 'INCLUDECLIM/comPRESS.inc'
      INCLUDE 'INCLUDECLIM/comRSOL.inc'
      INCLUDE 'INCLUDECLIM/comSOLARBLK.inc'
      INCLUDE 'INCLUDECLIM/comIRDATA.inc'
      INCLUDE 'INCLUDECLIM/comIRBLK.inc'
      INCLUDE 'INCLUDECLIM/comWAVE.inc'
      INCLUDE 'INCLUDECLIM/comHYDROCARB.inc'
      INCLUDE 'INCLUDECLIM/comCH4BLOCK.inc'
      INCLUDE 'INCLUDECLIM/comCO2BLOK.inc'
      INCLUDE 'INCLUDECLIM/comCONS.inc'

C-KK  Added 6/15/01 to integrate Mlawer RRTM. 
      COMMON/ MLAWERI/  layers, numspec, newalt(ND), TempT(0:NLAYERS), 
     & 			Pres(0:NLAYERS), gasses(7, 0:NLAYERS), COLDEP(ND)
      COMMON /IRBLKRRTM/ FUPIR1(ND),FDNIR1(ND)
C
      DATA BETA/ND*1./
      DATA BETH2O/1100*0./
      DATA BETCO2/1100*0./
      REAL ALBP

C   FREQUENCIES AT ENDS OF SPECTRAL INTERVALS (1/CM)
      DATA AV/40., 100., 160., 220., 280., 330., 380., 440., 495.,
     2  545., 617., 667., 720., 800., 875., 940., 1000., 1065.,
     3  1108., 1200., 1275., 1350., 1450., 1550., 1650., 1750., 1850.,
     4  1950., 2050., 2200., 2397., 2494., 2796., 3087., 3425., 3760.,
     5  4030., 4540., 4950., 5370., 5925., 6390., 6990., 7650., 8315.,
     6  8850., 9350., 9650., 10400., 11220., 11870., 12790., 13300.,
     7  14470., 15000./
     
      DATA C,HP,BK,SIGMA,PI,SM/3.E10, 6.63E-27, 1.38E-16, 5.67E-5,
     2  3.14159, 1.67E-24/    

c Names of the subdirectories for the data, inputs and outputs
      DIRINOUT = 'CLIMA/IO'
      DIRDATA =  'CLIMA/DATA'
      dircoup = '../CHEMCLIM/IO'
c   =============    FILE SECTION ==================

C  INPUT FILES
      OPEN (unit=31,file= dircoup//'/input_clima.dat')
      OPEN (unit=32,file= DIRDATA//'/solar_data_38.pdat',status='old')
      OPEN (unit=33,file= DIRDATA//'/H2O_tables.pdat',status='old')
      OPEN (unit=34,file= DIRDATA//'/CO2_tables.pdat',status='old')
      OPEN (unit=35,file= DIRDATA//'/nearIR_expsums.pdat',status='old')
      OPEN (unit=36,file= DIRDATA//'/ir_expsums.pdat',status='old')
      OPEN (unit=39,file= DIRDATA//'/nearuvabscoeff.pdat',status='old')
      OPEN (unit=40,file= DIRDATA//'/BIG_DATAFILE.pdat',status='old')

c  Starting temperature profile
c A. Zsom
c	IF (ncouple.EQ.1) then
c there is nothing to be done. the temperture profile is initated later in the code.
c     		OPEN(unit=41,file= DIRINOUT//'/TEMP_IN_zsom.dat')
c      		OPEN(unit=41,file= DIRINOUT//'/TempIn.dat')
		
c	else
      		OPEN(unit=41,file= DIRINOUT//'/TempIn.dat')
c	endif
c  US standard atmosphere O3 profile used when the climate model is not
c  coupled to the photochemical model
      OPEN (unit=42,file= DIRINOUT//'/Ozone_standard.dat')
c  Ozone and water profiles from the photochemical model 
      OPEN (unit=43,file= dircoup//'/fromPhoto2Clima.dat') 
c  Surface mixing rations to set the chemical composition of the atmosphere.
c  Used by the photochemical and the climate model
      OPEN (unit=44,file= dircoup//'/mixing_ratios.dat')  
c A. Zsom: the input_comp file contains the water and O3 initial mixing ratios needed for the climate code.
c		the file is generated by run_chemclim.py
      OPEN (unit=45,file= dircoup//'/input_comp.dat')  

c  IMPORTANT Files these are read in the subroutine CHOOSE_STAR
c  IF the character variable STARR is different than "Sun"
c        45     DIRDATA/fluxesKGF_surf.pdat
c        46     DIRINOUT/M star flux (name it as you like)

c  Next files are used for the subroutine AERABSDATA
c	 37 	DIRDATA/irtotal.DAT
c	 38	DIRDATA/soltotal.DAT	
   
C   OUPUT FILES
c-as  This file is the output for the photochemical model
      OPEN (unit=54,file= dircoup//'/fromClima2Photo.dat')

c Output file for coupled iterations opened in this program and used in 
c  CHEMCLIM/COUPLE/output_photo.f
c Notice it is the same file as unit 44
c     OPEN(unit=55,file= dircoup//'/mixing_ratios.dat')

c Output file moved to couple.f
c      OPEN(UNIT=51,FILE= DIRINOUT//'/clima_allout.tab')
c Ouput generated by solar.f, commented for now
c      OPEN(UNIT=53,FILE= DIRINOUT//'/SolarHeating.tab')
      
c======================================================
c             VARIABLE INPUT PARAMETERS
c======================================================
C      NSTEPS - NUMBER OF ITERATIONS
C         IMW - 0 FOR SATURATED TROPOSPHERE, 1 FOR MANABE/WETHERALD
C               RELATIVE HUMIDITY, 2 FOR M/W WITH CONSTANT
C               STRATOSPHERIC H2O CONTENT
C        RSURF - SURFACE RELATIVE HUMIDITY
C           ZY - SOLAR ZENITH ANGLE (DEGREES)
C        DTAU0 - OPTICAL DEPTH STEP IN SUBLEVEL INTEGRATION
C         ZCON - ARBITRARY CONSTANT ADDED TO Z TO KEEP IT POSITIVE
C           P0 - PRESSURE AT TOP OF GRID
C          PG0 - DRY PRESSURE AT BOTTOM OF GRID (atm)
c            G - Gravity aceleration (cgs)
C          FAC - RATIO OF GRID SPACING AT TOP TO SPACING AT
C                BOTTOM
C          IO3 - 1 TO INCLUDE O3, 0 TO LEAVE IT OUT
C          IUP - SPECIFIES TYPE OF INITIALIZATION (0 IF YOU WISH TO
C                START FROM AN EXISTING SOLUTION, 1 IF YOU WISH TO
C                SPECIFY A NEW SURFACE TEMPERATURE)
C               IF OPTION 1 IS SELECTED YOU MUST MAKE SURE THAT
C               THE STARTING TEMPERATURES ABOVE GROUND LEVEL ARE LESS
C               THAN TG0, SINCE THE TROPOSPHERIC LAPSE RATE IS INTEGRA-
C               TED UPWARDS IN THIS CASE.       
C         TG0 - INITIAL SURFACE TEMPERATURE (FOR IUP = 1 CASE)
C      TSTRAT - Stratospheric temperature for IUP=1
C       STARR - Character variable to choose a star, it can be:
c               Sun, F2V, K2V, dMV 
c               Write it exactly as it is listed.
c               DO NOT FORGET quotation marks.
c    ICONSERV - O = Non strict time-stepping method (faster)
c               1 = Each time step conservs energy (better for high CO2)  
c     ICOUPLE - 1 = Coupled to the photochemical model              
c               0 = Not coupled
c      SRFALB - Planetary albedo (0.2 for Present Earth)
c      SOLCON - Solar constant (S/So)
c       dtmax - Maximum time step in seconds    
c      CO2MAX - Maximum CO2 mixing ratio that RRTM can manage with accuracy, 
c               for greater values of CO2 the former IR subroutine is used.
c        Idry - To be used in the CONVEC subroutine
c               1 = Dry adiabat
c               O = Moist adiabat

C A. Zsom: the first 4 lines are deleted from the input_clima.dat
C      READ(31,51)
      READ(31,*) AA,IMW
      READ(31,*) AA,RSURF               
      READ(31,*) AA,ZY
      READ(31,*) AA,DTAU0
      READ(31,*) AA,ZCON
      READ(31,*) AA,P0           !Pressure at the top
      READ(31,*) AA,FAC
      READ(31,*) AA,IO3		!Ozone?
      READ(31,*) AA,IUP                    
      READ(31,*) AA,TG0		!Surface temperature for IUP=1   
      READ(31,*) AA,TSTRAT       !Stratospheric temperature for  IUP=1
      READ(31,*) AA,ICONSERV     
      READ(31,*) AA,SRFALB       !fixed planetary albedo (0.2)
c      READ(31,*) AA,SOLCON       !SOLCON=S/So
      READ(31,*) AA,CO2MAX
      READ(31,*) AA,Idry
  51  FORMAT(4/)
      close(31)
      
       
c===================================================================

c Reading the atmospheric composition from mixing_ratios.dat
        READ(44,*) FAR                  !Argon
	READ(44,*) FCH4			!Methane
	READ(44,*) FCO2			!Carbon dioxide	
	READ(44,*) FO2			!Oxygen	
	READ(44,*) Jcold		!Tropopause layer
        if(ICOUPLE.eq.1) READ(44,*) O3save    !O3 columd depth
        close(44)

       OPEN(unit=66,file= dircoup//'/planet.dat')
c A. Zsom: i got rid of the format 502.
      	READ(66,*)G
      	read(66,*)X
      	read(66,*)PG0
      	read(66,*)X
      	read(66,*)DZPHOT
      	read(66,*)X
      	read(66,*)X 
      	close(66)

c Nitrogen mixing ratio  
      FN2 = 1. - FO2 - FAR - FCO2 - FCH4
c A. Zsom: a check of N2
      if (FN2.le.0.) then
      	write(*,*)'The N2 mixing ratio is negative.'
	write(*,*)'SOmething is wrong.'
	write(*,*)FO2,FAR,FCO2,FCH4
	stop
      endif
c Molecular weigth of the atmosphere
      DM = 28.*FN2 + 32.*FO2 + 40.*FAR + 44.*FCO2 + 16.*FCH4

      IF(FCO2.gt.CO2MAX) print 550

      LAST = 0
      AMU0 = COS(ZY * PI/180.) 

C   CONSTANT FACTORS (cgs)
      BCON = 2.*HP/C/C
      HK = HP/BK
      BKM = BK/(SM*G)
      ND1 = ND - 1
 
      R = 1.9872
      P0P = 6.103E-3
      T0P = 273.15
      SUBL = 677.

c  TRIPLE POINT PARAMETERS FOR CO2
      PC0 = 5.179
      TC0 = 216.56
      VAPCL0 = 83.2765
      SUBCL0 = 130.893
      DLVCDT = - 0.4817
      DLSCDT = - 0.1732
      CCL = 0.5
      CCS = 0.3

C Read Solar Data including solar flux
      CALL READSOL      
      if(STARR.eq.'Sun')then      
       do i=1,NSOL
c. A. Zsom bug fix solint should be here not flux
        SOLINT(i)= SOLINT(i)*SOLCON
       enddo
       do j=1,NSOLUV
        SOLUV(j)=SOLUV(j)*SOLCON
       enddo
      endif

c If the star is not the Sun tranfer its flux to the variable used by solar.f
      if(STARR/='Sun') then
       do i=1,NSOL
        SOLINT(i)= FLUXC(i)
       enddo
       do j=1,NSOLUV
        SOLUV(j)= FLUXUV(j)
       enddo
      endif

      write(*,*) 'Star FLUX CHECK'
      write(*,*) STARR
      write(*,*) 'SOLINT',SOLINT
      write(*,*) 'SOLUV',SOLUV

  
c Reading an initial temperature and water profile
c A. Zsom: initiating the temperature and water profile when the code is called first
      IF ((IUP.EQ.1).and.(NCOUPLE.EQ.1)) THEN
         write(*,*) 'IUP=1 and first iteration'
c SR     IF ((IUP.EQ.0).and.(NCOUPLE.EQ.1)) THEN

c Zsom: reading the input_comp.dat file
		read(45,*)Fwater
		read(45,*)FO3
		close(45)
c A. Zsom	  
	  	TG=TG0
c initiate pressure profile	
                print*, "initializing pressure grid"
c                print*, " P0, FAC, ZCON, PF, DZ"
c                print*, P0, FAC, ZCON, PF, DZ
	 	CALL CGRID(P0,FAC,ZCON,P,PF,DZ)	
c initiate temperture profile
c TSTRAT, P0, etc is taken from input_clima.dat
c JCOLD is defined at P=0.1 bar (pressure at the top of troposphere on Earth)
		do j=1,ND
			if (P(J).lt.0.1) then
				JCOLD=j
c				write(*,*)P(J),j

			endif
		enddo
c			write(*,*)JCOLD
                
          	CALL CPROFILE(TSTRAT,P,T,DZ,FSAVE,FCO2V,BETA,Idry,JCOLD) 
c give the stratosphere water mixing ratio here:
		do j=1, ND
			FSAVE(j)=Fwater
		enddo
c SR adding for IUP = 0
      ELSE IF ((IUP.EQ.0).and.(NCOUPLE.eq.1)) THEN
                write(*,*) 'IUP = 0 read from last solution'
        	DO J = 1,ND
         		READ(41,*) T(J),FSAVE(J)
        	END DO
         	close (41)
        	TG=T(ND)  
      ELSE IF (NCOUPLE.GT.1) THEN
                write(*,*) '2nd, 3rd, 4th... iteration T and H2O'

        	DO J = 1,ND
         		READ(41,*) T(J),FSAVE(J)
        	END DO
         	close (41)
        	TG=T(ND)   
c                write(*,*)"second iteration"
c                write(*,*)"Pressure"
c		write(*,*)P
c		write(*,*)'************'
c                write(*,*)"Temperature"
c		write(*,*)T
c		write(*,*)'************'
c               write(*,*)"Ozone"
c		write(*,*)FSAVE

      
      ENDIF
    
C  Initialize pressure grid
      IF(IUP.EQ.1) TG = TG0  
      CALL CGRID(P0,FAC,ZCON,P,PF,DZ) 
c Reading the ozone and water from the photochemical model
c A. Zsom: if ncouple eq 1, we initialize the water profile using cgprofile. 
c here we initialize the ozone profile 
c SR added IUP
      IF((ICOUPLE.EQ.1).and.(NCOUPLE.EQ.1).and.(IUP.eq.1)) THEN
                write(*,*) 'First iteration IUP = 1'
c      IF((ICOUPLE.EQ.1).and.(NCOUPLE.EQ.1)) THEN

c A. Zsom: reading the input_comp.dat file
c A. Zsom give the ozone mixing ratio here (FI(4,J))
		do j=1,ND
			FI(1,J)=FSAVE(J)			
			FI(4,J)=FO3			
		enddo

       ELSE if ((ICOUPLE.EQ.1).and.(NCOUPLE.eq.1).and.(IUP.eq.0)) THEN
                write(*,*)'reading O3 H2O from previous sol...'

        	DO JREAD=1,NZ
        		READ(43,*) x,pphot(JREAD),O3(JREAD),water(JREAD)
        	END DO
       		close(43)

c  Interpolate the grid from the photochemical model to the grid of the
c  climate model
		CALL INPUT_INTERP(P,pphot, water, O3, JCOLD, FI)


       ELSE if ((ICOUPLE.EQ.1).and.(NCOUPLE.GT.1)) THEN
                write(*,*) '2nd,3rd iter...'

        	DO JREAD=1,NZ
        		READ(43,*) x,pphot(JREAD),O3(JREAD),water(JREAD)
        	END DO
       		close(43)
c  Interpolate the grid from the photochemical model to the grid of the
c  climate model 
		CALL INPUT_INTERP(P,pphot, water, O3, JCOLD, FI)

       ENDIF
      
c  Reading the US Standard Atmosphere ozone profile       
        if(IO3.eq.1.and.ICOUPLE.eq.0) then
           CALL OZONE(FI,P)
c          do i=1,ND
c             read(42,*) x, FI(4,i) 
c          enddo
           close(42)
        endif     

c A. Zsom
c Constructing temperature and water profiles in case they are not provided 
c       IF(IUP.EQ.1) THEN
c          JCOLD = 1
c          CALL CPROFILE(TSTRAT,P,T,DZ,FSAVE,FCO2V,BETA,Idry,JCOLD)
c       ENDIF

c Reading parameters for running ir.f
      IF(FCO2.gt.CO2MAX.or.IRCHOICE.eq.1) then      
       CALL IREXPSUMS
C Convert frequencies from 1/cm to 1/sec and compute weighting factors
      DO  N=1,NF
       AV1(N) = C*AV(N)
      ENDDO
      W(1) = AV1(1)
      DO N=2,NF
        W(N) = AV1(N) - AV1(N-1)
      ENDDO

C
C   CENTER FREQUENCIES IN MIDDLE OF INTERVALS AND COMPUTE WAVELENGTHS
  
      SAV = 0.
       DO N=1,NF
        SAV2 = AV1(N)
        AV1(N) = 0.5*(AV1(N) + SAV)  !centered frequencies (1/sec)
        LAM(N) = 3.E14/AV1(N)         !wavelength in microns
        SAV = SAV2
       ENDDO    
      ENDIF
c Writing wavelength intervals
c       WRITE(53,150)
c 150   FORMAT(/1X,*WAVELENGTHS (microns)*/)
c       WRITE(53,151) LAM
c 151   FORMAT(1X,10F8.3)  
c      ENDIF

c Building the water profile
       if(ICOUPLE.eq.0)then
        DO J = 1,ND
         FI(1,J)=FSAVE(J)
        END DO
       endif 
     
      DO 2 J=1,ND
      XP(J) = P(J)             !variable to be transfered to couple mode
      PF1(J) = PF(J)*1.E6      !PF1 in dyn/cm^2
      TOLD(j) = T(J)
      Tstart(j) =T(J)    
      FI(2,J) = FCO2
c      IF(IUP.EQ.1) FI(2,J)=FCO2V(J)
   2  FI(3,J) = FCH4
      
c      do i=1,ND
c      print*,FI(1,i),FI(2,i),FI(3,i),FI(4,i)
c      enddo

C *** Time related variables
       IFLAGTIME = 0
       TIME=0. 
c  Altitude calculation
       NST = 0
       CALL CALTITUDE(NST,T,FI,DZ)
c      do i=1,ND
c      write(*,*)ALT(i),T(i),FI(1,i)
c      enddo

c SR added IUP eq 1 condition since otherwise it should have water?
c SR delete this if statement? has no effect on initial P, T or O3 profile need to check effect on h2o
      if ((NCOUPLE.EQ.1).and.(IUP.eq.1)) then
c Water calculation in the troposphere for the first time:
	DO J=1,ND
		CALL SATRAT(T(J),PSAT)
	       	FSATUR(J) = (PSAT/P(J))
c	       write(*,*)FSATUR(J),T(J),PSAT
	ENDDO
c Water from the cold trap to the ground
      	DO J = JCOLD, ND
       		FI(1,J) = FSATUR(J)*RELHUM(P(J))
       		if(IMW.eq.2) FI(1,J) = amax1(FI(1,J),4.e-6)
      	ENDDO
		
c A. Zsom: water from cold trap to top in the MC runs 
c         DO J = JCOLD-1, 1, -1
c           FI(1,J)= FI(1,JCOLD)
c           if(IMW.eq.2) FI(1,J) = 4.e-6
c          END DO
      endif


c Aerosol calculation (commented when not used)
      CALL AERABSDATA
      CALL GRIDAER
      CALL INTERPAR1(RAER)

      write(*,*)"before climate loop"
      write(*,*)"ALT(J), T(J), FI(1,J) water, FI(4,J)O3"
      do j=1,ND
	WRITE(*,1111) ALT(j),T(j),FI(1,J),FI(4,J)
 1111   format(F6.2,2x,F6.2,2x,E11.5,2x,E11.5)
c        WRITE(*,*) FI(4,J)			
      enddo


c Flag for time dependent mode
      ISTOP = 0
c$$$      write(*,*)"before loop"
c$$$      write(*,*)"Pressure"
c$$$      write(*,*)P
c$$$      write(*,*)'************'
c$$$      write(*,*)"Temperature"
c$$$      write(*,*)T
c$$$      write(*,*)'************'
c$$$      write(*,*)"Water"
c$$$      write(*,*)FSAVE
c$$$      write(*,*)"Ozone"
c$$$      write(*,*)FO3 
      
            
            
C************************************************************
C ****************** START ITERATIVE LOOP *******************
      DO 40 NST=1,NSTEPS
C************************************************************
c Total Time
c TIME only makes sense when the program runs using the 
c strict energy conservation mode (ICONSERV =1)
      if(ICONSERV.eq.1) then         
        TIME = TIME + dt0
        if(TIME.gt.TSTOP) then
         TIME = TIME - dt0
         dt0 = TSTOP - TIME
         TIME = TIME + dt0
         ISTOP = 1
        endif
      endif
c SR keep O3 constant mixing ratio pre-defined for abiotic runs
c      do j=1,ND
c         FI(4,J)=FO3			
c      enddo
      
      ITROP = 1
c	imin=ND
c	imax=0
c. SR save old JCOLD
       JCOLD_OLD=JCOLD

C Set up gas concentrations for Solar code and former IR code
      CALL GASCON(T,PF,FO2,FI,CGAS,NST)
    
      if(FCO2.gt.CO2MAX.or.IRCHOICE.eq.1) then
c-as Old subroutine to calculate IR flux
       CALL IR(T,PF,CGAS,FI) 
      else
C    Code modified 6/15/01 to integrate Mlawer's RRTM
       CALL TRANSLATEM(G,FI,T,PF,ND1,DM,BKM)
C IR subroutine v3.0 loaded August/2003 (www.rtweb.aer.com)
       CALL RRTM

       do j=1,ND
       FUPIR(j) = FUPIR1(j)
       FDNIR(j) = FDNIR1(j)
       enddo
      endif 

      IF (NST .EQ. NSTEPS) LAST = 1
     
C  Solar code 

      CALL SOLAR(CGAS,P, PF,T, LAST)

c IR and SOLAR fluxes (erg/cm^2/s)
c      IF (NST .EQ. NSTEPS) write(*,*)"FDNIR, FUPIR,FDNSOL,FUPSOL"
      DO 31 J=1,ND
      FDNSOL(J) = 0.5 * FDNSOL(J)
      FUPSOL(J) = 0.5 * FUPSOL(J)
      FTOTAL(J) = FDNSOL(J)-FUPSOL(J)+FDNIR(J)-FUPIR(J)
      FTIR(J) = FDNIR(J)-FUPIR(J)
      FTSO(J) = FDNSOL(J)-FUPSOL(J)
c      IF(NST.EQ.NSTEPS) write(*,*)FDNIR(J),FUPIR(J),FDNSOL(J),FUPSOL(J)
  31  CONTINUE
      ALBP = FUPSOL(1)/FDNSOL(1)
c      PRINT 166,ALBP
 166  FORMAT(/1X,'PLANETARY ALBEDO:  ALBP = ',F6.4)
C
C Heat capacity calculation
c A. Zsom: Sid's heat capacities
      DO J=1,ND-1
      	CPCO2 = 4.99 + 1.53E-2*T(J) - 7.66E-6*T(J)*T(J)
      	CPN2 = 7.04 - 6.72E-4*T(J) + 1.38E-6*T(J)*T(J)
      	CPO2 = 7.11 - 1.76E-3*T(J) + 4.93E-6*T(J)*T(J)
c      CPO2 = AMAX1(CPO2,CPN2)
c Total heat capacity     
      	CPN = FCO2*CPCO2 + FN2*CPN2 + FO2*CPO2 + FAR*4.97 +FCH4*8.3
C since CPN is in calories/mol/K we should convert them to erg/g/K
      	CPNT(J) = CPN*4.18*1.E7/DM
      ENDDO 
C   Surface heat capacity (assumes a 50 cm deep ocean mixed layer)
c   Units erg/K/cm^2 
      CPNT(ND) = 50.* 4.18*1.E7
c      IF(NST.EQ.1) write(*,*) "Heat Capacities CPNT"
c      IF(NST.EQ.1) write(*,*) CPNT
c      IF(NST.EQ.1) write(*,*) "NEW TEMP"
c      IF(NST.EQ.NSTEPS) write(*,*) "Heat Capacities CPNT"
c      IF(NST.EQ.NSTEPS) write(*,*) CPNT
c      IF(NST.EQ.NSTEPS) write(*,*) "NEW TEMP"
C New temperature calculation for all layers from radiative equilibrum
      DO 41 J=1,ND-1
      TN(J)=T(J)-(FTOTAL(J+1)-FTOTAL(J))*dt0*G/CPNT(J)/(PF1(J+1)-PF1(J))
      TCOOL(J)=-(FTIR(J+1)-FTIR(J))*G/CPNT(J)/(PF1(J+1)-PF1(J))*86400.
      THEAT(J)=-(FTSO(J+1)-FTSO(J))*G/CPNT(J)/(PF1(J+1)-PF1(J))*86400.
c      IF(NST.EQ.1) write(*,*) TN(J),TCOOL(J),THEAT(J),G,dt0
c      IF(NST.EQ.NSTEPS) write(*,*) TN(J),TCOOL(J),THEAT(J),G,dt0
  41  CONTINUE
 
c New surface temperature from radiative equilibrum
      select case (ICONSERV)
      case(1)
      TN(ND)=T(ND)+FTOTAL(ND)*dt0/CPNT(ND) 
      TCOOL(ND)= FTIR(ND)*86400./CPNT(ND)
      THEAT(ND)= FTSO(ND)*86400./CPNT(ND)
      case(0)   

C Lower atmospheric layer temperature calculated from the total flux at  
C the TOP of the atmosphere    
      TN(ND-1) = T(ND-1)+FTOTAL(1)/(PF1(ND)-PF1(ND-1))*G/CPNT(ND-1)*dt0
      CALL SATRAT(TN(ND-1),PSAT)
      FI(1,ND-1) = RELHUM(P(ND-1))*PSAT/P(ND-1)
      end select

* Total heating rate
      do j=1,ND
       HEATNET(j)=THEAT(j)+TCOOL(j)
      enddo

c-as TRAD is defined for printing and diagnostic purposes
      DO J=1,ND
        TRAD(J)=TN(J)
      ENDDO
c Calculating tropospheric temperatures
      select case(ICONSERV) 
*** Non strict time-stepping model
      case(0)
c Calculation of the ground temperature 
      DZP = DZ(ND)
      T1 = TN(ND-1)
      P1 = P(ND-1)
      P2 = P(ND)
      FC1 = FI(2,ND-1)
      FH1 = FI(1,ND-1) 
      CALL CONVEC(T1,TN(ND),P1,P2,FH1,FH2,FC1,FC2,DZP,1,cflag,Idry)
      FI(1,ND) = FH2*RELHUM(P(ND)) 
   
c Determining which layers are convective (cflag=1, 2 or 3)
      JCONV=ND
      ITROP=1
      DO J1=ND-1, 2, -1
        FLAGCONVEC(J1) = 0.
        T1=TN(J1)
        DZP = DZ(J1) 
        P1 = P(J1)
        P2 = P(J1-1)
        FC1 =FI(2,J1)
        FH1 =FI(1,J1)
        CALL CONVEC(T1,T2,P1,P2,FH1,FH2,FC1,FC2,DZP,ITROP,cflag,Idry)      
	IF (ITROP .EQ. 1) THEN
	   IF (TN(J1-1) .LE. T2) THEN
		   TN(J1-1) = T2
c                   FI(2,J1-1) = FC2
	  	   FLAGCONVEC(J1) = cflag
                   JCONV = J1
	   ELSE
		   ITROP = 0
	   END IF
	END IF
			
C-KK	First non-convective layer has been reached; assumption made
C-KK	that troposphere is convective, stratosphere is not. 
 	IF (ITROP .EQ. 0) THEN
		IF (TN(J1-1) .LE. T2) THEN
		   FLAGCONVEC(J1) = cflag
		   TN(J1-1) = T2
		END IF
        ENDIF
      END DO
 
      FLAGCONVEC(ND) = 1.
      FLAGCONVEC(1) = 0. 
** End of the non strict time-stepping model

*** Here the temperatures are calculated conserving energy on each
*** layer
      case(1)
      DO ITER=1,20        !starting convective adjustment
       ITROP = 1
       JCONV=ND     
c-as   Adjusting the temperature on the surface and the layer above
c-as   it (ND and ND-1) (sept-2004)
       HC1=CPNT(ND-1)*(PF1(ND)-PF1(ND-1))/G
       DZP = DZ(ND)
       T1 = TN(ND)
       P1 = P(ND)
       P2 = P(ND-1)
       FH1 = FI(1,ND)
       FC1 = FI(2,ND)
       CALL CONVEC(T1,TadND1,P1,P2,FH1,FH2,FC1,FC2,DZP,1,cflag,Idry)
       FI(1,ND-1)=FH2*RELHUM(P(ND-1))
       TnewND=(CPNT(ND)*TN(ND)-HC1*(TadND1-TN(ND)-TN(ND-1)))/
     & (HC1+CPNT(ND))
       TnewND1=TadND1-TN(ND)+TnewND
       TN(ND-1)=TnewND1
       TN(ND)=TnewND
       FLAGCONVEC(ND)= 1.
       FLAGCONVEC(1) = 0.

c-as This part has been modified to consider energy balance in each
c-as  layer, as Hilary Justh did it (oct-2003)  
***** CONVECTIVE ADJUSMENT (considering energy balance and convection)
 
       DO J1=ND-1,2,-1
        T1 = TN(J1)
        DZP = DZ(J1)            
        P1 = P(J1)
        P2 = P(J1-1)
        FH = FI(1,J1)
        FC1 = FI(2,J1)
       CALL CONVEC(T1,T2,P1,P2,FH,FH2,FC1,FC2,DZP,ITROP,cflag,Idry)
        IF (TN(J1-1).LE.T2) THEN
          FLAGCONVEC(J1) =  cflag
          IF(cflag.eq.1.or.cflag.eq.3) JCONV=J1
          DELPCP1=(PF1(J1+1)-PF1(J1))*CPNT(J1)
          DELPCP2=(PF1(J1)-PF1(J1-1))*CPNT(J1-1)
          T2P=TN(J1-1)*(DELPCP2/(DELPCP1+DELPCP2))+(T2)*
     &     (DELPCP1/(DELPCP1+DELPCP2))
          T1P=T1-T2+T2P
          TN(J1-1)=T2P
          TN(J1)=T1P
c          FI(2,J1-1)=FC2
        ELSE 
            ITROP=0
            FLAGCONVEC(J1)=0.  
        ENDIF
       ENDDO   
      ENDDO          ! End of convection adjustment loop 
      end select

c Water recalculation 
      DO J=1,ND
       CALL SATRAT(TN(J),PSAT)
       FSATUR(J) = (PSAT/P(J))
      ENDDO
       print*,'T , FSTAUR ,  P'
       print*,T(ND),FSATUR(ND),P(ND)
       print*,T(1),FSATUR(1),P(1)

 
c For high CO2 atmospheres may be more than one cold traps, 
c then a special tratment to find the first cold trap from 
c the ground to the top is needed.
      if(FCO2.gt.0.1) then
        JCOLD=ND
        FCT=FSATUR(ND)
        DO K=1,ND-1
          J=ND-K
          IF (FSATUR(J).GT.FCT) JCOLD=J+1
          IF (FSATUR(J).GT.FCT) GOTO 430
         FCT=FSATUR(J)
        ENDDO
      else
        FCT=FSATUR(1)
        DO J=1,ND-1
          FCT=AMIN1(FCT,FSATUR(J+1))
        ENDDO 
	JCOLD = 1
	DO J = ND, 2, -1
	   IF (JCOLD .EQ. 1) THEN
             IF (FSATUR(J) .LT. FSATUR(J-1)) JCOLD = J
	   END IF
	END DO
c A. Zsom: JCOLD test
	if (ALT(JCOLD).lt.5.) then	
      		DO J=1,ND
                   CALL SATRAT(TN(J),PSAT)
                   FSATUR(J) = (PSAT/P(J))
c                   write(*,*)T(J),TN(J),ALT(J)
      		ENDDO	
		write(*,*)JCOLD,ALT(JCOLD)
                write(*,*)"Trouble with JCOLD!"
c		stop
         endif
      endif
	IF ((JCOLD.LT.10).or.(JCOLD.gt.(ND-10))) then
           JCOLD=JCOLD_OLD
           print*, "JCOLD OUT OF BOUNDS, NEW JCOLD:",JCOLD
        ENDIF

c      endif
c Water from the cold trap to the ground
 430  DO J = JCOLD, ND
       FI(1,J) = FSATUR(J)*RELHUM(P(J))
       if(IMW.eq.2) FI(1,J) = amax1(FI(1,J),4.e-6)
      END DO

c Water from the cold trap to the top (if it is used in the coupled 
c mode these values are given by the photochemical codea)
       if(ICOUPLE.eq.0)then
         DO J = JCOLD-1, 1, -1
           FI(1,J)= FI(1,JCOLD)
           if(IMW.eq.2) FI(1,J) = 4.e-6
          END DO
        endif

C-KK To smooth over the water profile around JCOLD.
      sum = 2.*FI(1,(JCOLD-1)) + FI(1,(JCOLD+1)) + 2.*FI(1,JCOLD)
      FI(1,JCOLD) = sum/5.

c Saving the former temperature profile      
      DO J=1,ND
       TOLD(J) = T(J)
       DIVFOLD(J)= DIVF(J)
      ENDDO
    
C Smoothing of temperature profile conserving energy
       if(ICONSERV.eq.1) then    
         DO J=2,ND-2
         IF (FLAGCONVEC(J).NE.1.) THEN
          Tj1 = 0.5*TN(J) + 0.25*(TN(J-1) + TN(J+1))
          CPP0=(PF1(J)-PF1(J-1))*CPNT(J-1) 
          CPP1=(PF1(J+1)-PF1(J))*CPNT(J)
          CPP2=(PF1(J+2)-PF1(J+1))*CPNT(J+1)
          En1=CPP0*TN(J-1)+CPP1*TN(J)+CPP2*TN(J+1)
          DELT1=Tj1-TN(J)
          DELT2=-(CPP1/(CPP0+CPP2))*DELT1
          TN(J+1)=TN(J+1)+DELT2
          TN(J-1)=TN(J-1)+DELT2
          TN(J)=Tj1
         ENDIF
         END DO
       endif

C  Diagnostics parameters      
      DO J=1,ND
      DELT(J) = (TN(J)-TOLD(J))
      DELTRAD(J) =TRAD(J)-TOLD(J)
      T(J) = TN(J)
      DIVF(J) = FTOTAL(J)/FTIR(J)
      ENDDO

c Smoothing the temperature profile in the non-strict time step case
      if(ICONSERV.eq.0) then      
        DO J=2,ND-2
         IF (FLAGCONVEC(J).NE.1.) THEN
          T(J) = 0.5*TN(J) + 0.25*(TN(J-1) + TN(J+1))
         ENDIF
        END DO
      endif

c A. Zsom: Water recalculation after the temperature is smoothed. this was missing before
      DO J=1,ND
       CALL SATRAT(TN(J),PSAT)
       FSATUR(J) = (PSAT/P(J))
      ENDDO
c For high CO2 atmospheres may be more than one cold traps, 
c then a special tratment to find the first cold trap from 
c the ground to the top is needed.
      if(FCO2.gt.0.1) then
        JCOLD=ND
        FCT=FSATUR(ND)
        DO K=1,ND-1
          J=ND-K
          IF (FSATUR(J).GT.FCT) JCOLD=J+1
          IF (FSATUR(J).GT.FCT) GOTO 440
         FCT=FSATUR(J)
        ENDDO
      else
        FCT=FSATUR(1)
        DO J=1,ND-1
          FCT=AMIN1(FCT,FSATUR(J+1))
        ENDDO 
	JCOLD = 1
	DO J = ND, 2, -1
	   IF (JCOLD .EQ. 1) THEN
             IF (FSATUR(J) .LT. FSATUR(J-1)) JCOLD = J
	   END IF
	END DO
	IF ((JCOLD.LT.10).or.(JCOLD.gt.(ND-10))) then
           JCOLD=JCOLD_OLD
           print*, "JCOLD OUT OF BOUNDS, NEW JCOLD:",JCOLD
        ENDIF


      endif
c Water from the cold trap to the ground
 440  DO J = JCOLD, ND
       FI(1,J) = FSATUR(J)*RELHUM(P(J))
       if(IMW.eq.2) FI(1,J) = amax1(FI(1,J),4.e-6)
      END DO

c Water from the cold trap to the top (if it is used in the coupled 
c mode these values are given by the photochemical codea)
       if(ICOUPLE.eq.0)then
         DO J = JCOLD-1, 1, -1
           FI(1,J)= FI(1,JCOLD)
           if(IMW.eq.2) FI(1,J) = 4.e-6
          END DO
        endif

C-KK To smooth over the water profile around JCOLD.
      sum = 2.*FI(1,(JCOLD-1)) + FI(1,(JCOLD+1)) + 2.*FI(1,JCOLD)
      FI(1,JCOLD) = sum/5.

      
      CALL CALTITUDE(NST,T,FI,DZ)
c Tranferring altitude to coupled model
      do ii=1,ND
        XALT(ii)=ALT(ii)
      enddo

      divf1=ABS(DIVF(1))
      xratio = DIVFOLD(1)/DIVF(1)
c A. Zsom
c      if(ICONSERV.eq.1) then
c         if(xratio.lt.0..or. divf1.lt.1.e-4) ISTOP=1
c      endif
      if(ISTOP.eq.1) go to 50

c printing surface temperature
c$$$      print*,NST
c$$$      print*,T(ND)
c$$$      print*,DIVF(1)
c$$$      print*,'JCOLD, ALT(JCOLD)',JCOLD, ALT(JCOLD)
c$$$      print*,'*******'

c Adjusting the time stepper
       DTS = dt0
       CHG = 0.
       DO J=2,ND-1
         REL = ABS(DELT(J)/TOLD(J))
         CHG = AMAX1(CHG,REL)
       END DO
       IF (CHG.LT.0.01) dt0 = DTS*1.5
       IF (CHG.LT.0.001) dt0 = DTS*5.
       IF (CHG.GT.0.02) dt0 = DTS/2.
       IF (dt0.GE.dtmax) dt0 = dtmax
       
       If (NST .eq. NSTEPS) then 
          print*,"climate iteration: ",NST
          print*,'end: T ,  P'
          DO J=1,ND
             print*,T(J),P(J)
          ENDDO
          print*,"dt0",dt0
c printing surface temperature
          print*,"Surface Temp:",T(ND)
          print*,"DIVF(top)",DIVF(1)
          print*,"ALBEDO:",ALBP, FUPSOL(1)/FDNSOL(1)
          print*,FUPSOL(1),FUPSOL(ND)
          print*,'*******'
          print*,FDNSOL(1),FDNSOL(ND)
          print*,'*******'
          print*,FUPIR(1),FUPIR(ND)
          print*,'*******'
          print*,FDNIR(1),FDNIR(ND)
          print*,'*******'
          print*,'JCOLD, ALT(JCOLD)',JCOLD, ALT(JCOLD)
          print*,'*******'
       endif
C***********************************************************
c***  WRITING OUTPUT FILES
************************************************************
c
c A. Zsom (03.28.2011): changed the format of the clima_allout.tab to
c use it with the read_clima_allout.pro file for data visualization and convergen tests
c 20.04.2011 A. Zsom: changed the format a bit again.

  50  IF((ncouple.EQ.1).and.(nst.eq.1)) THEN
       WRITE(51,*)       
      WRITE(51,*) "   OUTPUT FILES FOR THE ",STARR
      WRITE(51,*)   
      WRITE(51,555) SOLCON,FCH4,FCO2,FO2,FN2,IO3,IUP
 555  format(1x,'Solar Constant= ',F3.1,3x,'F_CH4= ',1pe10.4,2x,
     & 'F_CO2= ',1pe10.4,2x,'F_O2= ',1pe10.4,2x,'F_N2= ',1pe10.4,2x,
     & 'IO3 = ',I2,3x,'IUP= ',I2)
      WRITE(51,*)
      if(FCO2.gt.CO2MAX)write(51,550)
      write(51,*)ND
      
      ENDIF
 550  format(10x,'*** fCO2 > CO2MAX The old IR subroutine is used')
      nsteps2 = nsteps-2
      nsteps3 = nsteps-3
c   Printing main diagnostic parameters for NST>=3 to NST<= NSTEPS-3
c      if(nst.gt.2 .and. nst.lt.nsteps2) then 
c       if(iconserv.eq.0) then  
c       WRITE(51,966) NST,JCONV,CHG,dt0,DIVF(1),DELT(ND),T(ND) 
c 966   FORMAT(1x,'NST=',I3,2X,'JCONV=',I4,2x,'CHG=',1pe9.3,2x,'dt0=',
c     & 1pe9.3,2X,'DIVF(1)=',1PE12.5,2X,'DT(ND)=',1PE10.3,1x,
c     & 'T(ND)=',1PE10.4)
c       else
c       WRITE(51,968) NST,JCONV,CHG,dt0,TIME,DIVF(1),DELT(ND),T(ND) 
c 968   FORMAT(1x,'NST=',I3,2X,'JCONV=',I4,2x,'CHG=',1pe9.3,2x,'dt0=',
c     & 1pe9.3,2X,'TIME=',1pe9.3,2x,'DIVF(1)=',1PE12.5,2X,'DT(ND)=',
c     & 1PE10.3,1x,'T(ND)=',1PE10.4)
c       endif
c       ENDIF
c   Printing everything for NST < 3 and for NST > NSTEPS-3 
c      if(nst.eq.nsteps3.or.ISTOP.eq.1) write(51,*)       
c      if(nst.lt.3 .or. nst.gt.nsteps3 .or. ISTOP.eq.1) then
      if (mod(nst,20).eq.0) then
       if(iconserv.eq.0) then 
       WRITE(51,965) NST,dt0,DELT(ND),T(ND),DIVF(1),FTOTAL(ND-1),
     & FTIR(ND-1),FTSO(ND-1)
 965   FORMAT(1x,'NST=',I3,2X,'dt0=',1PE9.3,2x,'DT(ND)=',1PE10.3,2x,
     & 'T(ND)=',1PE10.4,2X,'DIVF(1)=',1PE12.5,2X,/,3x,
     & 'Ftot(ND-1)=',1pe11.4,2x,'FtIR(ND-1)='
     & ,1pe11.4,2x,'FtSol(ND-1)=',1pe11.4,/)
       else
       WRITE(51,967) NST,dt0,TIME,DELT(ND),T(ND),DIVF(1),
     & FTOTAL(ND-1),FTIR(ND-1),FTSO(ND-1)
 967   FORMAT(1x,'NST=',I3,2X,'dt0=',1PE9.3,2x,'TIME=',1pe9.3,
     & 2x,'DT(ND)=',1PE10.3,2x,'T(ND)=',1PE10.4,2X,'DIVF(1)=',
     & 1PE12.5,/,3X,'Ftot(ND-1)=',1pe11.4,2x,'FtIR(ND-1)='
     & ,1pe11.4,2x,'FtSol(ND-1)=',1pe11.4,/)
       endif
      WRITE(51,683)
        DO J=1,ND
      WRITE(51,680) J,P(J),ALT(J),T(J),FLAGCONVEC(J),
     & DELT(J),TOLD(J),FI(1,J),TCOOL(J),THEAT(J),FI(4,J)
       ENDDO
      WRITE(51,685)
         DO J=1,ND
      WRITE(51,684) J,PF(J),ALT(J),FTOTAL(J),FTIR(J),FDNIR(J),
     & FUPIR(J),FTSO(J),FDNSOL(J),FUPSOL(J),DIVF(J)
         ENDDO
      WRITE(51,*)   
c      END IF	
 683  FORMAT(/2x,'J',5X,'P',8X,'ALT',8X,'T',7X,'CONVEC',
     & 7X,'DT',11X,'TOLD',8x,'FH20',
     &  8x,'TCOOL',8x,'THEAT')
 680  FORMAT(I3,3(1x,1PE10.4),1X,1PE9.2,2X,1PE11.4,6(1X,1PE11.4))
 685  FORMAT(/2x,'J',4X,'PF',9X,'ALT',7X,'FTOTAL',7X,'FTIR',7X,'FDNIR',
     & 7X,'FUPIR',7X,'FTSOL',7X,'FDNSOL',7X,'FUPSOL',7X,'DIVF')
 684  FORMAT(I3,2(1x,1PE10.4),8(1X,1PE11.4))
      endif
      close(98)
  56  if(ISTOP.eq.1) goto 55

***************************************************************
C   End of iterative loop
  40  CONTINUE
***************************************************************
     
  55  if(ICOUPLE.eq.1) then
      OPEN(unit=55,file= dircoup//'/mixing_ratios.dat')
       CALL OUTPUT_PHOTO(T, FI, water, ALT,O3save,JCOLD,DZPHOT)
      endif

      OPEN (unit=57,file= DIRINOUT//'/TempIn.dat')
      DO J=1,ND
        WRITE(57,*) T(J),FI(1,J)
      ENDDO
      close(57)

      if(ICOUPLE.eq.0)then
      open(unit=401, file=dircoup//'/chem-lisa.dat')
      open(unit=402, file=dircoup//'/altPT-lisa.dat')

      write(402,1001)
 1001 format(/'!Atmospheric profiles.  The three columns are:'/
     & '!geometric altitude (km),temperature (K),pressure (millibars)')
      write(402,1002)
 1002 format('!',8x,'alt(km)',2x,'T(K)',3x,'P(mbar)')
      do i=ND,1,-1
       xPmbar=P(i)*1.e3
       write(402,1003)ALT(i),T(i),xPmbar
      enddo
 1003 format('Z,T,P',3x,F6.2,2x,F7.3,1x,E11.5)
 
      do j=1,NS1
      if(j.eq.1) then    
      write(401,1005)'H2O'
      write(401,1007)'H2O',(FI(1,i),i=ND,1,-1)
      write(401,1009)'H2O',(ALT(i),i=ND,1,-1)
      endif

      if(j.eq.2) then    
      write(401,1005)'CO2'
      write(401,1007)'CO2',(FI(2,i),i=ND,1,-1)
      write(401,1009)'CO2',(ALT(i),i=ND,1,-1)
      endif

      if(j.eq.3) then    
      write(401,1005)'CH4'
      write(401,1007)'CH4',(FI(3,i),i=ND,1,-1)
      write(401,1009)'CH4',(ALT(i),i=ND,1,-1)
      endif

      if(j.eq.4) then    
      write(401,1005)'O3'
      write(401,1007)'O3',(FI(4,i),i=ND,1,-1)
      write(401,1009)'O3',(ALT(i),i=ND,1,-1)
      endif
      enddo
   
      write(401,1005)'O2'
      write(401,1007)'O2',(FO2,i=ND,1,-1)
      write(401,1009)'O2',(ALT(i),i=ND,1,-1)
      
 1005  format(/'Molecule ',A8)
 1007  format(/A8,'_MR',5(3x,E9.2),'  ^')
 1009  format(/A8,'_ALT',5(3x,F6.2),'  ^')
      close(401)
      close(402)  

       endif
      
c      write(*,'(A,F6.2)')'T surf = ',T(ND)
c      write(*,'(A,E8.3)')'DIVF = ',DIVF(1)


       RETURN
      END                 !end of the main program

*********************************************************************
      SUBROUTINE CALTITUDE(NST,T,FI,DZ)
      COMMON/CONS/C,BK,G,PI,SM,DM
c Zsom
      INCLUDE 'INCLUDECLIM/parND.inc'
      INCLUDE 'INCLUDECLIM/parNS1.inc'

      COMMON/ALTBLOK/DALT(ND-1),ALT(ND)
      DIMENSION T(ND),FI(NS1,ND),DZ(ND)    


c-as  This subroutine calculates the altitude.
c-as  The water vapor was eliminated the first time this subroutine
c-as  is called (before the NSTEPS DO loop) in order to make easier 
c-as  the parameter translation to the photochemical model

      BKM = BK/(SM*G)
      ALT(ND) = 0.
      DO J=ND-1,1,-1
       TA = 0.5*(T(J) + T(J+1))
       FH2O = 0.5 * (FI(1,J) + FI(1,J+1))
       AM = 18.*FH2O + DM*(1. - FH2O)
       IF(NST.lt.1) AM = DM     
       BMG = BKM/AM
       ALT(J) = ALT(J+1) + BMG*TA*DZ(J+1)*1.E-5
       DALT(J) = ALT(J) - ALT(J+1)
      ENDDO
      RETURN
      END

