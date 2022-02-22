clear variable;
clear all;
close all
clc

%% initialisation
epsilon = 1;
phi = 0;
%choix des param
cas = input("Choix des paramètres initiaux : ");
switch cas
    case 1
        epsilon = 1;
        phi = 0;
    case 2
        epsilon = 1;
        phi = pi/2;
    case 3
        epsilon = 1;
        phi = pi;
    case 4
        epsilon = -1;
        phi = 0;
    case 5
        epsilon = -1;
        phi = pi/2;
    case 6
        epsilon = -1;
        phi = pi;
end
t = 0 : 0.05 : 2*pi;
delta1 = 0.2*rand(size(t));
delta2 = 0.2*rand(size(t));
s1 = sin(t) + delta1;
s2 = epsilon*sin(t+phi) + delta2;

%% affichage des signaux
figure(1)
subplot(1,2,1)
hold on;
plot(t,s1,'b')
plot(t,s2,'r')
grid on
legend('s1','s2')
subplot(1,2,2)
plot(s1,s2,'om','MarkerSize',4)
grid on
axis equal

%% ACP sur le nuage (s1,s2)
Y = [s1' s2'];
X = Y - mean(Y);
[n,m] = size(X);
M = 1/n * X'*X;
% Diagonalisation
[P,lambda] = eig(M);
%P = flip(P')'; %fliplr ?
P = fliplr(P);
lambda = diag(lambda);
lambda = sort(lambda,'descend');
tau = lambda/sum(lambda);
Xstar = X*P;
% affichage axe factoriel
figure(2)
plot(Xstar(:,1),Xstar(:,2),'*r')
grid on;
axis("equal")
xlabel(['e1 (',num2str(100*tau(1)),')'])
ylabel(['e2 (',num2str(100*tau(2)),')'])
% cercle de correlation
S = ones(1,n)' * std(X);
Z = X./S;
figure(3);% On réduit les données initiales (cours p.36)
hold on;
rho = zeros(n,m);
for j = 1:m
    rho1 = Z(:,j)'*Xstar(:,1)/(n*sqrt(lambda(1)));
    rho2 = Z(:,j)'*Xstar(:,2)/(n*sqrt(lambda(2)));
    plot(rho1,rho2, 'o');    
end
theta = 0:0.01:2*pi;
plot(cos(theta), sin(theta),'k');
axis('equal')
grid on;

%% Reconstruction des signaux
Xstar2 = [Xstar(:,1), zeros(n,1)];
Xrec = Xstar2 * inv(P);
figure(4)
subplot(1,2,1)
subtitle('s1')
hold on;grid on;
plot(t,Xrec(:,1),'b');
plot(t,s1,'--b');
legend('reconstruction','estimation')

subplot(1,2,2)
subtitle('s2')
hold on;grid on;
plot(t,Xrec(:,2),'r');
plot(t,s2,'--r');
legend('reconstruction','estimation')

variables = {"\epsilon = "+num2str(epsilon),"\phi = "+num2str(phi)};
text(1.1*max(t),0,variables)

%% Partie 20 signaux
% chargement des signaux
load Ex3_signaux;
Y=D;
[n,m]=size(Y); % n=768 abscisses, m=20 signaux
% affichage des 20 signaux
figure(5);
for i=1:m
    subplot(m,1,i);
    title('Signaux originaux','interpreter','latex');
    plot(Y(:,i));
    axis off;
end
X = Y - mean(Y);
[n,m] = size(X);
M = 1/n * X'*X;
% Diagonalisation
[P,lambda] = eig(M);
P = flip(P')'; %fliplr ?
lambda = diag(lambda);
lambda = sort(lambda,'descend');
tau = lambda/sum(lambda);
tau_cumul = zeros(size(tau));
for k = 1:length(tau_cumul)
    tau_cumul(k) = sum(tau(1:k));
end
Xstar = X*P;
figure(6);
subplot(1,2,1)
plot(lambda,'-*');
grid on;
subplot(1,2,2)
plot(tau_cumul,'-*');
grid on;