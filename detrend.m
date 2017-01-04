    function unew=detrend(u,norder)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% unew=DETREND(u,[norder]) removes trends in u using a polynomial
% of order norder. If u has size u(n,m), DETREND operates on n 
% vectors of length m.  norder is an optional parameter which 
% specifies the order of the polynominal used to determine the 
% least-squares fit to the trend. norder is assumed to be 1 if 
% not included in the input. 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ver. 1: 12/1/96 (RG)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin==1; norder=1;end;
[n,m]=size(u);
flip=0;
if m==1;flip=1;u=u.'; [n,m]=size(u); end;
for i=1:n;
utrend=polyfit2(1:m,u(i,:),norder,1:m);
unew(i,:)=u(i,:)-utrend;
end;

if flip; unew=unew'; end;
