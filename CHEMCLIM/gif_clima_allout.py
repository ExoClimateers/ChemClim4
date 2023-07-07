'''
This code will generate four plots for the variables 'Temperature', 'Convection', 'Water Vapor', and 'Ozone' for each iteration of the loop. The plots are saved as image files in the animation_{fname} directory.

Please note that you might need to install the required Python libraries (numpy and matplotlib) if you haven't already. You can install them using pip:

>>>pip install numpy matplotlib

'''

fname = 'Sun_1.0_200_ff1.0'
skip = 20
OutName = fname + '.gif'
star = None

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #
import numpy as np
import matplotlib.pyplot as plt
from astropy.table import Table

# Create a directory for the frames
import os
os.makedirs(f"animation_{fname}", exist_ok=True)

if star == None:
    with open(f"IO/input_couple.dat", 'r') as file:
        lines = file.readlines()
        star = lines[1]

# Read clima_calls.tab file 
with open(f"IO/clima_calls_{ fname}.tab", 'r') as file:
    lines = file.readlines()

niter       = int(lines[-1].split()[1]) # Num iterations
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

nverti      = int(lines[5])             # Num vertical lines
line        = 6                         # Data starting line
i           = 1                         # Starting iter
num_lines   = len(lines)                # Total number of lines
block_size  = 8 + (2 * nverti)          # Num lines in each iter
 

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
    tab1       = Table(np.array([l.split() for l in iter_lines[ 5  : 205]]).astype(float),   names = colnames)
    tab2       = Table(np.array([l.split() for l in iter_lines[207 : 407]]).astype(float),   names = iter_lines[206].split())
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
        line      += skip       * block_size
    i             += 1


import matplotlib.animation as animation
import matplotlib as mpl

# Edit this if you have resolution scaling issues
mpl.rcParams["figure.dpi"] = 300

# Import seaborn (optional)
# import seaborn as sns

def initPlot():
    fig, axs = plt.subplots(2, 2, figsize = (15, 15), sharey=True,)
    for ax in axs.flat:
        ax.set_ylim(0, np.max(ALT))
        ax.grid(True)
    axs[0,0].set_ylabel('Altitude (km)')
    axs[1,0].set_ylabel('Altitude (km)')
    fig.subplots_adjust(wspace=0)
    return fig, axs

def plotIter(axs, i):
    plt_lines = []

    # Temperature profile
    ax = axs[0,0]
    plt_lines.append(ax.plot(T[i], ALT[i], 'r-', label='T'))
    ax.set_xlabel('Temperature (K)')
    ax.set_xlim(195, 300)
    ax.set_title(f'Temperature Profile (Iteration {i * skip})')
    ax.legend()

    # Convection profile
    ax = axs[0,1]
    plt_lines.append(ax.plot(CONVEC[i], ALT[i], 'g-', label='Convection'))
    ax.set_xlabel('Convection (K/s)')
    ax.set_xlim(-.1, 2.1)
    ax.set_title(f'Convection Profile (Iteration {i * skip})')
    ax.legend()

    # Water vapor profile
    ax = axs[1,0]
    plt_lines.append(ax.plot(FH2O[i], ALT[i], 'b-', label='H2O'))
    ax.set_xlabel('Water Vapor (ppmv)')
    ax.set_xlim(-.001, .02)
    ax.set_title(f'Water Vapor Profile (Iteration {i * skip})')
    ax.legend()

    # Ozone profile
    ax = axs[1,1]
    plt_lines.append(ax.plot(FO3[i], ALT[i], 'c-', label='O3'))
    ax.set_xlabel('Ozone (ppmv)')
    ax.set_xlim(0, 1.3e-5)
    ax.set_title(f'Ozone Profile (Iteration {i * skip})')
    ax.legend()

    for ax in axs.flat:
        ax.set_ylim(0, np.max(ALT))
        ax.grid(True)
    axs[0,0].set_ylabel('Altitude (km)')
    axs[1,0].set_ylabel('Altitude (km)')

    plt.tight_layout()

    return plt_lines

def animate(i):
    for ax in axs.flat:
        ax.cla()
    it = i * skip
    fig.suptitle(star + " iteration : " + str(it))
    plt_lines = plotIter(axs, i)    
    return plt_lines

def write():
    # To save the animation using Pillow as a gif
    writer = animation.PillowWriter(fps=5,
                                    metadata=dict(artist='Mucephie'),
                                    bitrate=1800)
    writer.setup(fig = fig, outfile = "animation_" + fname + "/" + OutName, dpi=300)
    print('Output Setup finished. ')
    print('Saving...\n')
    ani.save(f"animation_{fname}/" + OutName, writer=writer, dpi = 300)
    writer.finish()
    print('Saved!')

## SETUP RUN
# Initialize the plot
fig, axs = initPlot()
# Call the animator
ani = animation.FuncAnimation(fig, animate, repeat=True, frames=len(T), interval=500)
# Write out the GIF file (Optional)
write()#niter // skip 
# Show the plot window
plt.show()

print('Done generating plots!')
