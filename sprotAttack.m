function sportImageAttacked = sprotAttack(watermarked_image)
len=1;
theta=1;
psf=fspecial('motion',len,theta);
sportImageAttacked=imfilter(watermarked_image,psf,'conv','circular');
end