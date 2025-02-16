The code about "Robust Triple-Color Watermarking using Elliptical Monogenic Wavelet Transform and Singular Value Decomposition" .
All code for this project needs to be run in MATLAB.
This project is the experimental code for paper "Treble-color watermarking based on elliptical monogenic wavelet transform".It can separate the phase, amplitude, and linear representation of the image through EMWT, and embed the watermark image into these three parameters of the carrier image through SVD and DCT.
This project includes watermark embedding and extraction related code, attack testing related code, and code for calculating PSNR and NC.
The code for embedding the watermark is 'mwt_test.m'.
The code for extracting watermarks is 'ex_mwt_dct_svd.m'.
When using watermark embedding code,please replace the source directory of the image parameters‘Imau’ with the directory where your own host images are located. And sequentially change the links corresponding to parameters ‘I2’, ‘I3’, and ‘I4’ to the link of the watermark image you want to embed. The generated watermark image will be stored in the dictionary corresponding to ‘rec’.
Similarly, when using watermark extraction code, please change the source of watermark image parameters ‘rec’ ， as well as the storage directory of the extracted watermark image.The parameters involved are WaterMarked1, WaterMarked2, and WaterMarked3.
If the generated watermarked image has poor performance, please change the embedding parameters of singular value decomposition in the watermark embedding code and also change the extraction parameters in the watermark extraction code. They have a significant impact on the embedding and extraction effect of the watermark. Note: Using different images may result in inconsistent output data with the test data in this experiment.
Not all parameters are useful, some of them arise during the code testing process and have no impact on the running results.
