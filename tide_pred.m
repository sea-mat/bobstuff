  function [up,vp]=tide_pred(t,ell)
% TIDE_PRED predicts tidal currents for time t from TIDE_FIT output
% TIDE_PRED(t,ell) predicts tidal currents for the time t 
% based on the ellipse output from TIDE_ELL. 
%
% [ucoef,unew]=tide_fit(jd,uv,periods,goplot)
%          ell=tide_ell(ucoef,periods)      
%      [up,vp]=tide_pred(t,ell)
%
% where 
%      t = julian day vector to be predicted
%     up(:,n) = predicted u component for periods(n)
%     vp(:,n) = predicted v component for periods(n)

% Neglects mean in prediction. Uses same time origin as TIDE_FIT.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5/20/98:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

periods=ell(:,1);
freq=(2.*pi)*ones(size(periods))./periods; % cph
nfreq=length(freq);

t=t(:);
tt=t*24; % convert to hours from origin
nt=length(tt);

umaj=ell(:,2);
umin=ell(:,3);
deg2rad=pi./180;
inc=deg2rad.*ell(:,4);
phase=deg2rad.*ell(:,5);

up=zeros(nt,nfreq);vp=up;
ur=zeros(nt,1);vr=ur;

for nf=1:nfreq
   ur=umaj(nf).*cos(freq(nf).*tt - phase(nf));
   vr=umin(nf).*sin(freq(nf).*tt - phase(nf));
   up(:,nf)=cos(inc(nf)).*ur - sin(inc(nf)).*vr;
   vp(:,nf)=sin(inc(nf)).*ur + cos(inc(nf)).*vr;
end

% compute and plot sum as check
upsum=(sum(up'))';
vpsum=(sum(vp'))';

plot(t,upsum,t,vpsum,'r')
pause
