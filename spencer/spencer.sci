function savg = spencer (x)
   
  if (argn(2) ~= 1)
    error("invalid inputs");
  end

  [xr, xc] = size (x);

  n = xr;
  c = xc;

  if (isvector (x))
   n = max(size(x));
   c = 1;
   x = matrix (x, n, 1);
  end

  w = [-3, -6, -5, 3, 21, 46, 67, 74, 67, 46, 21, 3, -5, -6, -3] / 320;

  savg = fftfilt (w, x);
  savg = [zeros(7,c); savg(15:n,:); zeros(7,c);];

  savg = matrix (savg, xr, xc);
  
  endfunction
