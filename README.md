Wavelet Image Denoising using 2-D Stationary Wavelet Transform (SWT) 
===

Project Overview
---

This project implements image denoising on a noisy image using 2-D Stationary Wavelet Transform (SWT). The denoising process uses two schemes: a 16-band dyadic decomposition and a 22-band modified pyramid decomposition. These decompositions help suppress noise by zeroing high-frequency subbands and reconstructing a cleaner image. The results include both the reconstructed images and their 2-D DFT magnitude spectra for quality analysis.


Features
---
16-Band Dyadic Decomposition: Decomposes the image into 16 subbands, applying SWT for noise reduction by zeroing high-frequency subbands.
22-Band Modified Pyramid Decomposition: The image is first divided into equal 16 sized subbbands and then the LL subband is decomposed twice to get the 22 band modified pyramid.
Reconstruction and Quality Assessment: Each reconstructed image is analyzed visually and by examining the 2-D DFT magnitude spectrum.

Requirements
---
MATLAB 2022b (or later recommended)

Usage
---
Running the Denoising Script: runme.m
To perform the denoising steps on the noisy image (lena512noisy.bmp), run: runme.m from MATLAB

This script performs the following:
---

Loads the noisy image.

Applies the 16-band dyadic and 22-band modified pyramid decompositions.

Sets specified high-frequency subbands to zero.

Reconstructs the image and plots the 2-D DFT magnitude spectrum.

Parameters to Customize

Decomposition Level: Adjust the number of decomposition levels for both schemes.

Subbands to Zero:

Dyadic Decomposition: Options to zero the highest, three highest, or six highest frequency subbands.

Modified Pyramid Decomposition: Options to zero the three, 10, or 15 highest frequency subbands.

Example Output: Attached as Jpgs

Analysis
---
Perceived Quality: The reconstructed images are evaluated visually to assess denoising performance.
Frequency Spectrum: The 2-D DFT magnitude spectrum shows the frequency components in each reconstructed image, indicating the suppression of noise and preservation of essential image features.
Contributing
Contributions are welcome! Feel free to open issues or submit pull requests to enhance the denoising techniques or add new decomposition schemes.

License
---
This project is licensed under the MIT License - see the LICENSE file for details.
