All code for this project needs to be run in MATLAB.
This project is the experimental code for paper "Robust Triple-Color Watermarking using Elliptical Monogenic Wavelet Transform and Singular Value Decomposition".It includes watermark embedding, extraction, PSNR value calculation, NC value calculation, and various attack related codes
The code for embedding the watermark is 'mwt_test.m'.
The code for extracting watermarks is 'ex_mwt_dct_svd.m'.
When using watermark embedding code, please change the parameter Imau to the link of your own carrier image, and sequentially change the links corresponding to parameters I2, I3, and I4 to the link of the watermark image you want to embed. The generated watermark image will be stored in the link corresponding to rec. Please make the changes yourself. Similarly, when using watermark extraction code, please change the corresponding link to the link of your own image.
Not all save parameters are useful.
