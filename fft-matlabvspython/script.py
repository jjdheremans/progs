import numpy as np 
import random 
import os 

class xtime:
    def __init__(self):
        self.x0 = [] # initial x 
        self.x1 = [] # After one round

class FFT:
    def __init__(self):
        self.matlab = []
        self.python = []

# os.system('matlab -nodesktop -nosplash -r "script ; exit ;" ')
file = open( 'matlaboutput.txt' )
next( file )

T = 50 
N = 500 
dt = T / N 

Results = [] 
i = 0
for line in file:
    vec = [float(x) for x in line.split()]
    Results.append(vec)
    i+=1

if i!=N:
    print('Error')
    exit()


Results = np.array( Results, dtype = 'float64')
xt_matlab = xtime()
xt_python = xtime()

xt_matlab.x0 = Results[:,0]
xt_matlab.x1 = Results[:,3]
xt_python.x0 = Results[:,0]

Xw = FFT()
Xw.matlab = Results[:,1] + 1j * Results[:,2]
Xw.python = np.fft.fft( xt_python.x0 ) * dt
xt_python.x1 = np.fft.ifft( Xw.python ) / dt

print("Compararison Xw (from fft)")
print("{:12s} {:12s} {:12s} {:12s}".format("Mat:real(Xw)", "Pyt:real(Xw)", "Mat:imag(Xw)","Pyt:imag(Xw)"))
for i in range( N ):
    print( "{:12.4f} {:12.4f} {:12.4f} {:12.4f}".format( np.real( Xw.matlab[i] ) , np.real( Xw.python[i]), np.imag( Xw.matlab[i] ) , np.imag( Xw.python[i]) ) )

print("\nCompararison xt (from ifft)")
print("{:12s} {:12s}".format("Matlab: xt", "Python: xt"))
for i in range( N ):
    print("{:12.4f} {:12.4f}".format( xt_matlab.x1[i], np.real(xt_python.x1[i]) ) )
