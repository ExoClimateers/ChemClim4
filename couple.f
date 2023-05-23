
*  Created by Antigona Segura. April 4, 2005.
       
       program couple

C SR MacGregor: reading in DELZ
       REAl DZ,dummy

*  This program runs the climate and photochemical model in a coupled mode
*  and generates an output file for diagnostics
       INCLUDE 'CLIMA/INCLUDECLIM/parND.inc'
       INCLUDE 'CLIMA/INCLUDECLIM/parNSOL_NSOLUV.inc'
       INCLUDE 'ATMCHEM/INCLUDECHEM/parNZ.inc'
       INCLUDE 'ATMCHEM/INCLUDECHEM/parNQ_NQT.inc'
c      INCLUDE 'ATMCHEM/INCLUDECHEM/comABLOK.inc'

       INCLUDE 'ATMCHEM/INCLUDECHEM/parNSP_NSP1_NSP2.inc'

       CHARACTER :: STARR*3,dirIO*2,AA*35,alloutname*40
       CHARACTER :: callsname*40

c Common blocks with CLIMATE model
       INCLUDE 'INCLUDECOUP/comCLIM.inc'
       INCLUDE 'INCLUDECOUP/comFLUXCLIMA.inc'

c Common bloCKs with PHOTOCHEMICAL model
      INCLUDE 'INCLUDECOUP/comPHOT.inc'
      INCLUDE 'INCLUDECOUP/comO3SAV.inc'
      INCLUDE 'ATMCHEM/INCLUDECHEM/comFLUXPHOTO.inc'

      INCLUDE 'INCLUDECOUP/comDIAG.inc'
      INCLUDE 'INCLUDECOUP/comSTR.inc'
      dirIO = 'IO'
      
c A. Zsom: input file:
      open(unit=2, file= dirIO//'/input_couple.dat')
      OPEN(unit=666,file= dirIO//'/planet.dat')  

c OUTPUT FILES
      open(unit=1, file= dirIO//'/output_couple.dat')
      OPEN(unit=90,file= dirIO//'/outchem.dat') 
      open(unit=600, file= dirIO//'/convergence.txt')


      IMODEL = 3
      niter = 1
      FLUXFAC = 1.
      ilisa=1
      
        
      read(2,*)AA
      read(2,*)STARR
      read(2,*)FLUXFAC
      read(2,*)niter
      read(2,*)NSTEPSC
      read(2,*)NSTEPSP
      read(2,*)alloutname
      read(2,*)callsname
      close(2)

      read(666,*)dummy
      read(666,*)dummy
      read(666,*)dummy
      read(666,*)dummy
      read(666,*)DZ
      read(666,*)dummy
      read(666,*)dummy
      
      close(666)

c      write(*,*)DZ,NZ
c      stop

c A. Zsom: opening the clima_allout file (either clear or cloudy)
      OPEN(UNIT=51,FILE= dirIO//'/'//alloutname)
c 20.04.2011 A. Zsom: this file will contain how many iterations were done 
c and how many times the climate code was called 
c output is written after call clima() 
      OPEN(UNIT=555,FILE= dirIO//'/'//callsname)
            
c A. Zsom
c Choose a star
c Sarah's stars: F2a, K2a, G2a, F0V, F5V, F9V, G2V, G8V, K2V, K8V 
      write(*,*)'The star:'
      write(*,*)STARR

c Choose programs
      ICOUPLE=1   
      
      if(ICOUPLE.eq.0) then
       	write(*,*)'What model do you want to use?'
       	write(*,*)'0-climate, 1-photochemical'
	IMODEL=1
	write(*,*)IMODEL
      else
       	write(*,*)'Iterations between both models:'
	write(*,*)niter
      endif
  
    
  
c  Choose ir scheme in clima.f
      if(IMODEL.ne.1) then
c       	write(*,*)'What infrared scheme do you want to use?'
c       	write(*,*)'0-RRTM, 1-IR'

	IRCHOICE=0
c	write(*,*)IRCHOICE
c Factor to multiply the star flux
c For F2V FLUXFAC = 0.95
       	write(*,*)'Factor to multiply the star flux'
       	write(*,*)'1. is the default'
	write(*,*)FLUXFAC
       	if(fluxfac.le.0.)FLUXFAC=1.
c Parameters to run the climate model
       	write(*,*)'For the climate model:'
       	write(*,*)'Number of steps (200 recommended for coupled mode)'
       	write(*,*)NSTEPSC
      endif
c Photochemical model 
      if(IMODEL.eq.1.or.ICOUPLE.eq.1) then
       	write(*,*)'For the photochemical model:'
       	write(*,*)'Number of steps (400 recommended for coupled mode)'
       	write(*,*)NSTEPSP
	
      endif
 
 
      	print*,'end reading parameters'
c Read star flux for the photochemical model
      	if(IMODEL.eq.1.or.ICOUPLE.eq.1) call readstar(FLUXFAC)
c Read star flux for the climate model
      	if(IMODEL.eq.0.or.ICOUPLe.eq.1) then
        	call choose_star(FLUXFAC,FLUXC,FLUXUV)
      	endif
       	print*,'end reading stellar fluxes'
cccccccccccccccccccccccccccccccccccccccccccc	
c Starting loop for steady-state equilibrium
cccccccccccccccccccccccccccccccccccccccccccc
      	do 1 ncouple=1,niter   !START steady-state loop
       		print*,''
       		print*,'loop number ',ncouple
       		print*,''
c Running the climate code
       		if(IMODEL.eq.0.or.ICOUPLE.eq.1) then
       			DTC = 1.e4       !initial time step (s)
       			dtmax = 1.e5      !maximum time step (s)
       			TSTOP = 1.e7
       			TIMEC = 1.e10
       			print*,'before climate'
       			CALL CLIMA(ncouple,FLUXFAC,IRCHOICE,ICOUPLE,DTC,NSTEPSC,
     & 				dtmax,TSTOP,TIMEC)
c 20.04.2011 A. Zsom: writting into clima_calls.tab
			write(555,*)ncouple,NSTEPSC     
       		endif
       		print*,'end climate'
c Running the photochemical code
       		if(IMODEL.eq.1.or.ICOUPLE.eq.1)then
       			DTP = 1.e-4      !initial time step
       			TSTOP = 5.e17
       			CALL ATM_CHEM(ncouple,FLUXFAC,ICOUPLE,TSTOP,
     &       			DTP,NSTEPSP,TIME)
       		endif
c Calculating diagnostic parameters for stady-state convergence
       		if (ICOUPLE.eq.0) go to 3
        	call diagnostic(nconvdif,ncouple,niter)
        	if(nconvdif.ne.0) then
c A. Zsom
c        close(51)
c comment next line if you want every iteration of outchem written to file
        close(90)
        	OPEN(UNIT=51,FILE= dirIO//'/'//alloutname)
        	OPEN(unit=90,file= dirIO//'/outchem.dat')
       	endif
        print*,'end photo'
c S. MacGregor changing so output couple files are written always
c SM      	if(ncouple.eq.niter.and.nconvdif.ne.0) then
c SM      		write(1,*)'** WARNING: STEADY STATE SOLUTION NOT REACHED **'
c SM      		call outdiag(ncouple)
c SM      		print*,'*** WARNING: STEADY STATE SOLUTION NOT REACHED ***'
c SM      		STOP
c SM      	endif
c SM      	if(nconvdif.eq.0) go to 2  
        if(ncouple.eq.niter) goto 2
  1   enddo                  !END steady-state loop 
  
c Printing diagnostic parameters for the steady solution
  2   call outdiag(ncouple)
      call outatmos(fluxfac,DZ)
      if(ilisa.eq.1) call outlisa(DZ)
      stop

  3   close(51)
      close(90)
c A. Zsom
      close(555)
      close(600)
      stop
      end          


*******************
      subroutine diagnostic(nconvdif,ncouple,niter)
c This subroutine indicates when the photochemical and
c climate model have reached convergence
       INCLUDE 'CLIMA/INCLUDECLIM/parND.inc'
       INCLUDE 'ATMCHEM/INCLUDECHEM/parNZ.inc'
       INCLUDE 'ATMCHEM/INCLUDECHEM/parNQ_NQT.inc'
       INCLUDE 'ATMCHEM/INCLUDECHEM/parNSP_NSP1_NSP2.inc'

c Common blocks with CLIMATE model
      INCLUDE 'INCLUDECOUP/comCLIM.inc'

c Common blocks with PHOTOCHEMICAL model
      INCLUDE 'INCLUDECOUP/comPHOT.inc'
      INCLUDE 'INCLUDECOUP/comO3SAV.inc'

      INCLUDE 'INCLUDECOUP/comDIAG.inc'

      nconver = 0
      nconv1 = 0
      nconv2 = 0
      nconv3= 0

c equilibrium conditions for the photochemical model
c   *** for species with fixed surface flux
      numlb2tot = 0
      numlb2 =0
      do i=1,NQT
       if(LLBOUND(i).eq.2)then
        nconv1 = 1
        numlb2tot = numlb2tot + 1
        dflux(i) = XFLOW(i)/XSGFLUX(i)
        if(dflux(i).ge.0.99.and.dflux(i).le.1.01) 
     &   numlb2 = numlb2 + 1
       endif 
      enddo
      if(numlb2.gt.0) then
        perlb2= numlb2/numlb2tot
        if(perlb2.eq.1.)then
         nconver=nconver+1
         print*,'Eq. for fixed fluxes, reached'
        endif
      endif 
c   *** for species with fixed mixing ratio
      numlb1tot = 0
      numlb1 =0
      do i=4,NQT
       if(LLBOUND(i).eq.1) then
        nconv2 = 1
        numlb1tot = numlb1tot + 1
        dlflux(i) = XFLOW(i)/XTL(i)
        if(i.eq.9) then
          dmixh2 = XUSOL(i,1)/FH2
          if(dmixh2.ge.0.99.and.dmixh2.le.1.01) 
     &    numlb1 = numlb1 + 1
        endif
        if(i.eq.10)then
          dmixch4 = XUSOL(i,1)/FCH4
          if(dmixch4.ge.0.99.and.dmixch4.le.1.01) 
     &    numlb1 = numlb1 + 1
        endif
        if(i.eq.11)then
          dmixco = XUSOL(i,1)/FCO
          if(dmixco.ge.0.99.and.dmixco.le.1.01) 
     &    numlb1 = numlb1 + 1
        endif
        if(i.eq.14)then
          dmixn2o = XUSOL(i,1)/FN2O
          if(dmixn2o.ge.0.99.and.dmixn2o.le.1.01) 
     &    numlb1 = numlb1 + 1
        eNDIf
        if(i.eq.23)then
          dmixch3cl = XUSOL(i,1)/FCH3CL
          if(dmixch3cl.ge.0.99.and.dmixch3cl.le.1.01) 
     &    numlb1 = numlb1 + 1
        endif
       endif
      enddo
      if(numlb1.gt.0)then
       perlb1= numlb1/numlb1tot
       if(perlb1.eq.1.) then
         nconver=nconver+1
         print*,'Eq. for fixed abundances reached'
       endif
      endif
c   *** for species with fixed velocity deposition
      numlb0tot = 0
      numlb0 =0
      do i=1,NQT
       if(LLBOUND(i).eq.0) then
        nconv3 = 1
        numlb0tot = numlb0tot + 1 
        dlospro(i) = XTL(i)/XTP(i)
        if(i.eq.9) dlospro(i)=1.
         if(dlospro(i).ge.0.9.and.dlospro(i).le.1.1) 
     &   numlb0 = numlb0 + 1
       endif
      enddo      
      if(numlb0.gt.0) then 
       perlb0= (numlb0*1.)/(numlb0tot*1.)
        print*,'vel dep. ',perlb0
       if(perlb0.ge.0.9) then
c        if(perlb0.ge.0.65) then    !for AD Leo
        nconver=nconver+1
        print*,'Eq. for fixed deposition velocity, reached'
       endif
      endif

c For the ozone column depth
      dO3= ABS(1.-(XO3COL/O3OLD))
      PRINT*,'O3 old ',O3OLD,' O3 new ',XO3COL, ' dif ',dO3
      if(dO3.lt.0.02) then
        nconver =nconver +1
       print*,'Eq. for O3 column depth, reached'
      endif

C Equilibrium conditions for the climate code
c  *** Temperature at the surface, the top, the last convective
c   layer and the tropopause
c Ratio of fluxes at the top of the atmosphere (DIVF)
      do i=ND,1,-1
        dtn(i) = abs(Tstart(i)-T(i))
      enddo
      If(dtn(ND).le.1.) nconver = nconver + 1
      if(dtn(1).le.3.) nconver = nconver + 1
      if(dtn(JCOLD).le.2.)nconver = nconver + 1
      if(dtn(JCONV).le.2.)nconver = nconver + 1
c SR MacGregor putting absolute value around div(f) criterion to test proper convergence
      if(abs(divf(1)).le.1e-3)nconver = nconver + 1
C Summing up the equilibrium conditions
C When all the conditions are reached nconvdif = 0   
      nconvtot = nconv1 + nconv2 + nconv3 + 7
      nconvdif = nconvtot - nconver
c SR MacGregor subtracting 1 from nconvtot and nconvdif to accurately display convergence
      write(*,110)nconver, nconvtot-1,nconvdif-1
 110  format(I2,' convergence criteria of ',I2,' have been reached. ',
     & I2,' more need to be reached')


c SR MacGregor writing output file convergence.txt with convergence criteria in final run
      if(ncouple.eq.niter) then
         write(*,*)"In IF statement"
         write(600,*)"NCOUPLE ",ncouple, " NITER ",niter
         write(600,110)nconver, nconvtot-1,nconvdif-1
         if(dtn(ND).le.1.) write(600,*) "conv dtn(ND) < 1. passed"    
         if(dtn(1).le.3.) write(600,*) "conv dtn(1) < 3. passed" 
         if(dtn(JCOLD).le.2.) write(600,*) "dtn(JCOLD < 2 passed"
         if(dtn(JCONV).le.2.) write(600,*) "dtn(JCONV < 2 passed"
         if(abs(divf(1)).le.1e-3) write(600,*) "divF < 1e-3 passed"
         if(dO3.lt.0.02) write(600,*)"eq. for O3 col depth reached"
         if(perlb0.ge.0.9) write(600,*)"perlb0 > 0.9 cond. reached"
         if(nconv1 eq 1) write(600,*)"fixed flux eq condition reached"
         if(nconv2 eq 1) write(600,*)"fixed mixing eq condition reached"
         if(nconv2 eq 1) write(600,*)"Eq. fixed deposition vel, reached"
         
      endif

      return
      end
*******************

      subroutine outdiag(ncouple)
       INCLUDE 'CLIMA/INCLUDECLIM/parND.inc'
       INCLUDE 'ATMCHEM/INCLUDECHEM/parNZ.inc'
       INCLUDE 'ATMCHEM/INCLUDECHEM/parNQ_NQT.inc'
       INCLUDE 'ATMCHEM/INCLUDECHEM/parNSP_NSP1_NSP2.inc'

      INCLUDE 'INCLUDECOUP/comCLIM.inc'

      INCLUDE 'INCLUDECOUP/comPHOT.inc'
      INCLUDE 'INCLUDECOUP/comDIAG.inc'


c Printing diagnostic parameters from the steady state solution 
      write(1,100)ncouple
 100  format(/'*** Output file for diagnostics after ',I2,
     &' coupled iterations ***')
      write(1,120)
 120  format(/'*** PHOTOCHEMICAL MODEL output')
      write(1,122)XO3COL
 122  format(/' Ozone column depth = ',1PE11.4,' cm^-2')
      write(1,121)
 121  format(/' Results sorted by Lower Boundary Condition'/) 
      
      ifix = 0
      do i=1,NQT
       if(LLBOUND(i).eq.2) then
         ifix=1
         goto 210
       endif
      enddo
 210  if(ifix.eq.1) then
      write(1,*)' Species with fixed surface FLUX'
      write(1,123)
 123  format(6x,'Specified flux',3x,'Calculated flux',4x,'calc/spec'
     & ,6x, 'TL') 
      do i=1,NQT
       if(LLBOUND(i).eq.2) write(1,130)IISPEC(i),XSGFLUX(i),
     & XFLOW(i),dflux(i),XTL(i)
      enddo
 130  format(1x,A8,2x,1PE9.2,4x,1PE9.2,9x,1PE9.2,3x,1PE9.2)
      endif
      imix = 0
      do i=4,NQT
       if(LLBOUND(i).eq.1) then
         imix=1
         goto 220
       endif
      enddo
 220  if(imix.eq.1) then
      write(1,*)
      write(1,*)' Species with fixed surface MIXING RATIO'
      write(1,124)
 124  format(7x,'Specified M R',3x,'Calculated M R',3x,'calc/spec',
     & 6x,'TL',9x,'TP',9x,'TP/TL') 
      do i=4,NQT
       if(LLBOUND(i).eq.1) then
        if(i.eq.9)write(1,131)IISPEC(i),FH2,XUSOL(i,1),dmixh2,
     & XFLOW(i),XTL(i), dlflux(i)
        if(i.eq.10)write(1,131)IISPEC(i),FCH4,XUSOL(i,1),dmixch4,
     & XFLOW(i),XTL(i), dlflux(i)
        if(i.eq.11)write(1,131)IISPEC(i),FCO,XUSOL(i,1), dmixco,
     & XFLOW(i),XTL(i), dlflux(i)
        if(i.eq.14)write(1,131)IISPEC(i),FN2O,XUSOL(i,1),dmixn2o,
     & XFLOW(i),XTL(i), dlflux(i)
        if(i.eq.23)write(1,131)IISPEC(i),FCH3CL,XUSOL(i,1),dmixch3cl,
     & XFLOW(i),XTL(i), dlflux(i)
       endif
      enddo
 131  format(1x,A8,2x,1PE9.2,4x,1PE9.2,6x,1PE9.2,3x,1PE9.2,
     & 3x,1PE9.2,3x,1PE9.2)     
      endif

      write(1,*)
      write(1,*)' Species with fixed VELOCITY DEPOSITION'
      write(1,125)
 125  format(15x,'TL',9x,'TP',9x,'TL/TP')
      do i=1,NQT
       if(LLBOUND(i).eq.0)write(1,132)IISPEC(i),XTL(i),XTP(i),dlospro(i)
      enddo      
 132  format(1x,A8,2x,1PE9.2,3x,1PE9.2,3x,1PE9.2) 

      write(1,150)
 150  format(/'*** CLIMATE MODEL output'/)
      write(1,*)'  Selected temperatures for diagnostic'
      write(1,151)
 151  format(1x,'Layer',4x,'T_Ncoup-1',7x,'T_Ncoup',7x,'(T_n-1)-(T_n)'
     & ,5x,'DIVF_Nstep')
      do i=ND,1,-1
       if(i.eq.ND.or.i.eq.ND-1)write(1,152)i,Tstart(i),T(i),dtn(i),
     & DIVF(i)
       if(i.eq.JCOLD)then
        write(1,*)' At the cold trap '
        write(1,152)i,Tstart(i),T(i),dtn(i),DIVF(i)
 152  format(1x,I3,4(4x,1PE12.4))
       endif
       if(i.eq.JCONV)then
        write(1,*)' Last convective layer '
        write(1,152)i,Tstart(i),T(i),dtn(i),DIVF(i)
       endif
       if(i.eq.1.or.i.eq.2)write(1,152)i,Tstart(i),T(i),dtn(i),
     & DIVF(i)
      enddo
 
      return
      end
**************************
      subroutine outatmos(fluxfac,DZ)
c 
       INCLUDE 'CLIMA/INCLUDECLIM/parND.inc'
       INCLUDE 'ATMCHEM/INCLUDECHEM/parNZ.inc'
       INCLUDE 'ATMCHEM/INCLUDECHEM/parNQ_NQT.inc'
       INCLUDE 'ATMCHEM/INCLUDECHEM/parNSP_NSP1_NSP2.inc'
c       INCLUDE 'ATMCHEM/INCLUDECHEM/comABLOK.inc'
      dimension z(nz),WAV(108),WAVEUV(10),PRESS(NZ)
      INCLUDE 'INCLUDECOUP/comCLIM.inc'

      INCLUDE 'INCLUDECOUP/comPHOT.inc'
      INCLUDE 'ATMCHEM/INCLUDECHEM/comFLUXPHOTO.inc'


      DATA WAV/1762.,1778.,1794.,1810.,1827.,1844.,1861.,1878.,
     & 1896.,1914.,1933.,1952.,1971.,1990.,2010.,2031.,2052.,2073.,
     & 2094.,2117.,2140.,2163.,2187.,2211.,2235.,2260.,2286.,2313.,
     & 2340.,2367.,2396.,2425.,2454.,2485.,2516.,2548.,2581.,2615.,
     & 2650.,2685.,2722.,2759.,2798.,2837.,2878.,2920.,2963.,3008.,
     & 3054.,3101.,3150.,3200.,3250.,3300.,3350.,3400.,3438.,3500.,
     & 3600.,3700.,3800.,3900.,4000.,4100.,4200.,4300.,4400.,4500.,
     & 4600.,4700.,4800.,4900.,5000.,5100.,5200.,5300.,5400.,5500.,
     & 5600.,5700.,5800.,5900.,6000.,6100.,6200.,6300.,6400.,6500.,
     & 6600.,6700.,6800.,6900.,7000.,7100.,7200.,7300.,7400.,7500.,
     & 7600.,7700.,7800.,7900.,8000.,8100.,8200.,8300.,8400.,8500/
c 10 Far UV wavelengths at the lower limit of the interval. 
c The last wavelegth is for Lyman alpha
      data WAVEUV/1725.,1675.,1625.,1575.,1525.,1475.,1425.,
     &            1375.,1325.,1216./     

      ifile = 1
      BK = 1.38E-16

      write(1,169) 
 169  format(/2x,'** PARAMETERS OF THE ATMOSPHERE AT STEADY STATE **')
      write(1,170) fluxfac
 170  format(//1x,'Factor for stellar flux = ',F10.4)
      write(ifile,171)XO3COL
 171  format(//1x,'Ozone column depth = ', 1pe11.4,' cm^-2')
      write(ifile,172)

 172  format(/3X,'*** Surface fluxes (cm^-2 s^-1) ***'/)
      write(ifile,173)IISPEC(9),IISPEC(10),IISPEC(11),
     & IISPEC(14),IISPEC(23)
      write(ifile,174)XFLOW(9),XFLOW(10),XFLOW(11),
     & XFLOW(14),XFLOW(23)
 173  FORMAT(5X,6(A6,5X))
 174  FORMAT(6(1X,1PE10.3))
 
      write(ifile,175)
 175  FORMAT(/3X,'*** Mixing ratios ***'/)
c printing mixing ratios of: H2O,H2,CH4,CO,N2O,H3Cl
      write(ifile,176)IISPEC(3),IISPEC(9),IISPEC(10),IISPEC(11),
     & IISPEC(14),IISPEC(23)
 176  FORMAT(1X,'Z (km)',1x,'P(dyn/cm^2)',3X,6(A8,2X))
      do i=1,NZ
c calculating pressure in dyn/cm2
        PRESS(i)=XDEN(i)*BK*XTCH(i)
c SR MacGregor properly calculate Z for output_couple
c        z(i) = i - 1. + 0.5
         z(i) = (i-1)*DZ*1.e-5 + 0.5*DZ*1.e-5 
        write(ifile,177) Z(I),PRESS(i),XUSOL(3,i),XUSOL(9,i),
     &  XUSOL(10,i),XUSOL(11,i),XUSOL(14,i),XUSOL(23,i)
      enddo
 177  FORMAT(1x,f5.2,2X,1P7E10.3)
      

      write(ifile,178)
 178  format(/3X,'*** Number densities (cm^-3) ***'/)
      write(ifile,179) IISPEC(4),IISPEC(7)
 179  format(2x,'Z(km)',1x,'P(dyn/cm^2)',3x,'Total',2x,2(A8,4X))
      do i=1,NZ
        write(ifile,177) Z(I),PRESS(i),XDEN(i),XSL(4,i),XSL(7,i)
      enddo
      
      write(ifile,180)
 180  FORMAT(/4X,'ENERGY FLUXES IN W/m^2/nm and photons/m^2/s/nm
     & (NOT DIURNALLY AVERAGED)')       
      write(ifile,181)
 181  FORMAT(/8X,'WAV',8X,'EFLUX',8X,'GFLUX',8x,'PhEFLUX',
     & 6x,'PhGFLUX')
      do jj=10,1,-1
        feflux = ESFX(jj)
        fgflux = GSFX(jj)
        fpheflux = PhESFX(jj)
        fphgflux = PhGSFX(jj)
        write(ifile,182)WAVEUV(jj),feflux,fgflux,fpheflux,fphgflux
      enddo
      do jj=1,108
        feflux = EFLUX(jj)
        fgflux = GFLUX(jj)
        fpheflux = PhEFLUX(jj)
        fphgflux = PhGFLUX(jj)
        write(ifile,182)WAV(jj),feflux,fgflux,fpheflux,fphgflux
      enddo
 182  FORMAT(2X,1P7E13.5)
      
      write(ifile,190)
 190  format(//3x,'**** From the climate model ****'/)
      write(ifile,191)
 191  format(5x,'P (atm)',5x,'Alt (km)',9x,'T',9x,'DIVF')
      do i=1,ND
       write(ifile,192) XP(i),XALT(i),T(i),DIVF(i)
      enddo
 192  format(4(2x,1pe11.4))
      
      return
      end


**************************
      subroutine outlisa(DZ)
c 
       INCLUDE 'CLIMA/INCLUDECLIM/parND.inc'
       INCLUDE 'ATMCHEM/INCLUDECHEM/parNZ.inc'
       INCLUDE 'ATMCHEM/INCLUDECHEM/parNQ_NQT.inc'
       INCLUDE 'ATMCHEM/INCLUDECHEM/parNSP_NSP1_NSP2.inc'
       CHARACTER :: dirIO*2
c       INCLUDE 'ATMCHEM/INCLUDECHEM/comABLOK.inc'

c Common blocks with CLIMATE model
      INCLUDE 'INCLUDECOUP/comCLIM.inc'

c Common bloCKs with PHOTOCHEMICAL model
      INCLUDE 'INCLUDECOUP/comPHOT.inc'
      INCLUDE 'INCLUDECOUP/comDIAG.inc'
      dimension z(nz)
        dirIO = 'IO'
c
      open(unit=401,file=dirIO//'/chem-lisa.dat')
      open(unit=402,file=dirIO//'/altPT-lisa.dat')


      write(402,1001)
 1001 format(/'!Atmospheric profiles.  The three columns are:'/
     & '!geometric altitude (km),temperature (K),pressure (millibars)')
      write(402,1002)
 1002 format('!',8x,'alt(km)',2x,'T(K)',3x,'P(mbar)')
      
      do i=ND,1,-1
       xPmbar=XP(i)*1.e3
       write(402,1003)XALT(i),T(i),xPmbar
      enddo
 1003 format('Z,T,P',3x,F6.2,2x,F7.3,1x,E11.5)
          
      do i=1,NZ
c SR MacGregor properly calculating Z(i)
         z(i)=(i -1)*DZ*1.e-5 + 0.5*DZ*1.e-5
c       z(i) = i - 1. + 0.5    
      enddo
      j=53   !O2
      write(401,1005)IISPEC(j)
      write(401,1007)IISPEC(j),(XFO2,i=1,NZ)
      write(401,1009)IISPEC(j),(z(i),i=1,NZ)
      j=54   !CO2
      write(401,1005)IISPEC(j)
      write(401,1007)IISPEC(j),(XFCO2,i=1,NZ)
      write(401,1009)IISPEC(j),(z(i),i=1,NZ)

      do j=1,NQ    
      write(401,1005)IISPEC(j)
      write(401,1007)IISPEC(j),(XUSOL(j,i),i=1,NZ)
      write(401,1009)IISPEC(j),(z(i),i=1,NZ)
      enddo
      
 1005  format(/'Molecule ',A8)
 1007  format(/A8,'_MR',5(3x,E9.2),'  ^')
 1009  format(/A8,'_ALT',5(3x,F6.2),'  ^')
      close(401)
      close(402)  

      return
      end
**************************


