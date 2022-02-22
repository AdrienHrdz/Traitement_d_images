clear variables
close all

% fichiers images
tab_images={'i1.tif','i2.tif','i3.tif','i4.tif','i5.tif','i6.tif'};
m=length(tab_images);

% taille des image
tmp=imread(char(tab_images(1)));
[H,W]=size(tmp);

% matrice de m images
I=zeros(H,W,m);

% affichage des images satellitaires
for k=1:m
    I(:,:,k)=im2double(imread(char(tab_images(k))));
    subplot(2,3,k);
    imshow(I(:,:,k));
end

% matrice des donn?es
% r?-arrangement dans une matrice de n=H*W lignes et 6 colonnes
n=H*W;

im1=imread(char(tab_images(1)));
im2=imread(char(tab_images(2)));
im3=imread(char(tab_images(3)));
im4=imread(char(tab_images(4)));
im5=imread(char(tab_images(5)));
im6=imread(char(tab_images(6)));
im1=im1(:);
im2=im2(:);
im3=im3(:);
im4=im4(:);
im5=im5(:);
im6=im6(:);
%%%Matrice des données%%%
Y = [im1,im2,im3,im4,im5,im6];

%matrice des données centrées
X=double(Y)-ones(n,1)*mean(Y);

%matrice de covariance
M=1/n * X' * X;

%diagonalisation matrice
[V,D]=eig(M);
[lambda,indices] = sort(diag(D),'descend');
P = V(:,indices);

figure()
plot(abs(lambda))

%taux d'inertie
taux=zeros(1,m);
for i=1:m
    taux(i)=100*lambda(i)/sum(lambda);
end

%% Matrice des composantes principales

Xstar=X*P;

figure()

hold on
plot(Xstar(:,1),Xstar(:,2),'r*');
xlabel(['e1 (',num2str(taux(1)),'%)'])
ylabel(['e2 (',num2str(taux(2)),'%)'])
plot([0 0],[-200 200],'k')
plot([-200 400],[0 0],'k')
title('Analyse en composantes principales selon e1 et e2')
hold off

%% Irec

Irec = Xstar(:,1);
Irec = reshape(Irec,[H,W]);
figure()
imshow(Irec,[]);