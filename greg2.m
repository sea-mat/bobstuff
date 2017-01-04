   function [gtime]=greg2(yrday,yr)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [gtime]=GREG2(yrday,yr) converts year day numbers to corresponding 
% Gregorian calendar dates.  In this convention, Julian day 2440000 
% begins at 0000 Z, May 23, 1968. 
%
%  INPUT:   yrday - decimal yearday (e.g., 0000Z Jan 1 is 0.0)
%           yr - year (e.g., 1995)
%
%  OUTPUT:  gtime is a six component Gregorian time vector
%            i.e.   gtime=[year mo da hr mi sec]
%            
%      Example: [1995 01 01 12 00 00] = greg2(0.5, 1995)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ver. 1: 5/15/91 (RS)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


      js = julian(yr,01,01,00);
      julian = js + yrday;
      julian=julian+5.e-9;    % kludge to prevent roundoff error on seconds

%      if you want Julian Days to start at noon...
%      h=rem(julian,1)*24+12;
%      i=(h >= 24);
%      julian(i)=julian(i)+1;
%      h(i)=h(i)-24;

      secs=rem(julian,1)*24*3600;

      j = floor(julian) - 1721119;
      in = 4*j -1;
      y = floor(in/146097);
      j = in - 146097*y;
      in = floor(j/4);
      in = 4*in +3;
      j = floor(in/1461);
      d = floor(((in - 1461*j) +4)/4);
      in = 5*d -3;
      m = floor(in/153);
      d = floor(((in - 153*m) +5)/5);
      y = y*100 +j;
      mo=m-9;
      yr=y+1;
      i=(m<10);
      mo(i)=m(i)+3;
      yr(i)=y(i);
      [hour,min,sec]=s2hms(secs);
      gtime=[yr(:) mo(:) d(:) hour(:) min(:) sec(:)];
      end

