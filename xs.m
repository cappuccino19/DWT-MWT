clear;
rec=imread('D:\wuan\code\DWT-MWT1\xs.png');
rec1=noiseAttack(rec);
rec2=gnoiseAttack(rec);
rec3=medianAttack(rec);
imwrite(rec,'D:\wuan\code\xs\JPEGA.jpg','quality',10);
rec5=meanAttack(rec);
rec6=sprotAttack(rec);
imwrite(rec1,'D:\wuan\code\xs\nA.bmp','bmp');
imwrite(rec2,'D:\wuan\code\xs\GA.bmp','bmp');
imwrite(rec3,'D:\wuan\code\xs\MA.bmp','bmp');
imwrite(rec5,'D:\wuan\code\xs\meanA.bmp','bmp');
imwrite(rec6,'D:\wuan\code\xs\SA.bmp','bmp');
