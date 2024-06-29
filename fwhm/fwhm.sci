/*2024 
Author: Abinash Singh <abinashsinghlalotra@gmail.com>
*/
/* 
Description:
        Function File: f = fwhm (y) ¶
        Function File: f = fwhm (x, y) ¶
        Function File: f = fwhm (…, "zero") ¶
        Function File: f = fwhm (…, "min") ¶
        Function File: f = fwhm (…, "alevel", level) ¶
        Function File: f = fwhm (…, "rlevel", level) ¶
        Compute peak full-width at half maximum (FWHM) or at another level of peak maximum for vector or matrix data y, optionally sampled as y(x). If y is a matrix, return FWHM for each column as a row vector.

        The default option "zero" computes fwhm at half maximum, i.e. 0.5*max(y). The option "min" computes fwhm at the middle curve, i.e. 0.5*(min(y)+max(y)).

        The option "rlevel" computes full-width at the given relative level of peak profile, i.e. at rlevel*max(y) or rlevel*(min(y)+max(y)), respectively. For example, fwhm (…, "rlevel", 0.1) computes full width at 10 % of peak maximum with respect to zero or minimum; FWHM is equivalent to fwhm(…, "rlevel", 0.5).

        The option "alevel" computes full-width at the given absolute level of y.

        Return 0 if FWHM does not exist (e.g. monotonous function or the function does not cut horizontal line at rlevel*max(y) or rlevel*(max(y)+min(y)) or alevel, respectively).
*/
function myfwhm = fwhm (y, varargin)
  //helper function
  // to calculate max along the columns of a array
  function max_value = col_max (A)
    max_value = zeros ( 1, size(A,2))
    for i = 1:length(max_value)
        max_value(i) = max(A(:,i))
    end
  endfunction
  // to calculate min along the columns of a array
  function min_value = col_min (A)
    min_value = zeros ( 1, size(A,2))
    for i = 1:length(min_value)
        min_value(i) = min(A(:,i))
    end
  endfunction

// main function
  nargin = argn (2)
  if nargin < 1 || nargin > 5
        error("invalid inputs");
  end
  opt = 'zero';
  is_alevel = 0;
  level = 0.5;
  if nargin==1
        x = 1:max(size(y));
  else
    if type(varargin(1)) == 10
      x = 1:max(size(y));
      k = 1;
    else
      x = y;
      y = varargin(1);
      k = 2;
    end
    
    while k <= max(size(varargin))
      if ~strcmp(varargin(k), 'alevel')
        is_alevel = %T;
        k = k+1;
        if k > max(size(varargin))
          error('option alevel requires an argument');
        end
        level = varargin(k);
        if ~isreal(level) || max(size(level)) > 1
          error('argument of alevel must be real number');
        end
        k = k+1;
        break
      end
      if (type(varargin(k)==10)) && ~strcmp(varargin(k), 'rlevel')
        k = k+1;
        if k > max(size(varargin))
          error('option rlevel requires an argument');
        end
        level = varargin(k);
        if ~isreal(level) || max(size(level)) > 1 || level(1) < 0 || level(:) > 1
          error('argument of rlevel must be real number from 0 to 1 (it is 0.5 for fwhm)');
        end
        k = k+1;
        break
      end
      if  ~strcmp(varargin(k),'zero') || ~strcmp(varargin(k),'min') 
        opt = varargin(k);
        k = k+1;
      end
      if k > max(size(varargin)) break; end
      
      break
    end
    if k ~= max(size(varargin))+1
      error('fwhm: extraneous option(s)');
    end
  end
  
  // test the y matrix
  [nr, nc] = size(y);
  if (nr == 1 && nc > 1)
    y = y'; nr = nc; nc = 1;
  end
   
  if max(size(x)) ~= nr
    error('dimension of input arguments do not match');
  end

  // Shift matrix columns so that y(+-xfwhm) = 0:
  if is_alevel
    // case: full-width at the given absolute position
    y = y - level;
  else
    if ~strcmp(opt, 'zero')
      // case: full-width at half maximum
      y = y - level * repmat(col_max(y), nr ,1);
    else
      // case: full-width above background
      y = y - level * repmat((col_max(y) + col_min(y)),nr,1 );
    end
  end
  // Trial for a "vectorizing" calculation of fwhm (i.e. all
  // columns in one shot):
  // myfwhm = zeros(1,nc); // default: 0 for fwhm undefined
  // ind = find (y(1:end-1, :) .* y(2:end, :) <= 0);
  // [r1,c1] = ind2sub(size(y), ind);
  // ... difficult to proceed further.
  // Thus calculate fwhm for each column independently:
  myfwhm = zeros(1,nc); // default: 0 for fwhm undefined
  for n=1:nc
    yy = y(:, n);
    ind = find((yy(1:$-1) .* yy(2:$)) <= 0);
    if max(size(ind)) >= 2 && yy(ind(1)) > 0 // must start ascending
      ind = ind(2:$);
    end
    [mx, imax] = max(yy); // protection against constant or (almost) monotonous functions
    if max(size(ind)) >= 2 && imax >= ind(1) && imax <= ind($)
      ind1 = ind(1);
      ind2 = ind1 + 1;
      xx1 = x(ind1) - yy(ind1) * (x(ind2) - x(ind1)) / (yy(ind2) - yy(ind1));
      ind1 = ind($);
      ind2 = ind1 + 1;
      xx2 = x(ind1) - yy(ind1) * (x(ind2) - x(ind1)) / (yy(ind2) - yy(ind1));
      myfwhm(n) = xx2 - xx1;
    end
  end

endfunction
