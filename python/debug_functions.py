import numpy as np 


# save np.array of second order to hard dsik
def save_matrix( filename, matrix ):

   with open( filename, mode='w') as file:

      nlines = np.size( matrix, 0 )
      ncolumns = np.size( matrix, 1 )
      for i in range( nlines ):
         for j in range( ncolumns ):
            file.write( '{:15.5e} '.format(matrix[i,j])  )
         file.write( '\n')

# save np.array of second order to hard dsik
def read_matrix( filename ):

   with open( filename, mode='r') as file:
      mat = [] 
      for line in file:
         data = list( map( float, line.split() ) )
         mat.append( data )

   mat = np.array( mat )
   return mat 

def read_vector_matrixF( filename, dim1, dim2 ):
   mat = read_matrix( filename )
   mat = np.reshape( mat, (dim1, dim2), order='F' )
   return mat

# save np.array of first order to hard dsik
def save_vector( filename, vector ):

   with open( filename, mode='w') as file:
      file.write( format( vector ) )

A = np.random.rand( 5, 9 )
save_matrix( 'file.mat', A )
         