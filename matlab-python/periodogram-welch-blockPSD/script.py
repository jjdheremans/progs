import os
import sys
import matplotlib.pyplot as plt
import scipy.signal as signal
import numpy as np

# This script illustrates how to properly use the functions periodogram, welch with an equivalence between welch, periodogram and a self made function which perform block PSD calculation of a given signal.

# More information regarding the welch and periodogram method implementation in python may be found at the following URL. Results haven't been tested into matlab, but the algorithm are surely the same.
# https://stackoverflow.com/questions/29429733/cant-find-the-right-energy-using-scipy-signal-welch
# When the "onesided" option is used, the spectrum is multiplied by 2, so that the factor 2*pi/T becomes pi/T

def swpsdc( xt, fs, nb_blocks ):
    dt = 1/fs
    nvalues = len(xt)
    nvalues_block = nvalues // nb_blocks
    if nvalues_block%2 == 0: # NValuesBlock is even
        HalfSidewBlock = nvalues_block // 2 - 1
    elif nvalues_block%2 == 1: # NValuesBlock is odd
        HalfSidewBlock = (nvalues_block - 1) // 2

    dfblock = fs / nvalues_block
    Tblock = 1 / dfblock
    index = 0 
    PSDx = np.zeros( HalfSidewBlock, dtype="float64")
    for i in range(nb_blocks):
        XFFT = 2. * np.pi/Tblock * np.absolute( np.fft.fft( xt[index:index+nvalues_block] ) * dt )**2 
        PSDx = PSDx + XFFT[0:HalfSidewBlock]
        index = index + nvalues_block

    PSDx = PSDx / nb_blocks
    f_block = np.arange(0, fs, dfblock)
    return PSDx, f_block[0:HalfSidewBlock]
    

print( "Switching to PYTHON ENVIRONMENT" )

fullname = "xt_histo"
print( "Searching for file: ",fullname )
try:
    file = open(fullname,"r")
except:
    print("Result file opening failed. No such file in directory.")
    exit() 

i = 0 
Result = []
for line in file:
    try:
        vec = [ float(x) for x in line.split() ] 
        Result.append(vec)

    except:
        print ("error")
        break

    if i%1000==0:
        print ( "Node:",i )

    i+=1

file.close()
N = i 

Results = np.array(Result, dtype='float32')
x = Results[:,1]
nb_blocks = 30
freq, PSD = signal.periodogram( x, fs = 13.95, window='boxcar', nfft = N//nb_blocks, return_onesided=True)
PSD2, freq2 = swpsdc( x, fs=13.95, nb_blocks=nb_blocks )
freq3, PSD3 = signal.welch( x, fs = 13.95, window='boxcar', nfft = N//nb_blocks,  noverlap=None, return_onesided=True)
strg = 'PSD11'
plt.loglog( freq, np.pi*PSD, ls='-', label='Periodogram', LineWidth = 1, alpha=1 )
plt.loglog( freq2, PSD2, ls='-', label='SWPSDC', LineWidth = 1, alpha=1 )
plt.loglog( freq3, np.pi*PSD3, ls='-', label='Welch', LineWidth = 1, alpha=1 )
plt.grid()
plt.legend()
plt.show()


print( "Getting out of PYTHON ENVIRONMENT" )
