clear variables
close all
clc

%% Partie I
I = imread('ballon.tif');
I = im2double(I);
figure(1);
imshow(I)
[H,W,~] = size(I);
I_r = I(:,:,1);
I_g = I(:,:,2);
I_b = I(:,:,3);

Y = [ I_r(:), I_g(:), I_b(:)];
[n,m] = size(Y);
X = Y - mean(Y);
M = 1/n * (X') * X;
% diagonalisation
[V,D] = eig(M);
[lambda,indices] = sort(diag(D),'descend');
P = V(:,indices);
tau = lambda/sum(lambda);
Xstar = X*P;

% reconstruction
Xstar2 = [Xstar(:,1), zeros(n,m-1)];
Irec = reshape(Xstar2(:,1),[H,W]);
Irec = (Irec - min(min(Irec)))/(max(max(Irec)) - min(min(Irec))); %Normalisation

diff = rgb2gray(I) - Irec;

tau_cumul = zeros(size(tau));
for k = 1:length(tau_cumul)
    tau_cumul(k) = sum(tau(1:k));
end

figure(2);
subplot(1,2,1)
plot(lambda,'-*');title('valeurs propres');
grid on;
xlabel('k')
subplot(1,2,2)
plot(tau_cumul,'-*');title("Taux d'inertie expliqués pour chaque axe factoriels")
grid on;
xlabel('k')

figure(3);
subplot(1,3,1)
imshow(rgb2gray(I));
title('Image originale')
subplot(1,3,2)
imshow(Irec);
title('Reconstruction à partir du 1er axe')
subplot(1,3,3)
imshow(diff,[]),colorbar
title('Différence')

figure(4);
subplot(1,2,1)
imshow(rgb2gray(I));
title('Image originale')
subplot(1,2,2)
imshow(Irec);
title('Reconstruction à partir du 1er axe')


%% pour aller plus loin
% reconstruction
Xstar3 = [Xstar(:,2), zeros(n,m-1)];
Irec2 = reshape(Xstar3(:,1),[H,W]);
Irec2 = (Irec2 - min(min(Irec2)))/(max(max(Irec2)) - min(min(Irec2))); %Normalisation

Xstar4 = [Xstar(:,3), zeros(n,m-1)];
Irec3 = reshape(Xstar4(:,1),[H,W]);
Irec3 = (Irec3 - min(min(Irec3)))/(max(max(Irec3)) - min(min(Irec3))); %Normalisation


figure(5)
subplot(1,2,1)
imshow(Irec2);
title('Reconstruction à partir du 2e axe')
subplot(1,2,2)
imshow(Irec3);
title('Reconstruction à partir du 3e axe')






