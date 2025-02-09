function v=ncc_f(a,b)
if size(a,3)>1.5 |size(b,3)>1.5;
    error('a and b must be a matrix.');
end
a=abs(a);
b=abs(b);
Ea=mean2(a);
Eb=mean2(b);
Da=mean2([a-Ea].^2);
Db=mean2([b-Eb].^2);
cov1=mean2([a-Ea].*[b-Eb]);
v=abs(cov1)/sqrt(Da*Db);