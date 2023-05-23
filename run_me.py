'''
Title: run_me.py
Author: SRugheimer, JParsons
Date_modified: 2023_05_23
Date_created: 2023_05_23
Description:

Notes:

'''
import os
import sys
import math
from numpy import *

# path to directories

IO_path=os.getcwd()+'/IO/'
NZ_path=os.getcwd()+'/ATMCHEM/INCLUDECHEM/'
ND_path=os.getcwd()+'/CLIMA/INCLUDECLIM/'

#################################
#                               #
# input parameters for the code #
#                               #
#################################

# star parameters: 
'''
    # NOTE:: this takes a list/array even if you are only handing a single star to the run
    # related parameters like flux_fac are also lists/arrays of the same size.
'''
star=['Sun'] # star spectral type template to use in Clima
# Sun, F2V, K2V, dMV and Sarah's stars: F2a, K2a, G2a, F0V, F5V, F9V, G2V, G8V, K2V, K5V
'''
    # NOTE:: we could also write
    # dist = some_value_in_some_units 
    # flux_fac = [ 1 / dist**2 ]
'''
fluxfac=[1.0] # distance scaling. Scale flux of stellar input by the inverse square of the planets orbital distance

# name of the output files:
# name="conv_layertest_"

# The old temperatures, heat capacities, time step, surface gravity, the pressure grid, and the fluxes

# couple.f parameters:
NITER=2     # number of total iterations
NSTEPSC=100 # number of times the climate code is called
NSTEPSP=100 # number of times the photochemistry is called 

'''
TODO: see if any of these old commented out values are useful and then clean up
#Ptop=[2.5e-4, 6.5e-5 ]                          # pressure at the top in bar
#Ptop for F0,   F2,   F5,    F7,    F9,    G2,   SUN   G8,  K0,   K2,   K4,   K5,   K7 at 65km
#Ptop=[4.e-4, 3.5e-4, 3.e-4, 2.5e-4, 2.e-4,1.e-4,1e-4]#,8.e-5,7.e-5,6.5e-5,6.e-5,3.5e-5,3.e-5]
#ffSun=[0.756,0.797,
#Ptop=[1.0e-4, 1.e-4, 1.e-4, 1.e-4, 1.e-4, 1.e-4, 9.e-5, 7.e-5, 6.5e-5, 6.e-5, 5.e-5, 4.e-5, 3.e-5]
ND=[100]
#ND=[60,90,120,150,180,210,240,270,300,330,360,390,420,450,480,510,540,570,600]
'''

#clima code parameters:
Ptop=[1.e-4]                        # pressure at the top in bar
TG0=288.                            # initial surface temperature in K  
TSTRAT=200.                         # initial stratosphere temperature in K

#atm_chem input parameters:
height=68.                          # height of the atmosphere [km]. requires some experimenting
ND=[100]                            # number of altitude layers in altitude grid
NZ=ND                               #
delz=[]                             # 'Delta Z' 
JTROP=[]                            # J troposphere
for i in range(len(ND)):            # loop over altitude layer grid
    delz.append(height*1e5/NZ[i])   # append 'Delta Z' for layer
    ZTROP=1.1E6                     # height of the tropopause in cm
    JTROP.append(ZTROP/delz[i])     # grid layer marking the tropopause height

# cloud properties:
'''
TODO:: see if any of these old commented out values are useful and then clean up
    #cdeck=[0,1.,2.,3.,4.,5.,6.]               # km - cloud deck
    #ctop=[0,4.,5.,6.,7.,8.,9.]                # km - cloud top
    #rdrop=[0,10.,10.,10.,10.,10.,10.]         # micron - droplet size
    #npart=[0,100.,100.,100.,100.,100.,100.]   # droplets/cm^3 - number density of droplets
'''

cdeck=0.                # km - cloud deck
ctop=0.                 # km - cloud top
rdrop=0.                # micron - droplet size
rdrop=rdrop/1e4         # converting rdrop to cm
npart=0.                # droplets/cm^3 - number density of droplets

# planet parameters:
G=980.7                 # the value of gravity
R0=1.                   # planet radius
P0=1.                   # pressure at the surface
ALB=0.2                 # surface albedo of the planet
RELHUM_surf=0.77        # relative humidity on the surface
ZY=60                   #zenith angle

# initial atmosphere mixing ratios:
FAR=1e-2                # Argon
FCH4=1.6e-6             # Methane
FCO2=3.55e-4            # Carbon dioxide	
FO2=0.21                # Oxygen	
O3save=7.46e18          # O3 columd depth

FH2O=1e-5               # water mixing ratio in the stratosphere
FO3=1e-6                # ozone mixing ratio
FH2 = 5.5E-7            #
FCO = 9.0E-8            #
FN2O = 3.0E-7           #
FCH3CL = 5.0E-10        #
RPAR = 1.E-9            #
AERSOL = 1.E-12         #
WFALL = 1.              #
SO4AER = 1.E-7          #
Fother=1e-20            # mixing ratio of all other chemicals

#######################################
#                                     #
# generating input files for chemclim #
#                                     #
#######################################

# DO NOT CHANGE STUFF BELOW HERE UNLESS YOU KNOW WHAT YOU ARE DOING!
for l in range(len(fluxfac)):                                          # loop over orbital distance flux scaling
    for j in range(len(star)):                                         # loop over stellar type
        name= star[j] + "_" + str(fluxfac[l])                          # set name of run
        # TODO:: write this without using a computationally costly loop
        # for k in range(len(ND)):              # loop over altitude grid
        # EDIT:: this is my shortcut for now (needs testing)
        if (max(ND)>600):                                              # check for excessive altitude values
            print('You choose an ND value greater than 600.')
            print('Before you compile and run the code, see the header of rrtm.f')
            print('and tridag.f and apply the necessary changes.')
            print('Then rerun the python script.')
            sys.exit()
        for k in range(len(ND)):                                       # loop over altitude grid
            # Setup input_couple.dat
            couple=open(IO_path+"input_couple.dat","w")                # open dat file for write
            couple.write("c input_couple generated by S. MacGregor\n") # write out header and params
            couple.write(str(star[j])+"\n")
            couple.write(str(fluxfac[l])+"\n")
            couple.write(str(NITER)+"\n")
            couple.write(str(NSTEPSC)+"\n")
            couple.write(str(NSTEPSP)+"\n")
            if name == " ":                                            # assign a name to output tabs if missing
                    namek = str(ND[k])
            else:
                namek = name+"_"+str(ND[k])
            couple.write("clima_allout_"+namek+"_ff"+str(fluxfac[l])+".tab\n")
            couple.write("clima_calls_"+namek+"_ff"+str(fluxfac[l])+".tab")
            couple.close()                                             # close input dat file

            # Setup input_clima.dat
            clima=open(IO_path+"input_clima.dat","w")
            clima.write("IMW=       1\n")
            clima.write("RSURF=     "+str(RELHUM_surf)+"\n")
            clima.write("ZY=        "+str(ZY)+"\n")
            clima.write("DTAU0=     0.5\n")
            clima.write("ZCON=      20\n")
            clima.write("P0=        "+str(Ptop[j])+"\n")
            clima.write("FAC=       1.\n")
            clima.write("IO3=       1\n")
            clima.write("IUP=       0\n")                 
            clima.write("TG0=       "+str(TG0)+"\n")  
            clima.write("TSTRAT=    "+str(TSTRAT)+"\n")
            clima.write("ICONSERV=  0\n")
            clima.write("SRFALB=    "+str(ALB)+"\n")
            clima.write("CO2MAX=    3.55e-2\n")
            clima.write("Idry=      0\n")
            clima.close()
            # Setup planet.dat
            planet=open(IO_path+"planet.dat","w")
            planet.write(str(G)+"    = G, Gravity - Earth=980.7, Mars=373.0, Gl581g\n")
            planet.write(str(R0)+"     = R0 (planet radius on Earth radius units)\n")
            planet.write(str(P0)+"      = surface pressure\n")
            planet.write(str(ALB)+"     = ALB, Surface Albedo - Earth=0.25, Mars=0.215\n")
            planet.write(str(delz[k])+"    = DELZ, Height of each atm layer - Earth=1.0E5, Mars=2.0E5 (cm)\n")
            planet.write(str(ZTROP)+"    = ZTROP, Height of the tropopause - typically Earth=11km, Mars=15km\n")
            planet.write(str(JTROP[k])+"       = JTROP, Grid layer marking the tropopause height, depends on ZTROP and DELZ\n")
            planet.close()
            # input_atmchem.dat
            atmo=open(IO_path+"input_atmchem.dat","w")
            atmo.write("ZY=        "+str(ZY)+"\n")
            atmo.write("AGL=       0.5\n")
            atmo.write("ISEASON=   1\n")
            atmo.write("IZYO2=     0\n")
            atmo.write("IO2=       1\n")
            atmo.write("INO=       1\n")
            atmo.write("EPSJ=      1.E-7\n")
            atmo.write("ZTROP=     "+str(ZTROP)+"\n")
            atmo.write("FCO2=      3.55e-4\n")
            atmo.write("FO2=       0.21\n")
            atmo.close()
            # mixing_ratios.dat
            mixing=open(IO_path+"mixing_ratios.dat","w")
            mixing.write(str(FAR)+"\n")
            mixing.write(str(FCH4)+"\n")
            mixing.write(str(FCO2)+"\n")
            mixing.write(str(FO2)+"\n")
            mixing.write(str(JTROP[k])+"\n")
            mixing.write(str(O3save)+"\n")
            mixing.close()
            # input_comp.dat    
            comp=open(IO_path+"input_comp.dat","w")
            comp.write(str(FH2O)+"\n")
            comp.write(str(FO3)+"\n")
            comp.write(str(FH2)+"\n")
            comp.write(str(FCO)+"\n")
            comp.write(str(FN2O)+"\n")
            comp.write(str(FCH3CL)+"\n")
            comp.write(str(RPAR)+"\n")
            comp.write(str(AERSOL)+"\n")
            comp.write(str(WFALL)+"\n")
            comp.write(str(SO4AER)+"\n")
            comp.write(str(Fother)+"\n")
            comp.close()
            # parND.inc
            # first open parND.inc and check whether the new ND is different from the old one.
            # if it is different, the code will be compiled with make -B, if not, only with make.
            makeB=0
            NDf=open(ND_path+"parND.inc","r")
            NDf.readline()
            NDf.readline()
            st=NDf.readline()
            NDf.close()
            if int(st[19:22]) != ND[k]:
                makeB=1
                NDf=open(ND_path+"parND.inc","w")
                NDf.write("c Number of layers\n")
                NDf.write("c S MacGregor\n")
                NDf.write("      PARAMETER(ND="+str(ND[k])+" , NL=ND-1)\n")
                NDf.close()
            # parNZ.inc (same as for parND:)
            NZf=open(NZ_path+"parNZ.inc","r")
            NZf.readline()
            st=NZf.readline()
            NZf.close()
            if int(st[19:22]) != NZ[k]:
                makeB=1
                NZf=open(NZ_path+"parNZ.inc","w")
                NZf.write("c Number of layers\n")
                NZf.write("      PARAMETER(NZ="+str(NZ[k])+" )\n")
                NZf.close()
            # cloud.dat
            # generating the cloud file
            cloud=open(IO_path+"cloud.dat","w")
            # generating the height array, height is in km
            Z=arange(0,100,0.1)
            # generating the RPART and NPART arrays
            RPART=[]
            NPART=[]
            for ii in Z:
                if ii < cdeck:
                    RPART.append(0.)
                    NPART.append(0.)
                elif (ii >= cdeck) and (ii <= ctop): 
                    RPART.append(rdrop)
                    NPART.append(npart)
                else:
                    RPART.append(0.)
                    NPART.append(0.)        
            # writing the cloud file
            cloud.write(str(len(Z))+"\n")
            for ii in range(len(Z)):
                s1=str(Z[ii])
                s2=str(RPART[ii])
                s3=str(NPART[ii])
                s=s1+" "+s2+" "+s3+"\n"
                cloud.write(s)
            cloud.close()
            ####################
            # running the code #
            ####################
            # recompiling the code
            if makeB == 1:
                os.system("make -B")
            else:
                os.system("make -B")
            # wait for keypress to confirm that the compilation was ok
            #    raw_input('Press Enter if compilation was ok...') # NOTE:: not used right now, but we can make it optional with a flag
            # running the code
            os.system("./couple")
            # renaming output files
            os.system("cp IO/outchem.dat IO/outchem_"+namek+"_ff"+str(fluxfac[l])+".dat\n")
            os.system("cp IO/output_couple.dat IO/output_couple_"+namek+"_ff"+str(fluxfac[l])+".dat")
            os.system("cp IO/altPT-lisa.dat IO/altPT_"+namek+"_ff"+str(fluxfac[l])+".txt")
            os.system("cp IO/chem-lisa.dat IO/chem_"+namek+"_ff"+str(fluxfac[l]))
            os.system("cp IO/convergence.txt IO/convergence_"+namek+"_ff"+str(fluxfac[l])+".txt")

