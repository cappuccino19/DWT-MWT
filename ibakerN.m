function X = ibakerN(X, nii, N)
for k=1:N
    X=ibakertf(X,nii);
end
function Xb=ibakertf(X,nii)
% baker mapping
[R,S]=size(X);
N=R;
Xb=zeros(R,S);
Ni=0;
ni=nii(1);
for r=0:R-1
    if r>Ni+nii(1)-0.5
        Ni=Ni+nii(1);
        nii(1)=[];
        ni=nii(1);        
    end
    for s=0:S-1     
        rp=N/ni*(r-Ni)+mod(s,N/ni)+1;
        sp=ni/N*(s-mod(s,N/ni))+Ni+1;
        Xb(r+1,s+1)=X(rp,sp);
    end
end