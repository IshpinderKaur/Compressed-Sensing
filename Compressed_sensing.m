% Initialize constants and variables
rng(0);              % set RNG seed
N = 512;             % length of signal
P = 20;              % number of non-zero peaks
M = 120;             % number of measurements to take (N < L)
X = zeros(N,1);      % original signal (P-sparse)

% Generate signal with P randomly spread values
peaks = randperm(N);
% setting the nonzero values to be randomly 1 or -1
X(peaks(1:P)) = sign(randn(1, P));
amp = 1.5*max(abs(X));
figure; subplot(4,1,1); plot(X); title('Original signal'); axis([0 N -amp amp]);
% Obtain M measurements or compressed values
A = randn(M, N);
Y = A*X;
subplot(4,1,2); plot(1:M,Y); title('Compressed values');

% Perform Compressed Sensing recovery
X0 = A.'*Y;
Xp = l1eq_pd(X0, A, [], Y);
subplot(4,1,3); plot(real(Xp)); title('Recovered signal'); axis([0 N -amp amp]);

% Correlation factor
Correlation = corrcoef(X,Xp);
fprintf('The correlation between original and reconstructed signal is:');
display(Correlation);

% The signal and reconstruction overlap
subplot(4,1,4); plot(1:N,X, 1:N,real(Xp)); title('The Original and Reconstructed Signal overlap');
legend('Truth','Recovery'); axis([0 550 -amp amp]);

% References:
% https://www.codeproject.com/Articles/852910/Compressed-Sensing-Intro-Tutorial-w-Matlab