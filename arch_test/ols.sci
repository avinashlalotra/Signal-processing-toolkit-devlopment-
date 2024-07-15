function [beta, sigma, r] = ols (y, x)
    
    function [u , p] = formatted_chol(z)
      //p flags whether the matrix A was positive definite and chol does not fail. A zero value of p indicates that matrix A is positive definite and R gives the factorization. Otherwise, p will have a positive value.
      ierr  = execstr (" u = chol (z);",'errcatch' )
      if ( ierr == 29 )
        p = %T ;
        warning("chol: Matrix is not positive definite.")
        u = %nan
      else
        p = %F ;
      end

    endfunction

    nargin = argn ( 2 )
    if (nargin ~= 2)
      error ("null");
    end
  
    if (~ (or (type(x) == [ 1 5 8] ) && or (type(y) == [1 5 8])))
      error ("ols: X and Y must be numeric matrices or vectors");
    end
  
    if (ndims (x) ~= 2 || ndims (y) ~= 2)
      error ("ols: X and Y must be 2-D matrices or vectors");
    end
  
    [nr, nc] = size (x);
    [ry, cy] = size (y);
    if (nr ~= ry)
      error ("ols: number of rows of X and Y must be equal");
    end
  
    if (type(x) == 8)
      x = double (x);
    end
    if ( type(y) == 8 )
      y = double (y);
    end
  
    // Start of algorithm
    z = x' * x;
    [u, p] = formatted_chol (z);
  
    if (p)
      beta = pinv (x) * y;
    else
      beta = u \ (u' \ (x' * y));
    end
  
    if (nargout > 1)
      r = y - x * beta;
  
      // z is of full rank, avoid the SVD in rnk
      if (p == 0)
        rnk = size (z,2);
      else
        rnk = rank (z);
      end
  
      sigma = r' * r / (nr - rnk);
    end
  
  endfunction
