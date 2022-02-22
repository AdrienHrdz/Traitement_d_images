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
[V,D] = eig(M)
[lambda,indices] = sort(diag(D),'descend')
P = V(:,indices)
tau = lambda/sum(lambda);
Xstar = X*P;

% reconstruction
Xstar2 = [Xstar(:,1), zeros(n,2)];
Xrec = Xstar2 * inv(P);
Irec = reshape(Xstar2(:,1),[H,W]);


tau_cumul = zeros(size(tau));
for k = 1:length(tau_cumul)
    tau_cumul(k) = sum(tau(1:k));
end

% figure(2);
% subplot(1,2,1)
% plot(lambda,'-*');
% grid on;
% subplot(1,2,2)
% plot(tau_cumul,'-*');
% grid on;

figure(3);
subplot(1,2,1)
imshow(Irec);
subplot(1,2,2)
imshow(Irec,[]);






