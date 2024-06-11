/*2024 
Author: Abinash Singh <abinashsinghlalotra@gmail.com>
*/
/*
This function computes the inverse type I discrete sine transform.
    Calling Sequence
        Y = idst1(X)
        Y = idst1(X, N)
    Parameters
        X: Matrix or integer
        N: If N is given, then X is padded or trimmed to length N before computing the transform.
    Description
        This function computes the inverse type I discrete sine transform of X If N is given, 
        then X is padded or trimmed to length N before computing the transform.
        If X is a matrix, compute the transform along the columns of the the matrix.
    Examples
        idst1([1,3,6])
    ans = 
         3.97487  -2.50000   0.97487 
*/
function y = dst1(x, n)
  funcprot(0);
  rhs = argn(2);
  if (rhs < 1 | rhs > 2)
    error("ds1: wrong number of input arguments");
  end

  transpose = (size(x, 'r') == 1);
  if (transpose)
    x = x (:);
  end

  [nr, nc] = size(x);
  if (rhs == 1)
    n = nr;
  elseif (n > nr)
    x = [ x ; zeros(n-nr, nc) ];
  elseif (n < nr)
    x (nr-n+1 : n, :) = [];
  end

  d = [ zeros(1, nc); x; zeros(1, nc); -flipdim(x, 1) ];
  y = fft(d, -1, find(size(d) ~= 1, 1))/2*%i;
  y = y(2:nr+1, :);
  if (isreal(x))
    y = real (y);
  end

  if (transpose)
    y = y.';
  end

endfunction
function x = idst1 (y, n)
  nargin=argn(2)
  if (nargin < 1 || nargin > 2)
    error("invalid input arguments")
  end

  if nargin == 1,
    n = size(y,1);
    if n==1, n = size(y,2); end
  end
  x = dst1(y, n) * 2/(n+1);

endfunction

