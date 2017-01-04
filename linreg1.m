  function linreg1(x,y,stdx,stdy,b0)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LINREG1(x,y,stdx,stdy,b0) solves directly for the coefficients in
% the linear model 
%          y = a + b*x
% for the case when both x and y are considered independent random 
% variables with zero-mean noise characterized by stdx and stdy, 
% which are independent of specific observations. Inputs are:
% the data xi,yi; the assumed known stdx, stdy; and the initial 
% guess of the slope b0. Code solves nonlinear problem exactly for 
% the slope b which minimizes the merit function
%         S = sum((yi-a-b*xi).^2/(stdy^2 + b^2*stdx^2))
% which represents the sum of the distances normal to the least
% squares line. Then a is determined from a=ym-b*xm. Approximate 
% 95% confidence intervals given for a,b.  NOTE 1: solution reduces 
% to linear regression result (from LINREG) when the ratio of 
% stdx/stdy gets very small or very large.  NOTE 2: for the case 
% of very small stdx, then substitution of stdydata for stdy 
% gives ci's for a in close agreement with LINREG.  NOTE 3: code 
% uses FZERO to find value of b near b0. If b0 is poor quess, 
% then b may be a poor solution. Check using plot of results 
% and experimentation with diffeent b0 that b given is robust.
% (See LINREG for usual case of regressing y on x, when x has 
% no measurement error.)
%
% Solution approach follows Reed (1992), Am. J. Phys., 60, 59-62, 
% and Reed (1989), Am. J. Phys., 57, 642-646, who corrected earlier 
% formulas given by York (1966), Can. J. Phys., 44, 1079-1086.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ver 1.0: 11/25/96 (RB)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N=length(x);
x=x(:);
y=y(:);

% compute coefficients
vary=stdy^2;
varx=stdx^2;
r2=vary/varx;
xm=mean(x);
ym=mean(y);
U=x-xm;
V=y-ym;
UU=U'*U;
VV=V'*V;
UV=U'*V;

% solve for b, a
global B C
B=(r2*UU-VV)./UV;
C=-r2;
b=fzero('quadrat',b0,0.00001); 
a=ym-b*xm;
cc=corrcoef(x,y);

% compute yp, xp, Rs, S
yp=a+b*x;
r=yp-y;
xp=(y-a)./b;
b2=b^2;
varydata=(std(yp-y))^2;
varxdata=(std(xp-x))^2;
r2data=varydata/varxdata;
S=((V-b*U)'*(V-b*U))/(vary + b2*varx);

% compute confidence intervals for a,b
A=UV;
B=r2*UU-VV;
C=-r2*UV;
SD=(S/(N-2))/(2*A*b+B)^2;
b2r2=(b2-r2);
br2=b*r2;

% start with b
am=(b2r2)^2;
bm=(2*br2)^2;
cm=4*br2*b2r2;
varbx=varx*(am*VV+bm*UU+cm*UV);
am=4*b2;
bm=(b2r2)^2;
cm=(-4*b*b2r2);
varby=vary*(am*VV+bm*UU+cm*UV);
varb=SD*(varbx+varby);
stdb=sqrt(varb);

% now do a
XD=xm^2/(2*A*b+B)^2;
am=(2*br2)^2;
bm=b2r2^2;
cm=4*br2*b2r2;
varax=b2/N+XD*(am*UU+bm*VV+cm*UV);
am=(2*b)^2;
cm=(4*b)*b2r2;
varay=1/N+XD*(bm*UU+am*VV-cm*UV);
vara=varx*varax+vary*varay;
stda=sqrt(vara);

% now compute 95% ci's
st=tinv(0.975,N-2);
aerr=st*stda;
berr=st*stdb;

% disp results
disp(['mean x = ',num2str(xm),';  mean y = ',num2str(ym)])
disp(['std(y-a-bx) = ',num2str(std(y-a-b*x)),';  N = ',int2str(N)])
disp(['a   aerr  = ',num2str(a),'  +-  ',num2str(aerr)])
disp(['b   berr  = ',num2str(b),'  +-  ',num2str(berr)])
disp(['corr coef = ',num2str(cc(1,2))])
disp(['(corr coef)^2 = ',num2str(cc(1,2)^2)])
disp(['stdx = ',num2str(stdx),';  stdxdata = ',num2str(sqrt(varxdata))])
disp(['stdy = ',num2str(stdy),';  stdydata = ',num2str(sqrt(varydata))])
disp(['vary/varx = ',num2str(r2),'; varydata/varxdata = ',num2str(r2data)])

xr=[min(x) max(x)];
yp=a+b*xr;
ypu=a+aerr + (b+berr)*xr;
ypl=a-aerr + (b-berr).*xr;
plot(x,y,'o',xr,yp,'g-',xr,ypu,'r:',xr,ypl,'r:')
xlabel('X')
ylabel('Y')
title(['Least-squares nonlinear fit of Y on X with maximum 95% CIs for stdy/stdx = ',num2str(sqrt(r2))])
end

