  function  y=cv(x1,x2)

% CV  Cross product between two vectors.
%
% y=CV(x1,x2) computes cross product between x1 and x2 with means 
% removed.  Assumes x1,x2 are separate vectors. For use in VECCOR1.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ver. 1: 11/17/96 (RB)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x1m=mean(x1);
x2m=mean(x2);
x1p=x1-x1m;
x2p=x2-x2m;
[N,M]=size(x1);
if N==1
    y=x1p*x2p'; y=y./(M-1);
  elseif M==1
    y=x1p'*x2p; y=y./(N-1);
end
end
