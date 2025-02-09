%% Mean Attack
function meanImageAttacked = meanAttack(I)
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);
R=filter2(fspecial('average',3),R);
G=filter2(fspecial('average',3),G);
B=filter2(fspecial('average',3),B);
meanImageAttacked= cat(3,R,G,B);
end