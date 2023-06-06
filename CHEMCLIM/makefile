# make file for coupled run

###############################
# Set variables
###############################
FC = ifort
#PLATFORM = linux
FCFLAG = -c -r8 -i8 #-debug #-g -pg -CB
FFLAG1 = -r8 -i8 #-debug #-g -pg -CB

OUTPUT = couple
CDIRPH = ATMCHEM/
CDIRCL = CLIMA/
CDOTO  = ATMCHEM.o
CDOTOC = CLIMA.o
CDOTOR = RRTM.o
CDOTCOU = COUPLE.o
# Main files
COUPLED = couple
CSUR = clima
CCHEM = atm_chem

# Subroutines for coupling
CPATH0 = COUPLE
COUTP = output_photo
CINPI = input_interp

# Subdirectories and subroutines for the CLIMATE model
CPATHR = RRTM
CRTM = rrtm
CREG = rtreg
CRTR = rtr
CATM = rrtatm
CSET = setcoef
CTAU = taumol
CRGC = rtregcld
CRTC = rtrcld
CEXT = extra
CRTX = rtrcldmr
CRGX = rtregcldmr
CKGS = k_g
CCLD = cldprop
#CUTL = util_$(PLATFORM)
CTRNT = translatem

# These are the climate code files
CPATH1 = SETUP
CPROF = cprofile
CREAD = readsol
CGRID = cgrid
CIRES = irexpsums
CINTP = interp
CINOZ = interpozone
COZON = ozone

CPATH2 = CONVEC
CCONV = convec
CSATH = satrat
CRELH = relhum
CSATC = satco2

CPATH3 = RADTRANS
CSOL  = solar
CINFR = ir
CRAYL = rayley
CDSTI = delta2strir
CDSTS = delta2str
CMTRX = tridag
CPLAN = planck

CPATH4 = PRTCL
CGRDA = gridaer
CADAT = aerabsdata
CINPA = interpar1

# Subdirectories  and subroutines from the PHOTOCHEMICAL model
PPATH1 = SETUP
PCGRID = grid
PCRATE = rates
PCRPHT = readphoto
PCDENS = densty
PCDFCO = difco
PCSATR = psatrat
CGASC = gascon

PPATH2 = CHEM
PCTBDY = tbdy
PCPHOT = photo
PCO3PH = o3phot
PCDOCH = dochem
PCCHPL = chempl
PCLTNG = ltning
PCTSTR = twostr

PPATH3 = PRTCL
PCSDMT = sedmnt
PCAERT = aertab
PCAERC = aercon

PPATH4 = MATRIX
PSGBSL = sgbsl
PSGBFA = sgbfa
PSGTSL = sgtsl
PSAXPY = saxpy
PSSCAL = sscal

# Subdirectories  and subroutines from the time dependent coupling
PATH1 = FLUX
CSTAR = choose_star
PCRSTR = readstar

OBPATH = $(CDOTCOU)/$(COUPLED).o \
         $(CDOTCOU)/$(COUTP).o \
         $(CDOTCOU)/$(CINPI).o \
         $(CDIRPH)$(CDOTO)/$(CCHEM).o \
	 $(CDIRPH)$(CDOTO)/$(PCGRID).o \
	 $(CDIRPH)$(CDOTO)/$(PCRATE).o \
	 $(CDIRPH)$(CDOTO)/$(PCRPHT).o \
	 $(CDIRPH)$(CDOTO)/$(PCRSTR).o \
	 $(CDIRPH)$(CDOTO)/$(PCTBDY).o \
	 $(CDIRPH)$(CDOTO)/$(PCPHOT).o \
	 $(CDIRPH)$(CDOTO)/$(PCO3PH).o \
	 $(CDIRPH)$(CDOTO)/$(PCDENS).o \
	 $(CDIRPH)$(CDOTO)/$(PCDFCO).o \
	 $(CDIRPH)$(CDOTO)/$(PCSDMT).o \
	 $(CDIRPH)$(CDOTO)/$(PCSATR).o \
	 $(CDIRPH)$(CDOTO)/$(PCAERT).o \
	 $(CDIRPH)$(CDOTO)/$(PCAERC).o \
	 $(CDIRPH)$(CDOTO)/$(PCDOCH).o \
	 $(CDIRPH)$(CDOTO)/$(PCCHPL).o \
	 $(CDIRPH)$(CDOTO)/$(PCLTNG).o \
	 $(CDIRPH)$(CDOTO)/$(PCTSTR).o \
         $(CDIRPH)$(CDOTO)/$(PSGTSL).o \
         $(CDIRPH)$(CDOTO)/$(PSGBSL).o \
         $(CDIRPH)$(CDOTO)/$(PSGBFA).o \
         $(CDIRPH)$(CDOTO)/$(PSAXPY).o \
         $(CDIRPH)$(CDOTO)/$(PSSCAL).o \
         $(CDIRCL)$(CDOTOC)/$(CSUR).o \
	 $(CDIRCL)$(CDOTOR)/$(CRTM).o \
	 $(CDIRCL)$(CDOTOR)/$(CREG).o \
	 $(CDIRCL)$(CDOTOR)/$(CRTR).o \
	 $(CDIRCL)$(CDOTOR)/$(CATM).o \
	 $(CDIRCL)$(CDOTOR)/$(CSET).o \
	 $(CDIRCL)$(CDOTOR)/$(CTAU).o \
	 $(CDIRCL)$(CDOTOR)/$(CRGC).o \
	 $(CDIRCL)$(CDOTOR)/$(CRTC).o \
	 $(CDIRCL)$(CDOTOR)/$(CEXT).o \
	 $(CDIRCL)$(CDOTOR)/$(CRTX).o \
	 $(CDIRCL)$(CDOTOR)/$(CRGX).o \
	 $(CDIRCL)$(CDOTOR)/$(CCLD).o \
	 $(CDIRCL)$(CDOTOR)/$(CKGS).o \
         $(CDIRCL)$(CDOTOR)/$(CTRNT).o \
	 $(CDIRCL)$(CDOTOC)/$(CPROF).o \
	 $(CDIRCL)$(CDOTOC)/$(CREAD).o \
	 $(CDIRCL)$(CDOTOC)/$(CSTAR).o \
	 $(CDIRCL)$(CDOTOC)/$(CGRID).o \
	 $(CDIRCL)$(CDOTOC)/$(CIRES).o \
	 $(CDIRCL)$(CDOTOC)/$(CINTP).o \
	 $(CDIRCL)$(CDOTOC)/$(CINOZ).o \
	 $(CDIRCL)$(CDOTOC)/$(COZON).o \
	 $(CDIRCL)$(CDOTOC)/$(CCONV).o \
	 $(CDIRCL)$(CDOTOC)/$(CSATH).o \
	 $(CDIRCL)$(CDOTOC)/$(CRELH).o \
 	 $(CDIRCL)$(CDOTOC)/$(CSATC).o \
	 $(CDIRCL)$(CDOTOC)/$(CGASC).o \
	 $(CDIRCL)$(CDOTOC)/$(CSOL).o  \
	 $(CDIRCL)$(CDOTOC)/$(CINFR).o \
	 $(CDIRCL)$(CDOTOC)/$(CRAYL).o \
	 $(CDIRCL)$(CDOTOC)/$(CDSTI).o \
	 $(CDIRCL)$(CDOTOC)/$(CDSTS).o \
	 $(CDIRCL)$(CDOTOC)/$(CMTRX).o \
	 $(CDIRCL)$(CDOTOC)/$(CPLAN).o \
	 $(CDIRCL)$(CDOTOC)/$(CGRDA).o \
	 $(CDIRCL)$(CDOTOC)/$(CADAT).o \
	 $(CDIRCL)$(CDOTOC)/$(CINPA).o 
###############################
# Load line
###############################

$(OUTPUT) : $(OBPATH) 
	$(FC) $(FFLAG1) -o $(OUTPUT) $(OBPATH)

###############################
# Object compile lines
###############################

$(CDOTCOU)/$(COUPLED).o : $(COUPLED).f
	$(FC) $(FCFLAG) $(COUPLED).f
	\mv $(COUPLED).o $(CDOTCOU)

### Compiling programs for coupling

$(CDOTCOU)/$(COUTP).o : $(CPATH0)/$(COUTP).f
	$(FC) $(FCFLAG) $(CPATH0)/$(COUTP).f
	\mv $(COUTP).o $(CDOTCOU)

$(CDOTCOU)/$(CINPI).o : $(CPATH0)/$(CINPI).f
	$(FC) $(FCFLAG) $(CPATH0)/$(CINPI).f
	\mv $(CINPI).o $(CDOTCOU)

### COMPILING THE PHOTOCHEMICAL CODE

$(CDIRPH)$(CDOTO)/$(CCHEM).o : $(CDIRPH)$(CCHEM).f
	$(FC) $(FCFLAG)  $(CDIRPH)$(CCHEM).f
	\mv $(CCHEM).o $(CDIRPH)$(CDOTO)

$(CDIRPH)$(CDOTO)/$(PCGRID).o : $(CDIRPH)$(PPATH1)/$(PCGRID).f
	$(FC) $(FCFLAG) $(CDIRPH)$(PPATH1)/$(PCGRID).f
	\mv $(PCGRID).o $(CDIRPH)$(CDOTO)

$(CDIRPH)$(CDOTO)/$(PCRATE).o : $(CDIRPH)$(PPATH1)/$(PCRATE).f
	$(FC) $(FCFLAG) $(CDIRPH)$(PPATH1)/$(PCRATE).f
	\mv $(PCRATE).o $(CDIRPH)$(CDOTO)

$(CDIRPH)$(CDOTO)/$(PCRPHT).o : $(CDIRPH)$(PPATH1)/$(PCRPHT).f
	$(FC) $(FCFLAG) $(CDIRPH)$(PPATH1)/$(PCRPHT).f
	\mv $(PCRPHT).o $(CDIRPH)$(CDOTO)

$(CDIRPH)$(CDOTO)/$(PCRSTR).o : $(PATH1)/$(PCRSTR).f
	$(FC) $(FCFLAG) $(PATH1)/$(PCRSTR).f
	\mv $(PCRSTR).o $(CDIRPH)$(CDOTO)

$(CDIRPH)$(CDOTO)/$(PCDFCO).o : $(CDIRPH)$(PPATH1)/$(PCDFCO).f
	$(FC) $(FCFLAG) $(CDIRPH)$(PPATH1)/$(PCDFCO).f
	\mv $(PCDFCO).o $(CDIRPH)$(CDOTO)

$(CDIRPH)$(CDOTO)/$(PCDENS).o : $(CDIRPH)$(PPATH1)/$(PCDENS).f
	$(FC) $(FCFLAG) $(CDIRPH)$(PPATH1)/$(PCDENS).f
	\mv $(PCDENS).o $(CDIRPH)$(CDOTO)

$(CDIRPH)$(CDOTO)/$(PCSATR).o : $(CDIRPH)$(PPATH1)/$(PCSATR).f
	$(FC) $(FCFLAG) $(CDIRPH)$(PPATH1)/$(PCSATR).f
	\mv $(PCSATR).o $(CDIRPH)$(CDOTO)

$(CDIRPH)$(CDOTO)/$(PCTBDY).o : $(CDIRPH)$(PPATH2)/$(PCTBDY).f
	$(FC) $(FCFLAG) $(CDIRPH)$(PPATH2)/$(PCTBDY).f
	\mv $(PCTBDY).o $(CDIRPH)$(CDOTO)

$(CDIRPH)$(CDOTO)/$(PCPHOT).o :$(CDIRPH)$(PPATH2)/$(PCPHOT).f
	$(FC) $(FCFLAG) $(CDIRPH)$(PPATH2)/$(PCPHOT).f
	\mv $(PCPHOT).o $(CDIRPH)$(CDOTO)

$(CDIRPH)$(CDOTO)/$(PCO3PH).o : $(CDIRPH)$(PPATH2)/$(PCO3PH).f
	$(FC) $(FCFLAG) $(CDIRPH)$(PPATH2)/$(PCO3PH).f
	\mv $(PCO3PH).o $(CDIRPH)$(CDOTO)

$(CDIRPH)$(CDOTO)/$(PCDOCH).o : $(CDIRPH)$(PPATH2)/$(PCDOCH).f
	$(FC) $(FCFLAG) $(CDIRPH)$(PPATH2)/$(PCDOCH).f
	\mv $(PCDOCH).o $(CDIRPH)$(CDOTO)

$(CDIRPH)$(CDOTO)/$(PCCHPL).o :$(CDIRPH)$(PPATH2)/$(PCCHPL).f
	$(FC) $(FCFLAG) $(CDIRPH)$(PPATH2)/$(PCCHPL).f
	\mv $(PCCHPL).o $(CDIRPH)$(CDOTO)

$(CDIRPH)$(CDOTO)/$(PCLTNG).o : $(CDIRPH)$(PPATH2)/$(PCLTNG).f
	$(FC) $(FCFLAG) $(CDIRPH)$(PPATH2)/$(PCLTNG).f
	\mv $(PCLTNG).o $(CDIRPH)$(CDOTO)

$(CDIRPH)$(CDOTO)/$(PCTSTR).o : $(CDIRPH)$(PPATH2)/$(PCTSTR).f
	$(FC) $(FCFLAG) $(CDIRPH)$(PPATH2)/$(PCTSTR).f
	\mv $(PCTSTR).o $(CDIRPH)$(CDOTO)

$(CDIRPH)$(CDOTO)/$(PCSDMT).o : $(CDIRPH)$(PPATH3)/$(PCSDMT).f
	$(FC) $(FCFLAG) $(CDIRPH)$(PPATH3)/$(PCSDMT).f
	\mv $(PCSDMT).o $(CDIRPH)$(CDOTO)

$(CDIRPH)$(CDOTO)/$(PCAERT).o : $(CDIRPH)$(PPATH3)/$(PCAERT).f
	$(FC) $(FCFLAG) $(CDIRPH)$(PPATH3)/$(PCAERT).f
	\mv $(PCAERT).o $(CDIRPH)$(CDOTO)

$(CDIRPH)$(CDOTO)/$(PCAERC).o : $(CDIRPH)$(PPATH3)/$(PCAERC).f
	$(FC) $(FCFLAG) $(CDIRPH)$(PPATH3)/$(PCAERC).f
	\mv $(PCAERC).o $(CDIRPH)$(CDOTO)

$(CDIRPH)$(CDOTO)/$(PSGTSL).o : $(CDIRPH)$(PPATH4)/$(PSGTSL).f
	$(FC) $(FCFLAG) $(CDIRPH)$(PPATH4)/$(PSGTSL).f
	\mv $(PSGTSL).o $(CDIRPH)$(CDOTO)

$(CDIRPH)$(CDOTO)/$(PSGBSL).o : $(CDIRPH)$(PPATH4)/$(PSGBSL).f
	$(FC) $(FCFLAG) $(CDIRPH)$(PPATH4)/$(PSGBSL).f
	\mv $(PSGBSL).o $(CDIRPH)$(CDOTO)

$(CDIRPH)$(CDOTO)/$(PSGBFA).o : $(CDIRPH)$(PPATH4)/$(PSGBFA).f
	$(FC) $(FCFLAG) $(CDIRPH)$(PPATH4)/$(PSGBFA).f
	\mv $(PSGBFA).o $(CDIRPH)$(CDOTO)

$(CDIRPH)$(CDOTO)/$(PSAXPY).o : $(CDIRPH)$(PPATH4)/$(PSAXPY).f
	$(FC) $(FCFLAG) $(CDIRPH)$(PPATH4)/$(PSAXPY).f
	\mv $(PSAXPY).o $(CDIRPH)$(CDOTO)

$(CDIRPH)$(CDOTO)/$(PSSCAL).o : $(CDIRPH)$(PPATH4)/$(PSSCAL).f
	$(FC) $(FCFLAG) $(CDIRPH)$(PPATH4)/$(PSSCAL).f
	\mv $(PSSCAL).o $(CDIRPH)$(CDOTO)


## COMPILING THE CLIMATE CODE

$(CDIRCL)$(CDOTOC)/$(CSUR).o : $(CDIRCL)$(CSUR).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CSUR).f
	\mv $(CSUR).o $(CDIRCL)$(CDOTOC)

$(CDIRCL)$(CDOTOC)/$(CPROF).o : $(CDIRCL)$(CPATH1)/$(CPROF).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATH1)/$(CPROF).f
	\mv $(CPROF).o $(CDIRCL)$(CDOTOC)

$(CDIRCL)$(CDOTOC)/$(CREAD).o : $(CDIRCL)$(CPATH1)/$(CREAD).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATH1)/$(CREAD).f
	\mv $(CREAD).o $(CDIRCL)$(CDOTOC)

$(CDIRCL)$(CDOTOC)/$(CSTAR).o : $(PATH1)/$(CSTAR).f
	$(FC) $(FCFLAG) $(PATH1)/$(CSTAR).f
	\mv $(CSTAR).o $(CDIRCL)$(CDOTOC)

$(CDIRCL)$(CDOTOC)/$(CGRID).o : $(CDIRCL)$(CPATH1)/$(CGRID).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATH1)/$(CGRID).f
	\mv $(CGRID).o $(CDIRCL)$(CDOTOC)

$(CDIRCL)$(CDOTOC)/$(CIRES).o : $(CDIRCL)$(CPATH1)/$(CIRES).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATH1)/$(CIRES).f
	\mv $(CIRES).o $(CDIRCL)$(CDOTOC)

$(CDIRCL)$(CDOTOC)/$(CINTP).o : $(CDIRCL)$(CPATH1)/$(CINTP).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATH1)/$(CINTP).f
	\mv $(CINTP).o $(CDIRCL)$(CDOTOC)

$(CDIRCL)$(CDOTOC)/$(CINOZ).o : $(CDIRCL)$(CPATH1)/$(CINOZ).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATH1)/$(CINOZ).f
	\mv $(CINOZ).o $(CDIRCL)$(CDOTOC)

$(CDIRCL)$(CDOTOC)/$(COZON).o : $(CDIRCL)$(CPATH1)/$(COZON).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATH1)/$(COZON).f
	\mv $(COZON).o $(CDIRCL)$(CDOTOC)

$(CDIRCL)$(CDOTOC)/$(CGASC).o : $(CDIRCL)$(CPATH1)/$(CGASC).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATH1)/$(CGASC).f
	\mv $(CGASC).o $(CDIRCL)$(CDOTOC)

$(CDIRCL)$(CDOTOC)/$(CCONV).o : $(CDIRCL)$(CPATH2)/$(CCONV).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATH2)/$(CCONV).f
	\mv $(CCONV).o $(CDIRCL)$(CDOTOC)

$(CDIRCL)$(CDOTOC)/$(CSATH).o : $(CDIRCL)$(CPATH2)/$(CSATH).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATH2)/$(CSATH).f
	\mv $(CSATH).o $(CDIRCL)$(CDOTOC)

$(CDIRCL)$(CDOTOC)/$(CRELH).o : $(CDIRCL)$(CPATH2)/$(CRELH).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATH2)/$(CRELH).f
	\mv $(CRELH).o $(CDIRCL)$(CDOTOC)

$(CDIRCL)$(CDOTOC)/$(CSATC).o : $(CDIRCL)$(CPATH2)/$(CSATC).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATH2)/$(CSATC).f
	\mv $(CSATC).o $(CDIRCL)$(CDOTOC)

$(CDIRCL)$(CDOTOC)/$(CSOL).o : $(CDIRCL)$(CPATH3)/$(CSOL).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATH3)/$(CSOL).f
	\mv $(CSOL).o $(CDIRCL)$(CDOTOC)

$(CDIRCL)$(CDOTOC)/$(CINFR).o : $(CDIRCL)$(CPATH3)/$(CINFR).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATH3)/$(CINFR).f
	\mv $(CINFR).o $(CDIRCL)$(CDOTOC)

$(CDIRCL)$(CDOTOC)/$(CRAYL).o : $(CDIRCL)$(CPATH3)/$(CRAYL).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATH3)/$(CRAYL).f
	\mv $(CRAYL).o $(CDIRCL)$(CDOTOC)

$(CDIRCL)$(CDOTOC)/$(CDSTI).o : $(CDIRCL)$(CPATH3)/$(CDSTI).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATH3)/$(CDSTI).f
	\mv $(CDSTI).o $(CDIRCL)$(CDOTOC)

$(CDIRCL)$(CDOTOC)/$(CDSTS).o : $(CDIRCL)$(CPATH3)/$(CDSTS).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATH3)/$(CDSTS).f
	\mv $(CDSTS).o $(CDIRCL)$(CDOTOC)

$(CDIRCL)$(CDOTOC)/$(CMTRX).o :$(CDIRCL)$(CPATH3)/$(CMTRX).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATH3)/$(CMTRX).f
	\mv $(CMTRX).o $(CDIRCL)$(CDOTOC)

$(CDIRCL)$(CDOTOC)/$(CPLAN).o : $(CDIRCL)$(CPATH3)/$(CPLAN).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATH3)/$(CPLAN).f
	\mv $(CPLAN).o $(CDIRCL)$(CDOTOC)

$(CDIRCL)$(CDOTOC)/$(CGRDA).o : $(CDIRCL)$(CPATH4)/$(CGRDA).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATH4)/$(CGRDA).f
	\mv $(CGRDA).o $(CDIRCL)$(CDOTOC)

$(CDIRCL)$(CDOTOC)/$(CADAT).o : $(CDIRCL)$(CPATH4)/$(CADAT).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATH4)/$(CADAT).f
	\mv $(CADAT).o $(CDIRCL)$(CDOTOC)

$(CDIRCL)$(CDOTOC)/$(CINPA).o :$(CDIRCL)$(CPATH4)/$(CINPA).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATH4)/$(CINPA).f
	\mv $(CINPA).o $(CDIRCL)$(CDOTOC)

# RRTM files
$(CDIRCL)$(CDOTOR)/$(CRTM).o : $(CDIRCL)$(CPATHR)/$(CRTM).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATHR)/$(CRTM).f
	\mv $(CRTM).o $(CDIRCL)$(CDOTOR)

$(CDIRCL)$(CDOTOR)/$(CRTR).o : $(CDIRCL)$(CPATHR)/$(CRTR).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATHR)/$(CRTR).f
	\mv $(CRTR).o $(CDIRCL)$(CDOTOR)

$(CDIRCL)$(CDOTOR)/$(CREG).o : $(CDIRCL)$(CPATHR)/$(CREG).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATHR)/$(CREG).f
	\mv $(CREG).o $(CDIRCL)$(CDOTOR)

$(CDIRCL)$(CDOTOR)/$(CATM).o : $(CDIRCL)$(CPATHR)/$(CATM).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATHR)/$(CATM).f
	\mv $(CATM).o $(CDIRCL)$(CDOTOR)

$(CDIRCL)$(CDOTOR)/$(CSET).o : $(CDIRCL)$(CPATHR)/$(CSET).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATHR)/$(CSET).f
	\mv $(CSET).o $(CDIRCL)$(CDOTOR)

$(CDIRCL)$(CDOTOR)/$(CTAU).o : $(CDIRCL)$(CPATHR)/$(CTAU).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATHR)/$(CTAU).f
	\mv $(CTAU).o $(CDIRCL)$(CDOTOR)

$(CDIRCL)$(CDOTOR)/$(CRGC).o : $(CDIRCL)$(CPATHR)/$(CRGC).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATHR)/$(CRGC).f
	\mv $(CRGC).o $(CDIRCL)$(CDOTOR)

$(CDIRCL)$(CDOTOR)/$(CRTC).o : $(CDIRCL)$(CPATHR)/$(CRTC).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATHR)/$(CRTC).f
	\mv $(CRTC).o $(CDIRCL)$(CDOTOR)

$(CDIRCL)$(CDOTOR)/$(CEXT).o :$(CDIRCL)$(CPATHR)/$(CEXT).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATHR)/$(CEXT).f
	\mv $(CEXT).o $(CDIRCL)$(CDOTOR)

$(CDIRCL)$(CDOTOR)/$(CRTX).o : $(CDIRCL)$(CPATHR)/$(CRTX).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATHR)/$(CRTX).f
	\mv $(CRTX).o $(CDIRCL)$(CDOTOR)

$(CDIRCL)$(CDOTOR)/$(CRGX).o : $(CDIRCL)$(CPATHR)/$(CRGX).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATHR)/$(CRGX).f
	\mv $(CRGX).o $(CDIRCL)$(CDOTOR)

$(CDIRCL)$(CDOTOR)/$(CCLD).o : $(CDIRCL)$(CPATHR)/$(CCLD).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATHR)/$(CCLD).f
	\mv $(CCLD).o $(CDIRCL)$(CDOTOR)

#$(CDIRCL)$(CDOTOR)/$(CUTL).o : $(CDIRCL)$(CPATHR)/$(CUTL).f
#	$(FC) $(FCFLAG) $(CDIRCL)$(CPATHR)/$(CUTL).f
#	\mv $(CUTL).o $(CDIRCL)$(CDOTOR)

$(CDIRCL)$(CDOTOR)/$(CKGS).o : $(CDIRCL)$(CPATHR)/$(CKGS).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATHR)/$(CKGS).f
	\mv $(CKGS).o $(CDIRCL)$(CDOTOR)

$(CDIRCL)$(CDOTOR)/$(CTRNT).o : $(CDIRCL)$(CPATHR)/$(CTRNT).f
	$(FC) $(FCFLAG) $(CDIRCL)$(CPATHR)/$(CTRNT).f
	\mv $(CTRNT).o $(CDIRCL)$(CDOTOR)


