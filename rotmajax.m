  function [ur,vr,thetad]=rotmajax(u,v)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [ur,[vr],thetad]=ROTMAJAX(u,v) rotates input vector velocity
% into direction of maximum variance.  Input can be either real 
% u,v or complex (u+iv) vectors, ur,vr or (ur+ivr) is the vector 
% velocity rotated by the angle theta counterclockwise.  Assumes 
% u,v are east,north components. 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ver. 1: 11/17/96 (RG)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin==1;
    v=imag(u);
    u=real(u);
end

[N,M]=size(u);
if M==1
  u=u';v=v';
end

if any( isnan(u(:)))|(isnan(v(:)) )
     disp('NaNs found')
      ur=oness(u)*nan;
      vr=ur;
     g=find( (~isnan(u(:)))&(~isnan(v(:))) );
  if length(g)>1;
     u=u(g);
      v=v(g);
  end
else
     ur=u;
     vr=u;
     g=1:length(u(:));
end
if length(g)>1
cv1=cov([u(:) v(:)]);
theta=0.5*atan2(2.*cv1(2,1),(cv1(1,1)-cv1(2,2)) );
thetad=theta*180./pi
vr(g)=-u*sin(theta)+v*cos(theta);
ur(g)=u*cos(theta)+v*sin(theta);

else;
thetad=nan;
end

if M==1
  ur=ur';vr=vr';
end

if nargin==1
   ur=ur+sqrt(-1)*vr;
   vr=thetad;
   thetad=[];
end
