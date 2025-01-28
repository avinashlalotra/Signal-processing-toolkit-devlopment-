// Function : [u, v] = dwt (x, Hp, Gp)

// Function: [u, v] = dwt (x, wname)
/*
Discrete wavelet transform (1D).

Inputs:
- x: Signal vector.
- wname: Wavelet name.
- Hp: Coefficients of low-pass decomposition FIR filter.
- Gp: Coefficients of high-pass decomposition FIR filter.

Outputs:
- u: Signal vector of average, approximation.
- v: Signal vector of difference, detail.
*/
function [u, v] = dwt (varargin)
    if (nargin  < 2 || nargin > 3) then
      error("dwt: Wrong number of input arguments");
    end
    if nargin == 2 then 
      if type(varargin(2)) == "string" then
        error("dwt : No wavlet is available please provide Hp and Gp manually") ;
      else
        error("dwt: Invalid input arguments");
      end
    end
    x = varargin(1);
    Hp = varargin(2);
    Gp = varargin(3);
    // if ~isvector(varargin(2)) then
    //   error("dwt: Hp must be a vector");
    // end
    // if ~isvector(varargin(3)) then
    //   error("dwt: Gp must be a vector");
    // end
    tmp = conv(x,Hp, "valid");
    u = tmp(1:2:$)';
    disp(tmp)
    tmp = conv(x,Gp, "valid");
    v = tmp(1:2:$)';
    disp(tmp)
endfunction

/*
// real inputs
test case 1 
[u,v]=dwt([1:4],[1 2 3],[4 5 6]); // passed
assert_checkequal([u v],[10 28]);

test case 2
[u,v]=dwt([1:4;5:8],[1 2 3],[4 5 6]); // passed
assert_checkequal([u v],[15 39;21 54;27 69]);

test case 3 - check for empty input arguments
[u,v]=dwt([],[1 2 3;4 5 6],[7 8 9;10 11 12]); // passed
assert_checkequal([u v],[]);
[u,v]=dwt([],[],[]); // passed
assert_checkequal([u v],[]);
[u,v]=dwt([1:4],[1 2 3],[]); // passed
assert_checkequal(u,10);

// complex inputs
test case 4 


*/