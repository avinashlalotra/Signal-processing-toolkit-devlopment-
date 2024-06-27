
function [a, b] = arch_fit (y, x, p, iter, gamma, a0, b0)
    nargin = argn(2)
    if (nargin < 3 || nargin == 6)
      error("invalid inputs");
    end
  
    if (~ (isvector (y)))
      error ("arch_fit: Y must be a vector");
    end
  
    T = max(size(y));
    y = matrix (y, T, 1);
    [rx, cx] = size (x);
    if ((rx == 1) && (cx == 1))
      x = autoreg_matrix (y, x);
    elseif (~ (rx == T))
      error ("arch_fit: either rows (X) == length (Y), or X is a scalar");
    end
  
    [T, k] = size (x);
  
    if (nargin == 7)
      a = a0;
      b = b0;
      e = y - x * b;
    else
      [b, v_b, e] = ols (y, x);
      a = [v_b, (zeros (1, p))]';
      if (nargin < 5)
        gamma = 0.1;
        if (nargin < 4)
          iter = 50;
        end
      end
    end
  
    esq = e.^2;
    Z = autoreg_matrix (esq, p);
  
    for i = 1 : iter
      h   = Z * a;
      tmp = esq ./ h.^2 - 1 ./ h;
      s   = 1 ./ h(1:T-p);
      for j = 1 : p
        s = s - a(j+1) * tmp(j+1:T-p+j);
      end
      r = 1 ./ h(1:T-p);
      for j = 1:p
        r = r + 2 * h(j+1:T-p+j).^2 .* esq(1:T-p);
      end
      r = sqrt (r);
      X_tilde = x(1:T-p, :) .* (r * ones (1,k));
      e_tilde = e(1:T-p) .*s ./ r;
      delta_b = inv (X_tilde' * X_tilde) * X_tilde' * e_tilde;
      b  = b + gamma * delta_b;
      e   = y - x * b;
      esq = e .^ 2;
      Z   = autoreg_matrix (esq, p);
      h   = Z * a;
      f   = esq ./ h - ones (T,1);
      Z_tilde = Z ./ (h * ones (1, p+1));
      delta_a = inv (Z_tilde' * Z_tilde) * Z_tilde' * f;
      a = a + gamma * delta_a;
    end
  
  endfunction
