   function [j]=julian(y,m,d,h)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [j]=JULIAN(y,m,d,h) converts Gregorian calendar dates to corresponding
% Julian day numbers.  Although the formal definition holds that Julian 
% days start and end at noon, here Julian days start and end at midnight.
% In this convention, Julian day 2440000 began at 0000 Z, May 23, 1968.
% 
%   INPUT:  d -  day (1-31) component of Gregorian date
%           m -  month (1-12) component
%           y -  year (e.g., 1979) component
%           h -  decimal hours (assumed 0 if absent)
%   
%   OUTPUT: j - decimal Julian day number (e.g., 0000Z Jan 1 is 0.0)
% 
%   Usage: [j]=julian(y,m,d,h)  or  [j]=julian([y m d hour min sec])
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ver. 1: 5/15/91 (RS)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     
    if nargin==3,
        h=0.;
      elseif nargin==1,
        h=hms2h(y(4),y(5),y(6));
        d=y(3);
        m=y(2);
        y=y(1);
      end
      mo=m+9;
      yr=y-1;
      i=(m>2);
      mo(i)=m(i)-3;
      yr(i)=y(i); 
      c = floor(yr/100);
      yr = yr - c*100;
      j = floor((146097*c)/4) + floor((1461*yr)/4) + ...
           floor((153*mo +2)/5) +d +1721119;

%     If you want julian days to start and end at noon, 
%     replace the following line with:
%     j=j+(h-12)/24;
 
      j=j+h/24;
      end
