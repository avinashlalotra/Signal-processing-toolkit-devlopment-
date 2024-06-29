function [zc, zr] = cplxreal (z, tol, dim)

  if (nargin < 1 || nargin > 3)
    error("invalid inputs");
  end

  if (isempty (z))
    zc = zeros (size (z));
    zr = zeros (size (z));
    return;
  end


  if (nargin < 2 || isempty (tol))
    tol = 100 * %eps ;
  end

  args = cell (1, nargin);
  args{1} = z;
  args{2} = tol;
  if (nargin >= 3)
    args{3} = dim;
  end

  zcp = cplxpair (args{:});

  nz = max(size (z) );
  idx = nz;
  while ((idx > 0) && (zcp(idx) == 0 || (abs (imag (zcp(idx))) ./ abs (zcp(idx))) <= tol))
    zcp(idx) = real (zcp(idx));
    idx--;
  end

  if (mod (idx, 2) ~= 0)
    error ("cplxreal: odd number of complex values was returned from cplxpair");
  end

  zc = zcp(2:2:idx);
  zr = zcp(idx+1:nz);

endfunction
