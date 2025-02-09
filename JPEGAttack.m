function JPEGC= JPEGAttack(I)
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);
R=JPEGCompress(R);
G=JPEGCompress(G);
B=JPEGCompress(B);
JPEGC=cat(3,R,G,B);
end