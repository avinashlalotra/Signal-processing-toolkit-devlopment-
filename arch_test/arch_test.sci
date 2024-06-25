function cdf = chi2cdf ( X, n)
    df = resize_matrix ( n , size (X) , "" , n);
    [cdf,Q] = cdfchi ( "PQ" , X ,df);
endfunction
function [pval, lm] = arch_test (y, x, p)
  nargin = argn(2)
  if (nargin ~= 3)
    error ("arch_test: 3 input arguments required");
  end

  if (~ (isvector (y)))
    error ("arch_test: Y must be a vector");
  end
  T = max(size(y));
  y = matrix (y, T, 1);
  [rx, cx] = size (x);
  if ((rx == 1) && (cx == 1))
    x = autoreg_matrix (y, x);
  elseif (~ (rx == T))
    error ("arch_test: either rows (X) == length (Y), or X is a scalar");
  end
  if (~ (isscalar (p) && (modulo (p, 1) == 0) && (p > 0)))
    error ("arch_test: P must be a positive integer");
  end

  [b, v_b, e] = ols (y, x);
  Z    = autoreg_matrix (e.^2, p);
  f    = e.^2 / v_b - ones (T, 1);
  f    = Z' * f;
  lm   = f' * inv (Z'*Z) * f / 2;
  pval = 1 - chi2cdf (lm, p);

endfunction
