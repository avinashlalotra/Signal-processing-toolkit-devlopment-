function retval = unwrap2 (x, tol, dim)
  nargin = argn(2)
  if (nargin < 1)
    error("invalid inputs");
  end

  if (~ (type(x) == [ 1 5 8]) || or(type(x)==[4,6]))
    error ("unwrap2: X must be numeric");
  end

  if (nargin < 2 || isempty (tol))
    tol = %pi;
  end

  // Don't let anyone use a negative value for TOL.
  tol = abs (tol);

  nd = ndims (x);
  sz = size (x);
  disp(sz)
  if (nargin == 3)
    if (~(or(type(dim)==[1 5 8])&& isscalar (dim) && ...
            dim == fix (dim)) || ~(1 <= dim))
      error ("unwrap2: DIM must be an integer and a valid dimension");
    end
  else
    // Find the first non-singleton dimension.
    dim = find (sz > 1, 1)
    if isempty(dim)
      dim = 1;
    end   
  end
//
  rng = 2*%pi;

  // Handle case where we are trying to unwrap a scalar, or only have
  // one sample in the specified dimension (a given when dim > nd).
  if ((dim > nd) || ( sz(dim) == 1))
    retval = x;
    return;
  end

  if (and(abs(x(:))<%inf ) )

    // Take first order difference so that wraps will show up as large values
    // and the sign will show direction.
    sz(dim) = 1;
    disp(sz)
    zero_padding = zeros (sz);
    disp(size(zero_padding))
    d = cat (dim, zero_padding, -diff (x, 1, dim));

    // Find only the peaks and multiply them by the appropriate amount
    // of ranges so that there are kronecker deltas at each wrap point
    // multiplied by the appropriate amount of range values.
    
    p = round (abs (d)./rng) .* rng .* (double(double(d > tol) > 0) - double(double(d < -tol) > 0));
    disp(size(p))
    // Integrate this so that the deltas become cumulative steps to shift
    // the original data.
    retval = cumsum (p, dim) + x;

  else
    // Unwrap needs to skip over NaN, NA, Inf in wrapping calculations.

    if (isvector (x))
      // Simlpified path for vector inputs.

      retval = x;
      xfin_idx = abs(x)<%inf ;
      xfin = x(xfin_idx);
      d = cat (dim, 0, -diff(xfin, 1, dim));
      p = round (abs (d)./rng) .* rng .* ...
                      (((d > tol) > 0) - ((d < -tol) > 0));
      retval(xfin_idx) = xfin + cumsum (p, dim);

    else
      // For n-dimensional arrays with a possibly unequal number of non-finite
      // values, mask entries with values that do not impact calcualation.

            // Locate nonfinite values.
      nf_idx = ~ abs(x)<%inf;

      if (and(nf_idx(:)))
        // Trivial case, all non-finite values
        retval = x;
        return;
      end

      // Permute all operations to occur along dim 1.  Inverse permute at end.
      permuteflag = dim ~= 1;
      if (permuteflag)
        perm_idx = [1 : nd];
        perm_idx([1, dim]) = [dim, 1];

        x = permute (x, perm_idx);
        nf_idx = permute (nf_idx, perm_idx);
        sz([1, dim]) = sz([dim, 1]);
        dim = 1;
      end

      // Substitute next value in dim direction for nonfinite values(ignoring
      // any at trailing end) to prevent calculation impact.

      x_nf = x(nf_idx); // Store nonfinite values.

      zero_padding = zeros ([1, sz(2:$)]);
      x = __fill_nonfinite_columnwise__ (x, nf_idx, zero_padding, sz, nd);

      d = [zero_padding; -diff(x, 1, 1)];

      p = round (abs (d)./rng) .* rng .* ...
          (((d > tol) > 0) - ((d < -tol) > 0));

      retval = x + cumsum (p, 1);

      // Restore nonfinite values.
      retval(nf_idx) = x_nf;

      // Invert permutation.
      if (permuteflag)
        retval = ipermute (retval, perm_idx);
      end

    end
  end

endfunction
// write repelmes
function y = repelems(x,r)
  y = [];
  for i = 1:size(r,2)
      y = [y, x(r(1,i)*ones(1, r(2,i)))];
  end
endfunction
function x = __fill_nonfinite_columnwise__ (x, nonfinite_loc, zero_padding, szx, ndx)
  // Replace non-finite values of x, as indicated by logical index
  // nonfinite_loc, with next values.
  flip_idx(1:ndx) = {':'};
  flip_idx(1) = {szx(1):-1:1};

  // Isolate nf values by location:
  nf_front = cumprod (nonfinite_loc, 1);
  nf_back = cumprod (nonfinite_loc(flip_idx{:}), 1)(flip_idx{:});
  nf_middle = nonfinite_loc & ~ (nf_back | nf_front);

  // Process bound/middle elements
  locs_before = [diff(nf_middle, 1, 1); zero_padding] == 1;
  locs_after = diff ([zero_padding; nf_middle], 1, 1) == -1;
  mid_gap_sizes = find (locs_after) - find (locs_before) - 1;
  x(nf_middle) = repelems (x(locs_after), ...
                          [1 : numel(mid_gap_sizes); mid_gap_sizes'])';

  // Process front edge elements
  nf_front = nf_front & ~ and (nonfinite_loc, 1); // Remove all nf columns.
  locs_after = diff ([zero_padding; nf_front], 1, 1) == -1;
  front_gap_sizes = (sum (nf_front, 1))(any (nf_front, 1))(:);
  x(nf_front) = repelems (x(locs_after), ...
                             [1:length(front_gap_sizes); front_gap_sizes'])';

endfunction

