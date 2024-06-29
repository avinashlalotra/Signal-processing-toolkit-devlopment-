function zsort = cplxpair (z, tol, dim)

  if (nargin < 1)
    error("Invalid inputs");
  end

  if (isempty (z))
    zsort = zeros (size (z));
    return;
  end

  
  if (nargin < 2 || isempty (tol))
    tol = 100* %eps;
  elseif (! isscalar (tol) || tol < 0 || tol >= 1)
    error ("cplxpair: TOL must be a scalar number in the range 0 <= TOL < 1");
  end

  nd = ndims (z);
  if (nargin < 3)
    // Find the first singleton dimension.
    sz = size (z);
    (dim = find (sz > 1, 1)) || (dim = 1);
  else
    dim = floor (dim);
    if (dim < 1 || dim > nd)
      error ("cplxpair: invalid dimension DIM");
    end
  end

  // Move dimension to analyze to first position, and convert to a 2-D matrix.
  perm = [dim:nd, 1:dim-1];
  z = permute (z, perm);
  sz = size (z);
  n = sz(1);
  m = prod (sz) / n;
  z = matrix (z, n, m);

  // Sort the sequence in terms of increasing real values.
  [temp, idx] = sort (real (z), 1);
  z = z(idx + n * ones (n, 1) * [0:m-1]);

  // Put the purely real values at the end of the returned list.
  [idxi, idxj] = find (abs (imag (z)) ./ (abs (z) + realmin (cls)) <= tol);
  // Force values detected to be real within tolerance to actually be real.
  z(idxi + n*(idxj-1)) = real (z(idxi + n*(idxj-1)));
  q = sparse (idxi, idxj, 1, n, m);
  nr = sum (q, 1);
  [temp, idx] = sort (q, 1);
  midx = idx + rows (idx) * ones (rows (idx), 1) * [0:columns(idx)-1];
  z = z(midx);
  zsort = z;

  // For each remaining z, place the value and its conjugate at the start of
  // the returned list, and remove them from further consideration.
  for j = 1:m
    p = n - nr(j);
    for i = 1:2:p
      if (i+1 > p)
        error ("cplxpair: could not pair all complex numbers");
      end
      [v, idx] = min (abs (z(i+1:p,j) - conj (z(i,j))));
      if (v >= tol * abs (z(i,j)))
        error ("cplxpair: could not pair all complex numbers");
      end
      // For pairs, select the one with positive imaginary part and use it and
      // it's conjugate, but list the negative imaginary pair first.
      if (imag (z(i,j)) > 0)
        zsort([i, i+1],j) = [conj(z(i,j)), z(i,j)];
      else
        zsort([i, i+1],j) = [conj(z(idx+i,j)), z(idx+i,j)];
      end
      z(idx+i,j) = z(i+1,j);
    end
  end

  // Reshape the output matrix.
  zsort = ipermute (reshape (zsort, sz), perm);

endfunction

