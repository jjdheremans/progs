% Ce script détaille l'équivalence entre la fonction var de matlab et
% intégrales des PSD (comment calculer la variance d'un processus de ces
% deux manières), comment effectuer/verifier correctement le scaling de
% la PSD target, 

% Application: Un panneau publicitaire soumis au vent turbulent. Calculer
% la variance des déplacement du panneau.

%% Données du panneau
M = 150 ;           % kg    - masse du panneau
Iy = 2*541*10^4 ;   % mm4   - intertie des poteaux
E = 210000 ;        % MPa   - module de rigidité
L = 2500 ;          % mm    - longueur des poteaux
K = ( 3 * E * Iy / (L^3) ) * 1000 ; % N / m - raideur des poteaux
xi = 0.4/100 ;      % -     - amortissement
C = 2 * xi * sqrt(K*M) ; %  - damping
A = 3 * 2 ;         % m2    - aire du panneau

% Vent:
rho = 1.292 ;       % kg/m3 - masse volumique de l'aire.
Cd = 1 ;            % -     - coefficient de trainee.
U = 30 ;            % m/s   - vitesse moyenne du vent
sig = 15/100 * U ;  % m/s   - ecart-type vitesse de vent


%% PSD des vitesses de vent
N = 2^18 ; T = 2400 ; 
dt = T / N ; df = 1 / T ;
ff  = ( 0 : N/2 -1 ) * df  ;
ww  = 2 * pi * ff ;
Sff = 2/3 * ff * (1200 / U).^2 ./ (1 + (ff * 1200 / U).^2).^(4/3) * sig^2 / ( 4 * pi ) ; % doit etre echelonnee de telle sorte que int( ww, Sff ) = sig^2 
ut = WindGenSN( Sff, N, T, dt ) ;   % gerenation d'une histoire de vent sur base de la PSD target Sff
varXTH = 2 * trapz( ww, Sff ) ;     % les deux variances doivent être égales
varNU = var( ut ) * (2*pi)^2  ;     % les deux variances doivent être égales


% Affichage
figure 
psd1 = Sff ;
psd2 = pwelch(ut , floor(N/30), 0, ff, 1/dt)* 2 * pi ;
semilogy( ff, psd2, ff, psd1)
legend({'Frequentiel','Simulation'})
title('PSD du vent')
grid on

% Les deux variances doivent être les mêmes.
fprintf('Variance Théorique de u: %f (doit etre egal a la variance sig^2=%f, sinon, la PSD n''est pas scaleee)\n',varXTH, sig^2)
fprintf('Variance Numérique de u: %f\n',varNU)


%% PSD des déplacements
Hww = 1 ./ ( K + 1i * ww * C - ww.^2 * M ) ;    % fonction de transfert
Sx = ( rho*Cd*A*U )^2 * abs( Hww ).^2 .* Sff ;  % PSD des déplacements
Fd = rho * Cd * U * A * ut ;                    % forces aero-élastiques
[dep,~,~,~] = Newmark123(1,N,M,K,C,Fd,0,0,dt) ; % résolution par Newmark
varXTH = 2 * trapz( ww, Sx )  ;                 % variance théorique
varNU = var( dep ) * (2*pi)^2  ;                % variance numérique

% Affichage
figure 
psd1 = Sx ;
psd2 = pwelch(dep , floor(N/30), 0, ff, 1/dt)* 2 * pi ;
semilogy( ff, psd1, ff, psd2)
legend({'Frequentiel','Simulation'})
title('PSD des déplacements de la structure')
grid on

% Les deux variances doivent être les mêmes.
fprintf('Variance Théorique de x: %f\n',varXTH) % les deux variances doivent être égales
fprintf('Variance Numérique de x: %f\n',varNU)  % les deux variances doivent être égales