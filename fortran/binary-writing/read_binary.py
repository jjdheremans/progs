import struct
import numpy as np


with open('bin_file','rb') as file:
    # Method 1 : Reading float number one by one
    M = struct.unpack('i', file.read(4))[0] # read integer
    N = struct.unpack('i', file.read(4))[0] # read integer
    Result = np.zeros( shape=(M,N), dtype = 'float32')
    for i in range( N*M ):
        num = struct.unpack('f', file.read(4))[0] # read float
        ii, jj = np.unravel_index(i,(M,N),'F')
        Result[ii,jj] = num

    print( Result )

    # Method 2 : Reading a full column at a time
    M = struct.unpack('i', file.read(4))[0] # read integer
    N = struct.unpack('i', file.read(4))[0] # read integer
    Result = np.zeros( shape=(M,N), dtype = 'float64')
    for i in range( N ):  
        try:
            col = struct.unpack('f'*M, file.read(4*M)) # read N x float --> one full column
            Result[:,i] = col 
        except:
            print("Error")

    print( Result )
