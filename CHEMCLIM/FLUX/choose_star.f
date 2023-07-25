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
      IF(STARR=="581")OPEN(UNIT=46,FILE=dirDATA//'/GJ581_surf.pdat')
      IF(STARR=="436")OPEN(UNIT=46,FILE=dirDATA//'/GJ436_surf.pdat')
      IF(STARR=="667")OPEN(UNIT=46,FILE=dirDATA//'/GJ667C_surf.pdat')
      IF(STARR=="832")OPEN(UNIT=46,FILE=dirDATA//'/GJ832_surf.pdat')
      IF(STARR=="ADL")OPEN(UNIT=46,
     & FILE= dirDATA//'/ADLeo_Sarah_surf.pdat')


      IF(STARR=="M0I")OPEN(UNIT=46,
     & FILE=dirDATA//'/Inactive_M0_Teff3800_5.0_surf.pdat')
      IF(STARR=="M1I")OPEN(UNIT=46,
     & FILE=dirDATA//'/Inactive_M1_Teff3600_5.0_surf.pdat')
      IF(STARR=="M2I")OPEN(UNIT=46,
     & FILE=dirDATA//'/Inactive_M2_Teff3400_5.0_surf.pdat')
      IF(STARR=="M3I")OPEN(UNIT=46,
     & FILE=dirDATA//'/Inactive_M3_Teff3200_5.0_surf.pdat')
      IF(STARR=="M4I")OPEN(UNIT=46,
     & FILE=dirDATA//'/Inactive_M4_Teff3100_5.0_surf.pdat')
      IF(STARR=="M5I")OPEN(UNIT=46,
     & FILE=dirDATA//'/Inactive_M5_Teff2800_5.0_surf.pdat')
      IF(STARR=="M6I")OPEN(UNIT=46,
     & FILE=dirDATA//'/Inactive_M6_Teff2600_5.0_surf.pdat')
      IF(STARR=="M7I")OPEN(UNIT=46,
     & FILE=dirDATA//'/Inactive_M7_Teff2500_5.0_surf.pdat')
      IF(STARR=="M8I")OPEN(UNIT=46,
     & FILE=dirDATA//'/Inactive_M8_Teff2400_5.0_surf.pdat')
      IF(STARR=="M9I")OPEN(UNIT=46,
     & FILE=dirDATA//'/Inactive_M9_Teff2300_5.0_surf.pdat')

      IF(STARR=="M0A")OPEN(UNIT=46,
     & FILE=dirDATA//'/Active_M0_Teff3800_surf.pdat')
      IF(STARR=="M1A")OPEN(UNIT=46,
     & FILE=dirDATA//'/Active_M1_Teff3600_surf.pdat')
      IF(STARR=="M2A")OPEN(UNIT=46,
     & FILE=dirDATA//'/Active_M2_Teff3400_surf.pdat')
      IF(STARR=="M3A")OPEN(UNIT=46,
     & FILE=dirDATA//'/Active_M3_Teff3200_surf.pdat')
      IF(STARR=="M4A")OPEN(UNIT=46,
     & FILE=dirDATA//'/Active_M4_Teff3100_surf.pdat')
      IF(STARR=="M5A")OPEN(UNIT=46,
     & FILE=dirDATA//'/Active_M5_Teff2800_surf.pdat')
      IF(STARR=="M6A")OPEN(UNIT=46,
     & FILE=dirDATA//'/Active_M6_Teff2600_surf.pdat')
      IF(STARR=="M7A")OPEN(UNIT=46,
     & FILE=dirDATA//'/Active_M7_Teff2500_surf.pdat')
      IF(STARR=="M8A")OPEN(UNIT=46,
     & FILE=dirDATA//'/Active_M8_Teff2400_surf.pdat')
      IF(STARR=="M9A")OPEN(UNIT=46,
     & FILE=dirDATA//'/Active_M9_Teff2300_surf.pdat')

      IF(STARR=="Ep0")OPEN(UNIT=46,FILE=dirDATA//'/Epoch0_surf.pdat')
      IF(STARR=="Ep1")OPEN(UNIT=46,FILE=dirDATA//'/Epoch1_surf.pdat')
      IF(STARR=="Ep2")OPEN(UNIT=46,FILE=dirDATA//'/Epoch2_surf.pdat')
      IF(STARR=="Ep3")OPEN(UNIT=46,FILE=dirDATA//'/Epoch3_surf.pdat')
      IF(STARR=="Ep4")OPEN(UNIT=46,FILE=dirDATA//'/Epoch4_surf.pdat')
      IF(STARR=="Ep5")OPEN(UNIT=46,FILE=dirDATA//'/Epoch5_surf.pdat')
      IF(STARR=="CMS")OPEN(UNIT=46,
     &     FILE=dirDATA//'/ClaireModernSun_surf.pdat')

      IF(STARR=="J25")OPEN(UNIT=46,
     & FILE=dirDATA//'/T2500ph_musc_surf.pdat')
      IF(STARR=="J07")OPEN(UNIT=46,
     & FILE=dirDATA//'/T700ph_musc_surf.pdat')

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

