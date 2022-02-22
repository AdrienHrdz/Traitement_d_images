clear variable;
close all
clc

% charge les donnees
Ex2_data

X = data - mean(data);
[n,m] = size(X);
S = ones(1,n)' * std(data);
Z = X./S;

M = 1/n * X'*X;
%Diagonalisation
[P,lambda] = eig(M);
P = flip(P')'; %fliplr ?
lambda = diag(lambda);
lambda = sort(lambda,'descend');

tau = lambda/sum(lambda);
figure(1)
stem(tau);
grid on
axis( [ -1 length(tau)+1 0 max(tau) ] )

Xstar = X*P
figure(2)
plot(Xstar(:,1),Xstar(:,2),'or','MarkerSize',3)
grid on;
axis("equal")

figure(3)
subplot(2,2,1)
plot(Xstar(:,1),Xstar(:,2),'or','MarkerSize',3)
grid on;
axis("equal")
xlabel(['e1 (',num2str(round(100*tau(1))),')'])
ylabel(['e2 (',num2str(round(100*tau(2))),')'])
subplot(2,2,2)
plot(Xstar(:,1),Xstar(:,3),'or','MarkerSize',3)
grid on;
axis("equal")
xlabel(['e1 (',num2str(round(100*tau(1))),')'])
ylabel(['e3 (',num2str(round(100*tau(3))),')'])
subplot(2,2,3)
plot(Xstar(:,3),Xstar(:,4),'or','MarkerSize',3)
grid on;
axis("equal")
xlabel(['e3 (',num2str(round(100*tau(3))),')'])
ylabel(['e4 (',num2str(round(100*tau(4))),')'])
subplot(2,2,4)
plot(Xstar(:,7),Xstar(:,8),'or','MarkerSize',3)
grid on;
axis("equal")
xlabel(['e7 (',num2str(round(100*tau(7))),')'])
ylabel(['e8 (',num2str(round(100*tau(8))),')'])
% on peut voir que pour les premiers axes factiriels la dispersion est
% maximale, alors que des axes dont le taux d'inertie expliqué est plus
% faible on peut constater un manque de dispersion. Cela traduit donc d'une
% perte d'information.


