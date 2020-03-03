T = 50 ;
N = 500 ;
dt = T / N ;
xt = rand(N,1)*10. ;
Xw = fft( xt ) * dt ;
xt2 = ifft( Xw ) / dt ;

file = fopen('matlaboutput.txt','w') ;
fprintf(file, '%12s %12s %12s\n','x(t)','real( X(w) )','imag( X(w) )') ;
for i = 1:N
    fprintf( file, "%12.4f %12.4f %12.4f %12.4f\n", xt(i), real( Xw(i)), imag( Xw(i)), xt2(i) ) ;
end
fclose( file ) ;