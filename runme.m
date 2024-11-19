clc
clear all

% Load the noisy image
image_noisy = imread('lena512noisy.bmp');  % Load the noisy image

% Step 5: Define the wavelet filter for SWT
waveletFilter = 'haar';

%% 16-Band Dyadic Decomposition (4-Level SWT)
[LL, LH, HL, HH] = swt2(image_noisy, 5, waveletFilter);

% Making copies of LH, HL, HH for different cases
% Set only the highest-frequency subband (HH1) to zero
LH_dyadic_1 = LH;
HL_dyadic_1 = HL;
HH_dyadic_1 = HH;
HH_dyadic_1(:,:,1) = 0;  % Zero out HH1

% Set the three highest-frequency subbands (HH1, HL1, LH1) to zero
LH_dyadic_3 = LH;
HL_dyadic_3 = HL;
HH_dyadic_3 = HH;
HH_dyadic_3(:,:,1) = 0;  % Zero HH1
HL_dyadic_3(:,:,1) = 0;  % Zero HL1
LH_dyadic_3(:,:,1) = 0;  % Zero LH1

% Set the six highest-frequency subbands (HH1, HL1, LH1, HH2, HL2, LH2) to zero
LH_dyadic_6 = LH;
HL_dyadic_6 = HL;
HH_dyadic_6 = HH;
HH_dyadic_6(:,:,1:2) = 0;  % Zero HH1 and HH2
HL_dyadic_6(:,:,1:2) = 0;  % Zero HL1 and HL2
LH_dyadic_6(:,:,1:2) = 0;  % Zero LH1 and LH2

% Reconstruct images for each dyadic case
recon_dyadic_1 = iswt2(LL, LH_dyadic_1, HL_dyadic_1, HH_dyadic_1, waveletFilter);
recon_dyadic_3 = iswt2(LL, LH_dyadic_3, HL_dyadic_3, HH_dyadic_3, waveletFilter);
recon_dyadic_6 = iswt2(LL, LH_dyadic_6, HL_dyadic_6, HH_dyadic_6, waveletFilter);

%% 22-Band Modified Pyramid Decomposition
[LL_1, LH_1, HL_1, HH_1] = swt2(image_noisy, 1, waveletFilter);

[LL_LL2, LH_LL2, HL_LL2, HH1_LL2] = swt2(LL_1, 1, waveletFilter);
[LL_LH2, LH_LH2, HL_LH2, HH1_LH2] = swt2(LH_1, 1, waveletFilter);
[LL_HL2, LH_HL2, HL_HL2, HH1_HL2] = swt2(HL_1, 1, waveletFilter);
[LL_HH2, LH_HH2, HL_HH2, HH_HH2] = swt2(HH_1, 1, waveletFilter);

[LL_F, LH_F, HL_F, HH1_F] = swt2(LL_LL2, 2, waveletFilter);


% Set the 3 highest-frequency subbands (HH, HL, LH within HH1) to zero in modified pyramid
LH_mod_3 = LH_HH2;
HL_mod_3 = HL_HH2;
HH_mod_3 = HH_HH2;
LH_mod_3(:,:,1) = 0; 
HL_mod_3(:,:,1) = 0;
HH_mod_3(:,:,1) = 0;

% Set the 10 highest-frequency subbands
% Includes Subbands HH1 and (HH,LH,HL) from LH1 and HL1
LH_mod_10_LH = LH_LH2;
LH_mod_10_HL = HL_LH2;
LH_mod_10_HH = HH1_LH2;
HL_mod_10_LH = LH_HL2;
HL_mod_10_HL = HL_HL2;
HL_mod_10_HH = HH1_HL2;
HH_mod_10 = HH_1;
LH_mod_10_LH(:,:,1) = 0; %LH Subband within LH1
LH_mod_10_HL(:,:,1) = 0; %HL Subband within LH1
LH_mod_10_HH(:,:,1) = 0; %HH Subband within LH1
HL_mod_10_LH(:,:,1) = 0; %LH Subband within HL1
HL_mod_10_HL(:,:,1) = 0; %HL Subband within HL1
HL_mod_10_HH(:,:,1) = 0; %HH Subband within HL1
HH_mod_10(:,:,1) = 0; % Set HH1 to 0


% Set the 15 highest-frequency subbands to zero in modified pyramid case
% Setting HH1,HL1,LH1 and (LH,HL,HH) from LL1
LH_mod_15 = LH_1;
HL_mod_15 = HL_1;
HH_mod_15 = HH_1;
LL_LH__mod15_ = LH_LL2;
LL_HL__mod15_ = HL_LL2;
LL_HH__mod15_ = HH1_LL2;
LH_mod_15(:,:,1) = 0; %Set LH1 to 0
HL_mod_15(:,:,1) = 0; %Set HL1 to 0
HH_mod_15(:,:,1) = 0; %Set HH1 to 0
LL_LH__mod15_(:,:,1) = 0; %Set LH within LL1 to 0
LL_HL__mod15_(:,:,1) = 0; %Set HL within LL1 to 0
LL_HH__mod15_(:,:,1) = 0; %Set HH within LL1 to 0

% Reconstruct images for each modified pyramid case
recon_mod_3_temp = iswt2(LL_HH2, LH_mod_3, HL_mod_3, HH_mod_3, waveletFilter); % Reconstructing HH1
recon_mod_3 = iswt2(LL_1, LH_1, HL_1, recon_mod_3_temp, waveletFilter); %reconstructing the whole image with 3 highest frequencies set to 0.

recon_mod_10_temp_1LH = iswt2(LL_LH2, LH_mod_10_LH, LH_mod_10_HL, LH_mod_10_HH, waveletFilter); %reconstructing LH1
recon_mod_10_temp_2HL = iswt2(LL_HL2, HL_mod_10_LH, HL_mod_10_HL, HL_mod_10_HH, waveletFilter); %reconstructing HL1
recon_mod_10 = iswt2(LL_1, recon_mod_10_temp_1LH, recon_mod_10_temp_2HL, HH_mod_10, waveletFilter); %reconstructing whole image with 10 freq set to 0

recon_mod_15_temp_1 = iswt2(LL_LL2, LL_LH__mod15_, LL_HL__mod15_, LL_HH__mod15_, waveletFilter);%reconstructing LL1
recon_mod_15 = iswt2(recon_mod_15_temp_1, LH_mod_15, HL_mod_15, HH_mod_15, waveletFilter);%reconstructing whole image with 15 highest frequencies set to 0.

%% 1st Window: Original Image and its DFT
figure;
subplot(1,2,1);
imshow(image_noisy, []);  % Display the original noisy image
title('Original Noisy Image');

subplot(1,2,2);
plotDFT(image_noisy, 'DFT - Original Noisy Image');

%% 2nd Window: 16 band Dyadic Case Images and their DFTs
figure;
subplot(3,2,1);
imshow(recon_dyadic_1, []);  % Display reconstructed image for HH1 zeroed case
title('Dyadic: Highest-Frequency(HH1) Zeroed');

subplot(3,2,2);
plotDFT(recon_dyadic_1, 'DFT - Dyadic: Highest-Frequency(HH1) Zeroed');

subplot(3,2,3);
imshow(recon_dyadic_3, []);  % Display reconstructed image for 3 highest-frequencies zeroed
title('Dyadic: 3 Highest-Frequencies Zeroed');

subplot(3,2,4);
plotDFT(recon_dyadic_3, 'DFT - Dyadic: 3 Highest-Frequencies Zeroed');

subplot(3,2,5);
imshow(recon_dyadic_6, []);  % Display reconstructed image for 6 highest-frequencies zeroed
title('Dyadic: 6 Highest-Frequencies Zeroed');

subplot(3,2,6);
plotDFT(recon_dyadic_6, 'DFT - Dyadic: 6 Highest-Frequencies Zeroed');

%% 3rd Window: 22 band Pyramid Case Images and their DFTs
figure;
subplot(3,2,1);
imshow(recon_mod_3, []);  % Display reconstructed image for 3 highest-frequencies zeroed
title('Modified Pyramid: 3 Highest-Frequencies Zeroed');

subplot(3,2,2);
plotDFT(recon_mod_3, 'DFT - Modified Pyramid: 3 Highest-Frequencies Zeroed');

subplot(3,2,3);
imshow(recon_mod_10, []);  % Display reconstructed image for 10 highest-frequencies zeroed
title('Modified Pyramid: 10 Highest-Frequencies Zeroed');

subplot(3,2,4);
plotDFT(recon_mod_10, 'DFT - Modified Pyramid: 10 Highest-Frequencies Zeroed');

subplot(3,2,5);
imshow(recon_mod_15, []);  % Display reconstructed image for 15 highest-frequencies zeroed
title('Modified Pyramid: 15 Highest-Frequencies Zeroed');

subplot(3,2,6);
plotDFT(recon_mod_15, 'DFT - Modified Pyramid: 15 Highest-Frequencies Zeroed');

%% Function to Plot DFT Magnitude Spectrum
function plotDFT(image, titleText)
    dftImage = fftshift(fft2(image));  % Compute 2-D FFT and shift zero frequency to the center
    magnitudeSpectrum = log(abs(dftImage) + 1);  % Log scale for better visibility
    imshow(magnitudeSpectrum, []);  % Display DFT magnitude spectrum
    title(titleText);
end
