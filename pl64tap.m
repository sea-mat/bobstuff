   function xf=pl64tap(x);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% xf=PL64TAP(x) low-pass filters the hourly time series x using 
% the PL64 filter described on p. 21, Rosenfeld (1983), WHOI 
% Technical Report 85-35. Filter half amplitude period = 33 hrs.,
% half power period = 38 hrs. The time series x is folded over 
% and cosine tapered at each end to return a filtered time series 
% xf of the same length.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ver. 1: 3/2/95 (SL)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[npts,ncol]=size(x);

if (npts>126) 

%generate filter weights
j=1:63;
t=pi.*j;
den=0.0009.*t.^3;
wts=(2.*sin(0.06.*t)-sin(0.03.*t)-sin(0.09.*t))./den;
% make symmetric filter weights
% coefficient is to match fortran version of outputs
wts=0.999531323.*[wts(63:-1:1),0.05997,wts];

%fold tapered time series on each end
cs=cos(t'./126);
jm=[63:-1:1];

% demean x
xmean=x;
for nc=1:ncol;
  x(:,nc)=x(:,nc)-xmean(nc);
end
% detrend 
xin=x;
xt=zeros(npts,ncol);
for nc=1:ncol;
  x(:,nc)=detrend(xin(:,nc));
  xt(:,nc)=xin(:,nc)-x(:,nc);
end

for ic=1:ncol
['column #',num2str(ic)]

 y=[cs(jm).*x(jm,ic);x(:,ic);cs(j).*x(npts+1-j,ic)];

% filter
 yf=filter(wts,1.0,y);

% strip off extra points
 xf(:,ic)=yf(127:npts+126);
 end

% add mean and trend
for nc=1:ncol;
xf(:,nc)=xf(:,nc)+xt(:,nc)+xmean(nc);
end

else
'warning less than 127 points'

end
end


