  function xnew=boxfilt(x,n,nanend)

% BOXFILT Running box-car filter.
%
% new=BOXFILT(x,n,nanend) applies a running box-car filter of 
% length n to the time series x. The time base is maintained, 
% and points at the beginning and end are returned as their 
% original values (or with NaNs if nanend==1).
%    Input: 
%     x   = time series data vector
%     n   = length of boxcar filter
% nanend  = 1 to pad ends with NaN, 0 to leave data with original values
%
%   Output:
%  xnew   = barcar filtered data with same time base as x

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ver. 1: 12/1/96 (RG)
% ver. 1.1: 10/2/97 (Rich Signell rsignell@usgs.gov): fixed up
%   the documentation and updated the "ones" command. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin==2; nanend=0; end
lg=length(x(:));
filt=ones(size(1:n))/n;
xnew=conv(x(:),filt);
nbeg=ceil((n+1)/2);
xnew=xnew(nbeg:nbeg-1+lg);
if nanend
 xnew(1:nbeg-1)=x(1:nbeg-1)*nan;
 xnew(lg-nbeg+2:lg)=x(lg-nbeg+2:lg)*nan;
else
 xnew(1:nbeg-1)=x(1:nbeg-1);
 xnew(lg-nbeg+2:lg)=x(lg-nbeg+2:lg);
end
[imax,jmax]=size(x);
if (imax>1)&(jmax>1)
   xnew=remat(xnew,x);
   for i=0:floor(n/2)-1;
      xnew(1+i,:)=x(1+i,:);
      xnew(imax-i,:)=x(imax-i,:);
   end
elseif size(xnew)~=size(x)
     xnew=xnew';
end
