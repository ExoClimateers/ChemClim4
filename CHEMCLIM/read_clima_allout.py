'''
This code will generate four plots for the variables 'Temperature', 'Convection', 'Water Vapor', and 'Ozone' for each iteration of the loop. The plots are saved as image files in the animation_{fname} directory.

Please note that you might need to install the required Python libraries (numpy and matplotlib) if you haven't already. You can install them using pip:

>>>pip install numpy matplotlib

'''
import numpy as np
import matplotlib.pyplot as plt
from astropy.table import Table

def power10(value):
    value_ii = int(np.log10(value))
    num = np.around((value / 10**(value_ii)) * 100) / 100
    return f"10^{value_ii}"

fname = 'Sun_1.0_200_ff1.0'
skip = 20

# Create a directory for the frames
import os
os.makedirs(f"animation_{fname}", exist_ok=True)

# Read clima_calls.tab file and find the value of niter
with open(f"IO/clima_calls_{fname}.tab", 'r') as file:
    lines = file.readlines()
niter = int(lines[-1].split()[1])
print(niter)

clima_calls = np.zeros(niter)

# Find out how many times the climate code was called
with open(f"IO/clima_calls_{fname}.tab", 'r') as file:
    for i, line in enumerate(file):
        clima_calls[i] = float(line.split()[1])

print(np.sum(clima_calls))
print(np.sum(clima_calls) / skip)

# Read clima_allout file
with open(f"IO/clima_allout_{fname}.tab", 'r') as file:
    lines = file.readlines()

nverti     = int(lines[5])    # Num vertical lines
# niter      = 200              # Num iters
line       = 6                # Data starting line
i          = 1                # Starting iter
num_lines  = len(lines)       # Total number of lines
block_size = 8 + (2 * nverti) # Num lines in each iter


J      = np.zeros((niter // skip + 1, nverti))
P      = np.zeros((niter // skip + 1, nverti))
ALT    = np.zeros((niter // skip + 1, nverti))
T      = np.zeros((niter // skip + 1, nverti))
CONVEC = np.zeros((niter // skip + 1, nverti))
DT     = np.zeros((niter // skip + 1, nverti))
TOLD   = np.zeros((niter // skip + 1, nverti))
FH2O   = np.zeros((niter // skip + 1, nverti))
TCOOL  = np.zeros((niter // skip + 1, nverti))
THEAT  = np.zeros((niter // skip + 1, nverti))
FO3    = np.zeros((niter // skip + 1, nverti))

PF     = np.zeros((niter // skip + 1, nverti))
FTOTAL = np.zeros((niter // skip + 1, nverti))
FTIR   = np.zeros((niter // skip + 1, nverti))
FDNIR  = np.zeros((niter // skip + 1, nverti))
FUPIR  = np.zeros((niter // skip + 1, nverti))
FTSOL  = np.zeros((niter // skip + 1, nverti))
FDNSOL = np.zeros((niter // skip + 1, nverti))
FUPSOL = np.zeros((niter // skip + 1, nverti))
DIVF   = np.zeros((niter // skip + 1, nverti))


while i <= niter // skip  + 1 :
    iter_lines = lines[line : line + block_size]
    colnames = iter_lines[ 4 ].split()
    colnames.append('FO3')
    tab1       = Table(np.array([l.split() for l in iter_lines[5  : 205]]).astype(float),   names = colnames)
    tab2       = Table(np.array([l.split() for l in iter_lines[207: 407]]).astype(float),   names = iter_lines[206].split())
    if i == 1:
        print(tab1.colnames)
        print(tab2.colnames)
    J[     i - 1, :] = np.array(tab1['J'])
    P[     i - 1, :] = np.array(tab1['P'])
    ALT[   i - 1, :] = np.array(tab1['ALT'])
    T[     i - 1, :] = np.array(tab1['T'])
    CONVEC[i - 1, :] = np.array(tab1['CONVEC'])
    DT[    i - 1, :] = np.array(tab1['DT'])
    TOLD[  i - 1, :] = np.array(tab1['TOLD'])
    FH2O[  i - 1, :] = np.array(tab1['FH20'])
    TCOOL[ i - 1, :] = np.array(tab1['TCOOL'])
    THEAT[ i - 1, :] = np.array(tab1['THEAT'])
    FO3[   i - 1, :] = np.array(tab1['FO3'])


    PF[    i - 1, :] = np.array(tab2['PF'])
    FTOTAL[i - 1, :] = np.array(tab2['FTOTAL'])
    FTIR[  i - 1, :] = np.array(tab2['FTIR'])
    FDNIR[ i - 1, :] = np.array(tab2['FDNIR'])
    FUPIR[ i - 1, :] = np.array(tab2['FUPIR'])
    FTSOL[ i - 1, :] = np.array(tab2['FTSOL'])
    FDNSOL[i - 1, :] = np.array(tab2['FDNSOL'])
    FUPSOL[i - 1, :] = np.array(tab2['FUPSOL'])
    DIVF[  i - 1, :] = np.array(tab2['DIVF'])

    if i == niter // skip:
        line      += (skip - 1) * block_size
    else:
        line      += skip * block_size
    i         += 1


# Generate plot for each variable
for i in range(niter // skip + 1):
    plt.figure(figsize=(10, 10))

    # Temperature profile
    plt.subplot(2, 2, 1)
    plt.plot(T[i], ALT[i], 'b-', label='T')
    plt.xlabel('Temperature (K)')
    plt.ylabel('Altitude (km)')
    plt.title(f'Temperature Profile (Iteration {i * skip})')
    plt.legend()

    # Convection profile
    plt.subplot(2, 2, 2)
    plt.plot(CONVEC[i], ALT[i], 'r-', label='Convection')
    plt.xlabel('Convection (K/s)')
    plt.ylabel('Altitude (km)')
    plt.title(f'Convection Profile (Iteration {i * skip})')
    plt.legend()

    # Water vapor profile
    plt.subplot(2, 2, 3)
    plt.plot(FH2O[i], ALT[i], 'g-', label='H2O')
    plt.xlabel('Water Vapor (ppmv)')
    plt.ylabel('Altitude (km)')
    plt.title(f'Water Vapor Profile (Iteration {i * skip})')
    plt.legend()

    # Ozone profile
    plt.subplot(2, 2, 4)
    plt.plot(FO3[i], ALT[i], 'm-', label='O3')
    plt.xlabel('Ozone (ppmv)')
    plt.ylabel('Altitude (km)')
    plt.title(f'Ozone Profile (Iteration {i * skip})')
    plt.legend()

    plt.tight_layout()

    # Save the plot as an image file
    plt.savefig(f"animation_{fname}/iteration_{i * skip}.png")
    plt.close()

print('Done generating plots!')
