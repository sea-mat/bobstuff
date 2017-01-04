   function linreg(x,y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LINREG(x,y) computes linear regression of y on x, i.e.,  
%                    y = a + b*x
% and returns coefficients a and b with 95% uncertainity. 
% Assumes x,y vectors have no NaN elements, and that x includes
% no measurement error. Uses TINV to estimate student-t value 
% for confidence limits.  See NLINREG when both x and y are 
% considered as random variabiles.
%
% Ref: Draper and Smith, Applied Regression Analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ver 1.0: 11/25/96 (RB)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% convert to row vectors
[N,M]=size(x);
if M==1
  x=x';y=y';
end

% 95% confidence limit student-t distribution
L=length(x);
P=.95;
p=.5.*(1 + P);
st=tinv(p,N-2);

mx=mean(x);
my=mean(y);
dx=x-mx;
dy=y-my;
reg=sum(dx.*dy)./sum(dx.^2);
b=sum(dx.*y)./sum(dx.^2);
a=my-b.*mx;
syx=(sum(dy.^2)-(sum(dx.*dy)^2)./sum(dx.^2))./(N-2);
syx=sqrt(syx);
aerr=st.*syx.*sqrt(((mx.^2)./sum(dx.^2)+1./N));
berr=st.*syx./sqrt(sum(dx.^2));
corr=corrcoef(x,y);
stdy=std(y-a-b*x);
A=[a aerr b berr corr(1,2)];
disp(['mean x = ',num2str(mx),';   mean y = ',num2str(my)])
disp(['std(y-a-bx) = ',num2str(stdy),';   N = ',int2str(N)])
disp(['a   aerr  = ',num2str(a),'  +-  ',num2str(aerr)])
disp(['b   berr  = ',num2str(b),'  +-  ',num2str(berr)])
disp(['corr coef = ',num2str(corr(1,2))])
disp(['(corr coef)^2 = ',num2str(corr(1,2)^2)])

xr=[min(x) max(x)];
yp=a+b*xr;
ypu=a+aerr + (b+berr)*xr;
ypl=a-aerr + (b-berr).*xr;
plot(x,y,'o',xr,yp,xr,ypu,'r:',xr,ypl,'r:')
xlabel('X')
ylabel('Y')
title('Least-squares fit of Y on X with maximum 95% CIs')
end

