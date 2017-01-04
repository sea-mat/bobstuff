 function   [a,theta]=veccor1(u1,v1,u2,v2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [a,theta]=VECCOR1(u1,v1,u2,v2) computes the complex vector correlation
% coefficient following Kundu (1976), JPO, 6, 238-242. Input are the 
% four time series vectors. Output is complex, with amplitude and 
% rotation angle in degrees. A positive angle indicates that series 1
% is rotated positively (counterclockwise) from series 2.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ver. 1: 12/1/96 (RB)
% ver. 2:  allow for complex arguments, remove mean
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% make input column vectors
if(nargin==2),
  X=u1(:);
  Y=v1(:);
else
  X=u1(:)+i*v1;
  Y=u2(:)+i*v2;
end

% work on only the common good points
ii=find((finite(X+Y)));
% if no common good points, return NaNs
if(length(ii)<1),amp=NaN;theta=NaN;trans=NaN;return;end
X=X(ii); Y=Y(ii);

% remove mean
X=X-mean(X(:)); Y=Y-mean(Y(:));

% compute a, theta
c=(rot90(X)*conj(Y))./(sqrt(rot90(X)*conj(X))*sqrt(rot90(Y)*conj(Y)));
a=abs(c);
theta=180.*angle(c)./pi;

