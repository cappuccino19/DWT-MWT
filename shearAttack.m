%% Affine transformation
function shearImageAttacked = shearAttack(watermarked_image)
% Apply a horizontal shear to an intensity image
tformImage = maketform('affine', [1 0 0; 0.05 1 0; 0 0 1]);
shearImageAttacked = imtransform(watermarked_image, tformImage);
end