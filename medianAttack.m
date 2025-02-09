%% Median Attack
function medianImageAttacked = medianAttack(I)
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);
 
R=medfilt2(R,[3,3]);
G=medfilt2(G,[3,3]);
B=medfilt2(B,[3,3]);
 
medianImageAttacked=cat(3,R,G,B);
end