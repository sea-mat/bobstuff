%          Notes on Regression Methods for Linear Models
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  A general problem in data analysis is fitting a linear model of the
%  form
%
%             y = a + b*x
%
%  to a set of N [x,y] data points. The statistical problem is to first 
%  determine the parameters (intercept a, slope b) which provide the
%  'best' fit of the data to the model, and then estimate the confidence
%  intervals for [a,b]. The 'best' fit is determined by least-squares,
%  i.e., chosing [a,b] to minimize an appropriate merit function chi which
%  involves squares of [x,y]. This leads to [a,b] having confidence
%  intervals given by the student-t distribution.
%
%  In the usual case (Case A), x is considered the independent variable
%  with no measurement error and y the dependent variable with a random
%  error given by N(0, stdy), where N is the normal distrubution function
%  with zero mean and standard deviation stdy. In this case, the merit
%  function chi is defined as the sum of the squared residuals
%
%         chi = sum( r(n)^2 ) = sum( y(n)-a-b*x(n))^2 )
%
%  where r(n) is the residual or vertical distance between y(n) and the
%  'best' fit line for the nth point, and the sum is over [1:N].
%  Differentiation of chi with respect with a and b and setting the
%  resulting equations to zero yield two normal equations which are linear
%  in a and b, thus allowing an exact solution.  LINREG(x,y) finds this
%  solution and returns the 95% confidence intervals for [a,b].
%
%  In the case when both x and y are considered random variables (Case B),
%  i.e., when x also contains random measurement error characterized by
%  N(0, stdx), then the merit function chi is defined as the sum of the
%  squared perpendicular distances between the data points and the 'best'
%  fit line, so that
%
%      chi = sum( (y(n)-a-b*x(n))^2/(stdy^2+b^2*stdx^2) )
%
%  where the denominator can be considered to convert the vertical
%  distance into the perpendicular distance. In this case, stdx and stdy
%  are assumed known apriori. Since b appears in the denominator of chi,
%  differentiation of chi with respect to b leads to a nonlinear normal
%  equation for b (the normal equation for a is unchanged from case A).
%  For the special case considered here, namely that the uncertainities in
%  x(y) are independent of the value of x(y), then the nonlinear normal
%  equation for b reduces to a quadratic which can be solved 'exactly'
%  using FZERO and an initial guess. LINREG1(x,y,stdx,stdy,b0) determines
%  the best [a,b] and returns their 95% confidence intervals given the
%  input [stdx,stdy].  In the limit as the uncertainity in (say) x gets
%  very small (stdx<<stdy), the results of LINREG1 and LINREG converge.
%
%  SUMMARY:
%  Case A: y is random variable. Use LINREG(x,y).  
%  Case B: x and y are random variables. Use LINREG1(x,y,stdx,stdy,b0).
%          LINREG1 uses QUADRAT.
%
%  For general discussion of both cases, see sections 15.1-15.3, 
%  Press et al. (1992), Numerical Recipes: The Art of Scientific 
%  Computing, Edition 2.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ver. 1: 12/1/96 (RB)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%