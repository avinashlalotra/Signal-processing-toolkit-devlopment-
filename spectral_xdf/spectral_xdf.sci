//tested
function c = rectangle_sw (n, b)

    c = zeros (n, 1);
    c(1) = 2 / b + 1;
  
    l = (2:n)' - 1;
    l = 2 * pi * l / n;
  
    c(2:n) = sin ((2/b + 1) * l / 2) ./ sin (l / 2);
  
endfunction
//tested
function retval = triangle_sw (n, b)

    retval = zeros (n,1);
    retval(1) = 1 / b;
  
    l = (2:n)' - 1;
    l = 2 * pi * l / n;
  
    retval(2:n) = b * (sin (l / (2*b)) ./ sin (l / 2)).^2;
  
endfunction
function sde = spectral_xdf (x, win, b)
    nargin = argn(w)
    if (nargin < 1)
      error("invalid inputs");
    end
  
    xr = max(size (x) );
  
    if (size (x, 2) > 1)
      x = x';
    end
  
    if (nargin < 3)
      b = 1 / ceil (sqrt (xr));
    end
  
    if (nargin == 1)
      w = triangle_sw (xr, b);
    elseif (~ ischar (win))
      error ("spectral_xdf: WIN must be a string");
    elseif (~strcmp (win , "triangle" ) ) 
        w = triangle_sw (xr , b);
    elseif (~strcmp (win , "triangle" ) )     
        w = rectangle_sw ( xr , b)
    else
      error("Invalid window or this window is not supported yet");
    end
  
    x -= sum (x) / xr;
  
    sde = (abs (fft1 (x)) / xr).^2;
    sde = real (ifft1 (fft1 (sde) .* fft1 (w)));
  
    sde = [(zeros (xr, 1)), sde];
    sde(:, 1) = (0 : xr-1)' / xr;
endfunction
