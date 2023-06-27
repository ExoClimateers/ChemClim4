'''
This code will generate four plots for the variables 'Temperature', 'Convection', 'Water Vapor', and 'Ozone' for each iteration of the loop. The plots are saved as image files in the animation_{fname} directory.

Please note that you might need to install the required Python libraries (numpy and matplotlib) if you haven't already. You can install them using pip:

>>>pip install numpy matplotlib

'''
import numpy as np
import matplotlib.pyplot as plt

def power10(value):
    value_ii = int(np.log10(value))
    num = np.around((value / 10**(value_ii)) * 100) / 100
    return f"10^{value_ii}"

fname = 'Sun_100'
skip = 20

# Create a directory for the frames
import os
os.makedirs(f"animation_{fname}", exist_ok=True)

# Read clima_calls.tab file and find the value of niter
with open(f"IO/clima_calls_{fname}.tab", 'r') as file:
    lines = file.readlines()
niter = int(lines[-1].split()[1])

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

res = lines[3].split('=')[1].split()
print(res[0], res[1], '=', res[2])
print(res[3], '=', res[4])
print(res[5], '=', res[6])
print(res[7], '=', res[8])
print(res[9], '=', res[10])
print(res[11], '=', res[12])
print(res[13], '=', res[14])

nverti = int(lines[4])

# Initialize arrays to store variables
data_start = 15
data_end = data_start + niter * (nverti + 3) + 1

J = np.zeros((niter // skip, nverti))
P = np.zeros((niter // skip, nverti))
ALT = np.zeros((niter // skip, nverti))
T = np.zeros((niter // skip, nverti))
CONVEC = np.zeros((niter // skip, nverti))
DT = np.zeros((niter // skip, nverti))
TOLD = np.zeros((niter // skip, nverti))
FH2O = np.zeros((niter // skip, nverti))
TCOOL = np.zeros((niter // skip, nverti))
THEAT = np.zeros((niter // skip, nverti))
FO3 = np.zeros((niter // skip, nverti))

PF = np.zeros((niter // skip, nverti))
FTOTAL = np.zeros((niter // skip, nverti))
FTIR = np.zeros((niter // skip, nverti))
FDNIR = np.zeros((niter // skip, nverti))
FUPIR = np.zeros((niter // skip, nverti))
FTSOL = np.zeros((niter // skip, nverti))
FDNSOL = np.zeros((niter // skip, nverti))
FUPSOL = np.zeros((niter // skip, nverti))
DIVF = np.zeros((niter // skip, nverti))

for i in range(niter // skip):
    for j in range(nverti):
        line = lines[data_start + i * (nverti + 3) + j]
        values = line.split()
        J[i, j] = float(values[0])
        P[i, j] = float(values[1])
        ALT[i, j] = float(values[2])
        T[i, j] = float(values[3])
        CONVEC[i, j] = float(values[4])
        DT[i, j] = float(values[5])
        TOLD[i, j] = float(values[6])
        FH2O[i, j] = float(values[7])
        TCOOL[i, j] = float(values[8])
        THEAT[i, j] = float(values[9])
        FO3[i, j] = float(values[10])
        PF[i, j] = float(values[11])
        FTOTAL[i, j] = float(values[12])
        FTIR[i, j] = float(values[13])
        FDNIR[i, j] = float(values[14])
        FUPIR[i, j] = float(values[15])
        FTSOL[i, j] = float(values[16])
        FDNSOL[i, j] = float(values[17])
        FUPSOL[i, j] = float(values[18])
        DIVF[i, j] = float(values[19])

# Generate plot for each variable
for i in range(niter // skip):
    plt.figure(figsize=(10, 6))

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
