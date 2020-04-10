function [dep,vit,acc,qs] = Newmark123(nddl,Nstep,M,K,C,p,dep_init,vit_init,dt)

dep = zeros(nddl,Nstep);
vit = zeros(nddl,Nstep);
acc = zeros(nddl,Nstep);
qs  = zeros(nddl,Nstep);

dep(:,1) = dep_init ;
vit(:,1) = vit_init ;
acc(:,1) = M\(p(:,1)-C*vit(:,1)-K*dep(:,1));

alpha = 1/4; % Dans le cas : acceleration lineaire (1/4 pour l'acceleration constante)
delta = 1/2; % Pour les deux cas

Coef_Acc = M + (delta*dt)*C + (alpha*dt^2)*K ;
invCoeff_Acc = inv(Coef_Acc);
invK = inv(K);

for i = 2:Nstep
    acc(:, i) = invCoeff_Acc * (p(:, i) - C * (vit(:, i - 1) + dt * (1 - delta) * acc(:, i - 1)) - K * (dep(:, i - 1) + dt * vit(:, i - 1) + dt^2 * (0.5 - alpha) * acc(:, i - 1)));
    vit(:, i) = vit(:, i - 1) + dt * ((1 - delta) * acc(:, i - 1) + delta * acc(:, i));
    dep(:, i) = dep(:, i - 1) + dt * vit(:, i - 1) + dt^2 * ((0.5 - alpha) * acc(:, i - 1) + alpha * acc(:, i));
    qs(:, i) = invK * p(:, i);
end
