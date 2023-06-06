       PROGRAM SPECTRA_PHOTO
c This program reads the star flux at the distance of the star,
c scales it to the distance of an habitable planet aroun the star, 
c and bins the flux to be used by the photochemical flux

C IMPORTANT
C This program has been modified to produce a spectrum with a given slope
c (xm) from 1000 to 3550 A 
C 

c   NF is the number of rows that will be read in the flux data file
c   nskip is the number of lines to skip in the flux data file
      parameter(NF=1276, nskip=2, nL=108, nl2=10)
      dimension iXL(nl2),XLf(nl2),xla(NF),fluxerg(NF),
     & fluxsum(nl2),fluxphot(nl2)
      dimension wavl(NL),wavu(NL),wav(NL),fluxw(NL)
      dimension flx(NL),xlam(NF), flxf(NF)

      data XLf/1750.,1700.,1650.,1600.,1550.,1500.,1450.,1400.,
     &        1350.,1300./
      data iXL/1725,1675,1625,1575,1525,1475,1425,1375,1325,1216/

      data WAVL/1754.,1770.,1786.,1802.,1818.,1835.,1852.,1869.,
     & 1887.,1905.,1923.,1942.,1961.,1980.,2000.,2020.,2041.,2062.,
     & 2083.,2105.,2128.,2151.,2174.,2200.,2222.,2247.,2273.,2299.,
     & 2326.,2353.,2381.,2410.,2439.,2469.,2500.,2532.,2564.,2597.,
     & 2632.,2667.,2703.,2740.,2778.,2817.,2857.,2899.,2941.,2985.,
     & 3030.,3077.,3125.,3175.,3225.,3275.,3325.,3375.,3425.,3450.,
     & 3550.,3650.,3750.,3850.,3950.,4050.,4150.,4250.,4350.,4450.,
     & 4550.,4650.,4750.,4850.,4950.,5050.,5150.,5250.,5350.,5450.,
     & 5550.,5650.,5750.,5850.,5950.,6050.,6150.,6250.,6350.,6450.,
     & 6550.,6650.,6750.,6850.,6950.,7050.,7150.,7250.,7350.,7450.,
     & 7550.,7650.,7750.,7850.,7950.,8050.,8150.,8250.,8350.,8450./

      data WAVU/1770.,1786.,1802.,1818.,1835.,1852.,1869.,1887.,
     & 1905.,1923.,1942.,1961.,1980.,2000.,2020.,2041.,2062.,2083.,
     & 2105.,2128.,2151.,2174.,2200.,2222.,2247.,2273.,2299.,2326.,
     & 2353.,2381.,2410.,2439.,2469.,2500.,2532.,2564.,2597.,2632.,
     & 2667.,2703.,2740.,2778.,2817.,2857.,2899.,2941.,2985.,3030.,
     & 3077.,3125.,3175.,3225.,3275.,3325.,3375.,3425.,3450.,3550.,
     & 3650.,3750.,3850.,3950.,4050.,4150.,4250.,4350.,4450.,4550.,
     & 4650.,4750.,4850.,4950.,5050.,5150.,5250.,5350.,5450.,5550.,
     & 5650.,5750.,5850.,5950.,6050.,6150.,6250.,6350.,6450.,6550.,
     & 6650.,6750.,6850.,6950.,7050.,7150.,7250.,7350.,7450.,7550.,
     & 7650.,7750.,7850.,7950.,8050.,8150.,8250.,8350.,8450.,8550./

C  Open the necessary datafiles
      open(unit=1, file='photos.pdat', status='old')
      open(unit=2, file='Sunflare.pdat', status='unknown')
      open(unit=3, file='Sunflare_photo.pdat', status='unknown')
c File with the far uv for the photochemical model
      open(unit=4, file='faruv_sunflare.pdat') 
    
c Writing the headers on the output files
c NOTE: Change the headers according to the star
      write(2,202)
 202  format(1x,'Sun plus flare FLUX scaled at the distance the planet')
      write(3,401)
 401  format(3x,'L',6x,'Sun plus flare')
      write(4,101)
 101  format(3x,'L',5x,'SFX(L)'/)

c Afac as defined by Kasting et al 1993 (Icarus 101,108)
c NOTE: It should be changed according to the surface temperature of the star
c Data for sigam Bootis (F2V star) Afac=1.11 pc
c Data for epsilon Eridani (K2V star) Afac=0.95
c Data for AD Leo (M star) Afac=0.90
       Afac = 1
c Lyman alpha flux at the planet
c Data for sigma Bootis (F2V star) xLy=29.64 (Landsman & Simon, ApJ 1993)
c Data for epsilon Eridani (K2V star) xLy=159.13 (Landsman & Simon, ApJ 1993)
c  Lyman alpha for AD Leo provided for Brian E. Wood 
c  (University of Colorado, Denver) xLy = 3.9e2 
       xLy = 5.e11    !photons/cm^2/s
C Constants in cgs
      h = 6.625e-27
      c= 3.e10

C Creating the flare flux using as a pinpoint 3550 A
       xm=-1.
        b= 97.- (xm*3550.)
      do j=1,NF
       xlam(j) = 1000.+ ((j-1) *2.)
       flxf(j) = xm*xlam(j) + b
      enddo
C   Read  the rest of the star flux data 
c Fluxes already in photons/cm"/s
      do j=1,nskiP
        read(1,*)
      enddo
      do i=1,NL
        read(1,*)x,x,x,flx(i)
      end do

c Calculating the integrated flux (erg/cm^2/s) for the flare
      sum_flux = 0.0
      do i=1,NF-1
         sum_flux = sum_flux + (flxf(i)*(xlam(i+1)-xlam(i)))
      end do

c  Writing the file with the scaled stellar flux
        write(2,204) sum_flux
 204  FORMAT(1x,'Flare flux = ',1pe10.3,' erg/s/cm2'/)
       write(2,205)
 205  format(5x,'A',7x,'erg/s/cm^2/A')
        do i=1,NF
          write(2,201) xlam(i),flxf(i)
        end do
 201  FORMAT(f9.0,2x,e12.6)

c   Now bin the star flux data into a form usable by the photochemical model
      is1 = 1 
      do 6 l=1, 58
      dwav = wavu(l) - wavl(l)
      do 7 i=is1,NF
      if (xlam(i) .lt. wavl(l)) go to 7
      is1 = i
      go to 8
 7    continue
c
 8    do 9 i=is1,NF
      if (xlam(i) .lt. wavu(l)) go to 9
      is2 = i-1
      go to 10
 9    continue

C   alam(is1) and alam(is2) are both within interval l
 10   continue
      datnum = is2 - is1 + 1
      fluxw(l) = 0.

      do 12 i=is1,is2
 12     fluxw(l) = fluxw(l) + flxf(i)
      if(datnum.eq.0.) goto 6
      fluxw(l) = (fluxw(l)/datnum)*dwav
 6    continue

c Writing the file to be used by the photochemical model
c (near UV and visible)
      do i=1,58
C  Convert from ergs to photons
        ephot = 1.e8 * h*c/((wavl(i)+wavu(i))*0.5)
        fluxw(i) = fluxw(i)/ephot
        write(3,403) i,fluxw(i),wavl(i),wavu(i)
      end do
      do i=59,NL
       write(3,403) i,flx(i),wavl(i),wavu(i)
      end do
 403  format(1x,i3,2x,e11.4,2x,2f6.0)

c Using the scaled spectra to generate the far UV data
c for the photochemical model
      do j=1,NF
       xla(j) = xlam(j)
       fluxerg(j) = flxf(j)
      enddo

c Bin the far UV stellar data to  be used by the photochemical
c model
      is1 = 1
      dwav=50.             
      do 13 l=nl2,2,-1
      do 14 i=is1,NF
      if (xla(i) .le. xlf(l)) go to 14
      is1 = i
      go to 15
 14    continue
c
 15    do 16 i=is1,NF
      if (xla(i) .le. xlf(l-1)) go to 16
      is2 = i-1
      go to 17
 16    continue

 17   datnum = is2 - is1 + 1
      fluxsum(l) = 0.
 
      do 18 i=is1,is2
 18   fluxsum(l) = fluxsum(l) + fluxerg(i)
      if(datnum.eq.0) goto 13
      fluxphot(l-1) = fluxsum(l)/datnum      
 13   continue                    !end of main loop
    
      fluxsum(nl2)= xLy           !erg/cm^2/s
      fluxphot(nl2) = fluxsum(nl2)/dwav     
 
      do i=1,nl2
C  Convert from ergs/cm^2/s/A to photons/cm^2/s/A
        if(i.eq.nl2) then
          ephot = 1.
          go to 19
        endif
        ephot = 1.e8 * h*c/((xlf(i)+xlf(i+1))*0.5)
 19     fluxphot(i) = fluxphot(i)/ephot
c Writing the file with the far uv data
        write(4,102) iXL(i),fluxphot(i) 
      end do 
      write(4,103)
 102  format(1x,I4,2x,1pe8.1)
 103  format(/'Far UV flux in photons/s^2/cm/A'/
     & 'The flux at Ly alpha is divided by 50')

      print*,"Done."

      STOP
      END
