 
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
        OPEN(unit=76, file= dirDATA//'/faruv_GL581.pdat')
        OPEN(unit=75,file=dirDATA//'/GL581_photo.pdat')
       case('436')
        OPEN(unit=76, file= dirDATA//'/faruv_GJ436.pdat')
        OPEN(unit=75,file=dirDATA//'/GJ436_photo.pdat')
       case('667')
        OPEN(unit=76, file= dirDATA//'/faruv_GJ667c.pdat')
        OPEN(unit=75,file=dirDATA//'/GJ667c_photo.pdat')
       case('832')
        OPEN(unit=76, file= dirDATA//'/faruv_GJ832.pdat')
        OPEN(unit=75,file=dirDATA//'/GJ832_photo.pdat')



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

