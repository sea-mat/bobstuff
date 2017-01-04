function [ucoef,unew]=tide_fit(jd,uu,periods,goplot)
% TIDE_FIT Simple least-squares tidal analysis. 
%
%  [ucoef,unew]=tide_fit(jd,uu,periods,goplot)
%
%  Input:  
%      uu = matrix of time series, one time series in each column
%     jd  = julian day vector  (as in julian.m and gregorian.m) 
% periods = vector of periods to fit (hours) (e.g. [12.42 6.21])  for M2, M4
%  goplot = optional argument, which, if supplied will cause a plot of 
%           the tidal fit to be generated.  (the actual value you supply
%           is arbitrary)
%  Output: 
%   ucoef = the coefficients, starting with mean, then cos(f1), then sin(f1), 
%           up to the number of periods.  Hence there are 2f+1 coefficients.
%           To get amplitude and phase, use TIDE_ELL.
%   unew =  time series of predicted tide 
%
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Version 1.0 (11/24/1997)   Rich Signell (rsignell@usgs.gov) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if no periods are supplied, just do m2, m4 and m6
if nargin<3; periods=[12.42 6.21 4.14]; end    %M2, M4, M6  


[m,n]=size(uu);

freq=(2.*pi)*ones(size(periods))./periods;
nfreq=length(freq);

tt=jd*24;
nt=length(tt);
nfreq=length(freq);

for nn=1:n
fprintf('Series %4.0f. Hit <Return> to continue\n',nn);
   u=uu(:,nn);
   t=tt;
   ind=find(~isnan(u));
   nind=length(ind);

   if nind>nfreq*2+1
      u=u(ind);
      t=t(ind);
      u=u(:);
      t=t(:);
%------ set up A -------
       A=zeros(nind,nfreq*2+1); 
       A(:,1)=ones(nind,1);
       for j=[1:nfreq]
           A(:,2*j)=cos(freq(j)*t);
           A(:,2*j+1)=sin(freq(j)*t);
       end
%-------solve [A coeff = u] -----------------
       coef=A\u;
%-------generate solution components-----
       up=zeros(nt,nfreq*2+1);
       up(:,1)=coef(1)*ones(nt,1);
       for j=[1:nfreq]
          up(:,j+1)=coef(j*2)*cos(freq(j)*t)+coef(j*2+1)*sin(freq(j)*t);
       end
       up(:,nfreq+2)=sum(up(:,[1:nfreq+1])')';  % sum of all comps
       unew(:,nn)=up(:,nfreq+2);
		 ucoef(:,nn)=coef;
		 error=std(A*coef-u)/sqrt(nind-length(periods)*2+1);
       if exist('goplot')
          jdp=(t-t(1))/24;
        h=plot(jdp,[u unew(:,nn)],jdp,zeros(size(jdp)),'k'); 
        hold on
        plot(jdp,u,'x',jdp,unew(:,nn),'o');
        hold off
        legend('data','tide fit')
          title(sprintf...
            ('Least Squares Fit, series %g   error= %5.2g',nn,error));
          xlabel('Days from start of record');
          pause
       end
else
       unew(:,nn)=ones(t)*nan;
		 ucoef(:,nn)=ones(2*nfreq+1,1)*nan;
end   % if nind> ....
end	%  loop
