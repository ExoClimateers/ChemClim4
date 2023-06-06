 
      SUBROUTINE READSTAR(FLUXFAC)

      CHARACTER :: STARR*3, dirDATA*16

      INCLUDE '../INCLUDECOUP/comSTR.inc'
      INCLUDE '../ATMCHEM/INCLUDECHEM/comFLUXPHOTO.inc'
      dirDATA = '../CHEMCLIM/DATA'

      select case(STARR)
       case('Sun')
        OPEN(unit=76, file= dirDATA//'/faruv_sun.pdat')
      case('dMV')
        OPEN(unit=76, file= dirDATA//'/faruv_ADLeo.pdat')
        OPEN(unit=75,file=dirDATA//'/ADLeo_photo.pdat')
      case('F2a')
        OPEN(unit=76, file= dirDATA//'/faruv_F2V.pdat')
        OPEN(unit=75,file=dirDATA//'/F2V_photo.pdat')
      case('K2a')
        OPEN(unit=76, file= dirDATA//'/faruv_K2V.pdat')
        OPEN(unit=75,file=dirDATA//'/K2V_photo.pdat')
      case('G2a')
        OPEN(unit=76, file= dirDATA//'/faruv_G2V.pdat')
        OPEN(unit=75,file=dirDATA//'/G2V_photo.pdat')
      case('F0V')
        OPEN(unit=76, file= dirDATA//'/faruv_Teff7000K.pdat')
        OPEN(unit=75,file=dirDATA//'/Teff7000K_photo.pdat')
      case('F2V')
        OPEN(unit=76, file= dirDATA//'/faruv_Teff6750K.pdat')
        OPEN(unit=75,file=dirDATA//'/Teff6750K_photo.pdat')
      case('F5V')
        OPEN(unit=76, file= dirDATA//'/faruv_Teff6500K.pdat')
        OPEN(unit=75,file=dirDATA//'/Teff6500K_photo.pdat')
      case('F7V')
        OPEN(unit=76, file= dirDATA//'/faruv_Teff6250K.pdat')
        OPEN(unit=75,file=dirDATA//'/Teff6250K_photo.pdat')
      case('F9V')
        OPEN(unit=76, file= dirDATA//'/faruv_Teff6000K.pdat')
        OPEN(unit=75,file=dirDATA//'/Teff6000K_photo.pdat')
      case('G2V')
        OPEN(unit=76, file= dirDATA//'/faruv_Teff5750K.pdat')
        OPEN(unit=75,file=dirDATA//'/Teff5750K_photo.pdat')
      case('G8V')
        OPEN(unit=76, file= dirDATA//'/faruv_Teff5500K.pdat')
        OPEN(unit=75,file=dirDATA//'/Teff5500K_photo.pdat')
      case('K0V')
        OPEN(unit=76, file= dirDATA//'/faruv_Teff5250K.pdat')
        OPEN(unit=75,file=dirDATA//'/Teff5250K_photo.pdat')
      case('K2V')
        OPEN(unit=76, file= dirDATA//'/faruv_Teff5000K.pdat')
        OPEN(unit=75,file=dirDATA//'/Teff5000K_photo.pdat')
      case('K4V')
        OPEN(unit=76, file= dirDATA//'/faruv_Teff4750K.pdat')
        OPEN(unit=75,file=dirDATA//'/Teff4750K_photo.pdat')
      case('K5V')
        OPEN(unit=76, file= dirDATA//'/faruv_Teff4500K.pdat')
        OPEN(unit=75,file=dirDATA//'/Teff4500K_photo.pdat')
      case('K7V')
        OPEN(unit=76, file= dirDATA//'/faruv_Teff4250K.pdat')
        OPEN(unit=75,file=dirDATA//'/Teff4250K_photo.pdat')
       case('121')
        OPEN(unit=76, file= dirDATA//'/faruv_GJ1214.pdat')
        OPEN(unit=75,file=dirDATA//'/GJ1214_photo.pdat')
       case('581')
        OPEN(unit=76, file= dirDATA//'/faruv_GJ581.pdat')
        OPEN(unit=75,file=dirDATA//'/GJ581_photo.pdat')
       case('436')
        OPEN(unit=76, file= dirDATA//'/faruv_GJ436.pdat')
        OPEN(unit=75,file=dirDATA//'/GJ436_photo.pdat')
       case('667')
        OPEN(unit=76, file= dirDATA//'/faruv_GJ667C.pdat')
        OPEN(unit=75,file=dirDATA//'/GJ667C_photo.pdat')
       case('832')
        OPEN(unit=76, file= dirDATA//'/faruv_GJ832.pdat')
        OPEN(unit=75,file=dirDATA//'/GJ832_photo.pdat')
       case('ADL')
        OPEN(unit=76, file= dirDATA//'/faruv_ADLeo_Sarah.pdat')
        OPEN(unit=75,file=dirDATA//'/ADLeo_Sarah_photo.pdat')

       case('M0I')
        OPEN(unit=76,
     &  file=dirDATA//'/faruv_Inactive_M0_Teff3800_5.0.pdat')
        OPEN(unit=75,
     &  file=dirDATA//'/Inactive_M0_Teff3800_5.0_photo.pdat')
       case('M1I')
        OPEN(unit=76,
     &  file=dirDATA//'/faruv_Inactive_M1_Teff3600_5.0.pdat')
        OPEN(unit=75,
     &  file=dirDATA//'/Inactive_M1_Teff3600_5.0_photo.pdat')
       case('M2I')
        OPEN(unit=76,
     &  file=dirDATA//'/faruv_Inactive_M2_Teff3400_5.0.pdat')
        OPEN(unit=75,
     &  file=dirDATA//'/Inactive_M2_Teff3400_5.0_photo.pdat')      
       case('M3I')
        OPEN(unit=76,
     &  file=dirDATA//'/faruv_Inactive_M3_Teff3200_5.0.pdat')
        OPEN(unit=75,
     &  file=dirDATA//'/Inactive_M3_Teff3200_5.0_photo.pdat')
       case('M4I')
        OPEN(unit=76,
     &  file=dirDATA//'/faruv_Inactive_M4_Teff3100_5.0.pdat')
        OPEN(unit=75,
     &  file=dirDATA//'/Inactive_M4_Teff3100_5.0_photo.pdat')
       case('M5I')
        OPEN(unit=76,
     &  file=dirDATA//'/faruv_Inactive_M5_Teff2800_5.0.pdat')
        OPEN(unit=75,
     &  file=dirDATA//'/Inactive_M5_Teff2800_5.0_photo.pdat')
       case('M6I')
        OPEN(unit=76,
     &  file=dirDATA//'/faruv_Inactive_M6_Teff2600_5.0.pdat')
        OPEN(unit=75,
     &  file=dirDATA//'/Inactive_M6_Teff2600_5.0_photo.pdat')
       case('M7I')
        OPEN(unit=76,
     &  file=dirDATA//'/faruv_Inactive_M7_Teff2500_5.0.pdat')
        OPEN(unit=75,
     &  file=dirDATA//'/Inactive_M7_Teff2500_5.0_photo.pdat')
       case('M8I')
        OPEN(unit=76,
     &  file=dirDATA//'/faruv_Inactive_M8_Teff2400_5.0.pdat')
        OPEN(unit=75,
     &  file=dirDATA//'/Inactive_M8_Teff2400_5.0_photo.pdat')
       case('M9I')
        OPEN(unit=76,
     &  file=dirDATA//'/faruv_Inactive_M9_Teff2300_5.0.pdat')
        OPEN(unit=75,
     &  file=dirDATA//'/Inactive_M9_Teff2300_5.0_photo.pdat')

       case('M0A')
        OPEN(unit=76,
     &  file=dirDATA//'/faruv_Active_M0_Teff3800.pdat')
        OPEN(unit=75,
     &  file=dirDATA//'/Active_M0_Teff3800_photo.pdat')
       case('M1A')
        OPEN(unit=76,
     &  file=dirDATA//'/faruv_Active_M1_Teff3600.pdat')
        OPEN(unit=75,
     &  file=dirDATA//'/Active_M1_Teff3600_photo.pdat')
       case('M2A')
        OPEN(unit=76,
     &  file=dirDATA//'/faruv_Active_M2_Teff3400.pdat')
        OPEN(unit=75,
     &  file=dirDATA//'/Active_M2_Teff3400_photo.pdat')      
       case('M3A')
        OPEN(unit=76,
     &  file=dirDATA//'/faruv_Active_M3_Teff3200.pdat')
        OPEN(unit=75,
     &  file=dirDATA//'/Active_M3_Teff3200_photo.pdat')
       case('M4A')
        OPEN(unit=76,
     &  file=dirDATA//'/faruv_Active_M4_Teff3100.pdat')
        OPEN(unit=75,
     &  file=dirDATA//'/Active_M4_Teff3100_photo.pdat')
       case('M5A')
        OPEN(unit=76,
     &  file=dirDATA//'/faruv_Active_M5_Teff2800.pdat')
        OPEN(unit=75,
     &  file=dirDATA//'/Active_M5_Teff2800_photo.pdat')
       case('M6A')
        OPEN(unit=76,
     &  file=dirDATA//'/faruv_Active_M6_Teff2600.pdat')
        OPEN(unit=75,
     &  file=dirDATA//'/Active_M6_Teff2600_photo.pdat')
       case('M7A')
        OPEN(unit=76,
     &  file=dirDATA//'/faruv_Active_M7_Teff2500.pdat')
        OPEN(unit=75,
     &  file=dirDATA//'/Active_M7_Teff2500_photo.pdat')
       case('M8A')
        OPEN(unit=76,
     &  file=dirDATA//'/faruv_Active_M8_Teff2400.pdat')
        OPEN(unit=75,
     &  file=dirDATA//'/Active_M8_Teff2400_photo.pdat')
       case('M9A')
        OPEN(unit=76,
     &  file=dirDATA//'/faruv_Active_M9_Teff2300.pdat')
        OPEN(unit=75,
     &  file=dirDATA//'/Active_M9_Teff2300_photo.pdat')



       case('Ep0')
        OPEN(unit=76, file= dirDATA//'/faruv_Epoch0.pdat')
        OPEN(unit=75,file=dirDATA//'/Epoch0_photo.pdat')
       case('Ep1')
        OPEN(unit=76, file= dirDATA//'/faruv_Epoch1.pdat')
        OPEN(unit=75,file=dirDATA//'/Epoch1_photo.pdat')
       case('Ep2')
        OPEN(unit=76, file= dirDATA//'/faruv_Epoch2.pdat')
        OPEN(unit=75,file=dirDATA//'/Epoch2_photo.pdat')
       case('Ep3')
        OPEN(unit=76, file= dirDATA//'/faruv_Epoch3.pdat')
        OPEN(unit=75,file=dirDATA//'/Epoch3_photo.pdat')
       case('Ep4')
        OPEN(unit=76, file= dirDATA//'/faruv_Epoch4.pdat')
        OPEN(unit=75,file=dirDATA//'/Epoch4_photo.pdat')
       case('Ep5')
        OPEN(unit=76, file= dirDATA//'/faruv_Epoch5.pdat')
        OPEN(unit=75,file=dirDATA//'/Epoch5_photo.pdat')
       case('CMS')
        OPEN(unit=76, file= dirDATA//'/faruv_ClaireModernSun.pdat')
        OPEN(unit=75,file=dirDATA//'/ClaireModernSun_photo.pdat')
      end select

c Reading far UV data
        READ(76,100)
        do L=1,10
          read(76,*)X,SFX(L)
          SFX(L)=SFX(L)*FLUXFAC
        end do
      close(76) 
 100  FORMAT(/)        
  
****** Read UV flux data from stars other than the Sun
* The Sun UV flux is read in the subroutine READPHOTO
       if(STARR.eq.'Sun') RETURN
        read(75,*)
        do l=1,108
          read(75,*)ll,FLUX(l),x,x
          FLUX(ll) = FLUX(ll)*FLUXFAC
        enddo
      close(75)
      
      RETURN
      END

