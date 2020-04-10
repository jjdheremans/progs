function [xt] = WindGenSN( targetPSD, NValues, T, dt )

SIZ = NValues / 2  ;
fft_x = zeros( 1, NValues ); 
fft_x(1:SIZ) = sqrt( T / (2 * pi) ) * sqrt(targetPSD) .* exp(1i * rand(1,SIZ) * 2 * pi ) ;

fft_x(SIZ + 1) = 0 ;
fft_x(SIZ + 2:NValues) = conj( fft_x(SIZ:-1:2) ) ;
fft_x(1) = 0;

xt = ifft( fft_x ) / dt ;

end

