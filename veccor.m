   function r=veccor(u1,v1,u2,v2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% r=VECCOR(u1,v1,u2,v2) computes the vector correlation coefficient 
% squared between two vector time series following Crosby et al 
% (1993), JAOT, 355-367. Assumes ui,vi are signle vectors.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ver. 1: 12/1/96 (RB)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f1=cv(u1,u1).*(cv(u2,u2).*cv(v1,v2).^2 + cv(v2,v2).*cv(v1,u2).^2);
f2=cv(v1,v1).*(cv(u2,u2).*cv(u1,v2).^2+cv(v2,v2).*cv(u1,u2).^2);
f3=2.*cv(u1,v1).*cv(u1,v2).*cv(v1,u2).*cv(u2,v2);
f4=2.*cv(u1,v1).*cv(u1,u2).*cv(v1,v2).*cv(u2,v2);
f5=-2.*cv(u1,u1).*cv(v1,u2).*cv(v1,v2).*cv(u2,v2);
f6=-2.*cv(u1,u1).*cv(v1,u2).*cv(v1,v2).*cv(u2,v2);
f7=-2.*cv(v1,v1).*cv(u1,u2).*cv(u1,v2).*cv(u2,v2);
f8=-2.*cv(u2,u2).*cv(u1,v1).*cv(u1,v2).*cv(v1,v2);
f9=-2.*cv(v2,v2).*cv(u1,v1).*cv(u1,u2).*cv(v1,u2);

g1=cv(u1,u1).*cv(v1,v1)-cv(u1,v1).^2;
g2=cv(u2,u2).*cv(v2,v2)-cv(u2,v2).^2;

r=(f1+f2+f3+f4+f5+f6+f7+f8+f9)./(g1.*g2);

end
