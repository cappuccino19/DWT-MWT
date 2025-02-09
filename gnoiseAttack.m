function noiseImageAttacked = gnoiseAttack(watermarked_image)
noiseImageAttacked = imnoise(watermarked_image, 'gaussian', 0 ,0.01);
end