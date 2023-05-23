      SUBROUTINE CHOOSE_STAR(FLUXFAC,FLUXC,FLUXUVC)

c This subroutine reads the spectra from stars other than the SUN

      INCLUDE '../CLIMA/INCLUDECLIM/parNSOL_NSOLUV.inc'
      DIMENSION FLUXC(NSOL),FLUXUVC(NSOLUV)
      CHARACTER :: STARR*3,dirDATA*16
      INCLUDE '../INCLUDECOUP/comSTR.inc'
      
      dirDATA = '../CHEMCLIM/DATA'       
      
      if(STARR.eq.'Sun') goto 1
      IF(STARR=="dMV")OPEN(UNIT=46,FILE= dirDATA//'/M_surf.pdat')
      IF(STARR=="F2V")OPEN(UNIT=46,FILE= dirDATA//'/F2V_surf.pdat')
      IF(STARR=="K2V")OPEN(UNIT=46,FILE= dirDATA//'/K2V_surf.pdat')

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

