      function  t = txt( t_old )
%  TXT  Fill a matrix with lines of text entered from the keyboard.
%
%  t = TXT( t_old ) returns an array containing lines of text entered from 
%  the keyboard. If t_old is specified, the new text is appended, and the 
%  result returned in t. Each line is padded with blanks to 80 characters, 
%  and there is a maximum of 100 lines. Text input is terminated by 
%  entering a line with the single character '.'.  NOTE: lines cannot 
%  begin with a space - they must start with letters, numbers or valid 
%  punctuation symbols.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  ver. 1: 12/1/96 (RG)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end_chr = '.' ;			% end of text character
ascii_b = 32 ;			% Ascii decimal code for ' '

if nargin == 0			% if t_old not specified, create t
    t = [] ;			
    n_lines = 0 ;
else				% else append new text to old
    t = t_old ;
    n_lines = length( t(:,1) ) ;
end
          			% get text from keyboard - up to 100 lines
disp('Start entering text (no quotes necessary). Type . by itself to terminate.')
while( n_lines < 101 )

    line = input('','s') ;	%  issue prompt, then
				%  check for input terminator
    L = length( line ) ;
    if (L==1) & (line(1)==end_chr ), break; end

    n_blanks = 79 - L ;	

    if n_blanks < 0		%  if too long, truncate at 80 chars
	line = line(1:80) ;	%  else pad with blanks to 80 chars
    else
        line = [ line, setstr( ascii_b*ones(1,n_blanks)) ] ;
    end
				%  add this line to the text array
    t = [t; line] ;

    n_lines = n_lines + 1 ;	%  increment line count

end
