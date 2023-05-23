      SUBROUTINE CHOOSE_STAR(FLUXFAC,FLUXC,FLUXUVC)

c This subroutine reads the spectra from stars other than the SUN

      INCLUDE '../CLIMA/INCLUDECLIM/parNSOL_NSOLUV.inc'
      DIMENSION FLUXC(NSOL),FLUXUVC(NSOLUV)
      CHARACTER :: STARR*3,dirDATA*16
      INCLUDE '../INCLUDECOUP/comSTR.inc'
      
      dirDATA = '../CHEMCLIM/DATA'       
      
      if(STARR.eq.'Sun') goto 1
      IF(STARR=="dMV")OPEN(UNIT=46,FILE= dirDATA//'/ADLeo_surf.pdat')
      IF(STARR=="F2a")OPEN(UNIT=46,FILE= dirDATA//'/F2V_surf.pdat')
      IF(STARR=="K2a")OPEN(UNIT=46,FILE= dirDATA//'/K2V_surf.pdat')
      IF(STARR=="G2a")OPEN(UNIT=46,FILE=dirDATA//'/G2V_surf.pdat')
      IF(STARR=="F0V")OPEN(UNIT=46,FILE=dirDATA//'/Teff7000K_surf.pdat')
      IF(STARR=="F2V")OPEN(UNIT=46,FILE=dirDATA//'/Teff6750K_surf.pdat')
      IF(STARR=="F5V")OPEN(UNIT=46,FILE=dirDATA//'/Teff6500K_surf.pdat')
      IF(STARR=="F7V")OPEN(UNIT=46,FILE=dirDATA//'/Teff6250K_surf.pdat')
      IF(STARR=="F9V")OPEN(UNIT=46,FILE=dirDATA//'/Teff6000K_surf.pdat')
      IF(STARR=="G2V")OPEN(UNIT=46,FILE=dirDATA//'/Teff5750K_surf.pdat')
      IF(STARR=="G8V")OPEN(UNIT=46,FILE=dirDATA//'/Teff5500K_surf.pdat')
      IF(STARR=="K0V")OPEN(UNIT=46,FILE=dirDATA//'/Teff5250K_surf.pdat')
      IF(STARR=="K2V")OPEN(UNIT=46,FILE=dirDATA//'/Teff5000K_surf.pdat')
      IF(STARR=="K4V")OPEN(UNIT=46,FILE=dirDATA//'/Teff4750K_surf.pdat')
      IF(STARR=="K5V")OPEN(UNIT=46,FILE=dirDATA//'/Teff4500K_surf.pdat')
      IF(STARR=="K7V")OPEN(UNIT=46,FILE=dirDATA//'/Teff4250K_surf.pdat')
      IF(STARR=="121")OPEN(UNIT=46,FILE=dirDATA//'/GJ1214_surf.pdat')
      IF(STARR=="581")OPEN(UNIT=46,FILE=dirDATA//'/GL581_surf.pdat')
      IF(STARR=="436")OPEN(UNIT=46,FILE=dirDATA//'/GJ436_surf.pdat')
      IF(STARR=="667")OPEN(UNIT=46,FILE=dirDATA//'/GJ667c_surf.pdat')
      IF(STARR=="832")OPEN(UNIT=46,FILE=dirDATA//'/GJ832_surf.pdat')


       READ(46,*)
       DO j=1,NSOLUV
         READ(46,*)xl,xf,x,x
         FLUXUVC(j) = xf*FLUXFAC
       ENDDO
       READ(46,*)
       DO j=1,NSOL
         READ(46,*)xl,xf,x,x
         FLUXC(j) = xf*FLUXFAC
       ENDDO
       close(46)
C

 1    continue
      RETURN
      END
