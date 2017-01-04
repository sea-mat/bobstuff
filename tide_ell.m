  function ell=tide_ell(ucoef,periods)
% TIDE_ELL calculates tidal ellipse parameters from TIDE_FIT output.
% TIDE_ELL(ucoef,periods) computes the tidal ellipse parameters from the 
% TIDE_FIT output "ucoef" for the components specified in "periods",i.e.,
%
% [ucoef,unew]=tide_fit(jd,uv,periods,goplot)
%          ell=tide_ell(ucoef,periods)
%
% where 
%     ell(:,1) = constitutent period(s)in hr.
%     ell(:,2) = umaj  = major axis.
%     ell(:,3) = umin  = minor axis, where the sign indicates the
%                        rotation of the ellipse.  A positive sign
%                        of umin indicates counterclockwise rotation.
%     ell(:,4) = inc   = counterclockwise inclination from 
%                        positive x axis (degrees). The inclination
%                        will always be in the upper half plane [0:pi].
%     ell(:,5) = phase = phase relative to t=0 (degrees).

% Uses notation of M.G.G FOREMAN'S (1978) least squares harmonic 
% analysis. Adapted from R. Signell's TIDE_ELL.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5/20/98:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% convert input into format for tide_ell
periods=periods(:);
NC=length(periods);

cx=zeros(NC,1);
sx=cx;cy=cx;sy=cx;

for nc=1:NC
   cx(nc)=ucoef(2*(nc-1)+2,1);
   sx(nc)=ucoef(2*(nc-1)+3,1);
   cy(nc)=ucoef(2*(nc-1)+2,2);
   sy(nc)=ucoef(2*(nc-1)+3,2);
end

% begin tide_ell
[imax,jmax]=size(cx);
if imax>jmax
        cx=cx'; sx=sx'; cy=cy'; sy=sy';
end

template=ones(size(cx))*NaN;
umaj=template;umin=template;inc=template;phase=template;
ell=zeros(length(cx),4);

ind=find(~isnan(cx));
cx=cx(ind);sx=sx(ind);cy=cy(ind);sy=sy(ind);

p=(cx+sy)/2+i*(cy-sx)/2;
m=(cx-sy)/2+i*(cy+sx)/2;

ap=abs(p);
epsp=angle(p);

am=abs(m);
epsm=angle(m);

umaj(ind)=ap+am;
umin(ind)=ap-am;

ieps=find((epsp+epsm)<0); % choose inc to range from [0:pi]

if length(ieps)>1
         epsp(ieps)=epsp(ieps)+2*pi*ones(size(ieps));
else
         epsp(ieps)=epsp(ieps)+2*pi;
end
inc(ind)=.5*(epsp+epsm)*180/pi;
phase(ind)=-.5*(epsp-epsm)*180/pi;
ipha=find(phase<0);
phase(ipha)=phase(ipha)+360;
ell=[umaj(:) umin(:) inc(:) phase(:)];

ell=[periods ell];
