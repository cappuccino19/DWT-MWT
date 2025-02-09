%% Crop Attack
function cropImageAttacked = cropAttack(watermarked_image)
I=watermarked_image;
siz = size(watermarked_image); 
c = [siz(2)/4 siz(2)/2 siz(2)/4*3]; 
r = [siz(1) siz(1)/4*3 siz(1)]; 
line([c c(1)],[r r(1)],'color','r','LineWidth',4); 
mask = roipoly(watermarked_image,c,r); 
cropImageAttacked=bsxfun(@times, watermarked_image, cast(mask,class(watermarked_image))); 
cropImageAttacked=I-cropImageAttacked;
%cropImageAttacked = imcrop(watermarked_image);
end