L1 = 1e7;
L2 = 1e7;
m=importdata('ResHist.mumm'); 
r=m(:,1);
m=m(:,2);
rmin=300;
rV=10.^((log10(rmin)-0.0001):0.05:(log10(max(r))+0.0001)); 
rL=(rV(2:end).*rV(1:(end-1))).^0.5;
mL=rL*0;
for j=1:(length(rV)-1),
    Ind2=find((rT>=rV(j)).*(rT<=rV(j+1)));
    mL(j)=sum(m(Ind2));
end;
mL=mL./diff(rV)/(L1*L2);
Ind3=find(mL<=0);Ind3=1:(min([Ind3 length(mL)+1])-1);   
rL=rL(Ind3); mL=mL(Ind3);
AT=exp(mean(log(mL)+3*log(rL)));

