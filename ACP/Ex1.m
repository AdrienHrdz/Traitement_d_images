clear variables
close all
clc

Y = [ 2 -1 1;
      -1 1 -1;
       3 1 0;
      -2 -4 1;
      -2 3 -1]; % Matrice des données non centree

[n,m] = size(Y);
X = Y - mean(Y); %matrice des donnees centrees
M = X'*X/n; %matrice de covariance
% 5 points donc 5 individus
% 3 composantes donc 3 variables

[P,lambda] = eig(M);
P = flip(P')'; %fliplr ?
lambda = diag(lambda);
lambda = sort(lambda,'descend');

tau1 = lambda(1)/sum(lambda);
tau2 = lambda(2)/sum(lambda);
tau3 = lambda(3)/sum(lambda);

% la matrice P correspond a la matrice de passage lors de la
% diagonalisation, ces colonnes sont les vecteurs propres de X et donc on
% peut en deduire les axes factoriels de la reduction de dimension.

Xstar = X*P

figure(1)
hold on;
plot3(Y(:,1),Y(:,2),Y(:,3), '*b');
plot3(X(:,1),X(:,2),X(:,3), '*r');
grid on
title("Nuage de points")


figure(2)
plot(lambda, '-*k', 'MarkerSize',5)
title("valeurs propres")
grid on

figure(3)
plot(Xstar(:,1),Xstar(:,2),'or','MarkerSize',10 );
axis('equal')
grid on

% d = 0 car le plan est centre
% e3 est un vecteur normal au plan

e3 = P(:,3);
