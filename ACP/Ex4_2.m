clear variables
close all
clc

%% Partie II
I1 = im2double(imread('i1.tif'));
I2 = im2double(imread('i2.tif'));
I3 = im2double(imread('i3.tif'));
I4 = im2double(imread('i4.tif'));
I5 = im2double(imread('i5.tif'));
I6 = im2double(imread('i6.tif'));
figure(1)
subplot(2,3,1);imshow(I1);title('I1')
subplot(2,3,2);imshow(I2);title('I2')
subplot(2,3,3);imshow(I3);title('I3')
subplot(2,3,4);imshow(I4);title('I4')
subplot(2,3,5);imshow(I5);title('I5')
subplot(2,3,6);imshow(I6);title('I6')

[H,W] = size(I1);
Y = [ I1(:), I2(:), I3(:), I4(:), I5(:), I6(:)];
[n,m] = size(Y);
X = Y - mean(Y);
M = 1/n * (X') * X;
%diagonalisation
[V,D] = eig(M);
[lambda,indices] = sort(diag(D),'descend');
P = V(:,indices);
tau = lambda/sum(lambda);
Xstar = X*P;
%reconstruction
Irec = reshape(Xstar(:,1),[H,W]);
% normalisation
Irec = (Irec - min(min(Irec)))/(max(max(Irec)) - min(min(Irec))); 


tau_cumul = zeros(size(tau));
for k = 1:length(tau_cumul)
    tau_cumul(k) = sum(tau(1:k));
end

figure(2);
subplot(1,2,1)
plot(lambda,'-*');
grid on;
subplot(1,2,2)
plot(tau_cumul,'-*');
grid on;


figure(3);
imshow(Irec);
title('image reconstruite')

%reconstruction
Irec = reshape(Xstar(:,2),[H,W]);
Irec = (Irec - min(min(Irec)))/(max(max(Irec)) - min(min(Irec))); 
figure(4);
imshow(Irec);
title('image reconstruite 2e axe factoriel')

Irec = reshape(Xstar(:,3),[H,W]);
Irec = (Irec - min(min(Irec)))/(max(max(Irec)) - min(min(Irec))); 
figure(5);
imshow(Irec);
title('image reconstruite 3e axe factoriel')




