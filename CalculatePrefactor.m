 
% INPUT
L1 = 1e7;
L2 = 1e7;
rmin=300;
m=importdata('ResHist.mumm');
 
% ANALYSIS
r=m(:,1);
m=m(:,2);
 
% BINNING
% We first bin the data logarithmically.
% Borders of the bins:
rV=10.^((log10(rmin)-0.0001):0.05:(log10(max(r))+0.0001));
% Center of each bin at the log scale:
rL=(rV(2:end).*rV(1:(end-1))).^0.5;
 
mL=rL*0;
% For each bin, sum up the frequencies
% of match lengths that belong in that bin:
for j=1:(length(rV)-1),
    Ind2=find((r>=rV(j)).*(r<=rV(j+1)));
    mL(j)=sum(m(Ind2));
end;
 
% CALCULATE BINNED MLD,
% taking into account the width of each bin:
mL=mL./diff(rV)/(L1*L2);
 
% SELECT RANGE
% Select the range of consecutive bins with non-zero frequencies:
Ind3=find(mL<=0);Ind3=1:(min([Ind3 length(mL)+1])-1);  
rL=rL(Ind3); mL=mL(Ind3);
 
% CALCULATE PREFACTOR
% To fit the power law,
% we perform a least-squares linear regression in log-log scale
% with a fixed regression coefficient of -3 (the exponent of the power law).
% The analytical expression for the intercept translates to:
% intercept = mean(log(mL)+3*log(rL));
% Hence:
AT=exp(mean(log(mL)+3*log(rL)));

