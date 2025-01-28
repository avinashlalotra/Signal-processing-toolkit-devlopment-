function [u, v] = dwt (x, Hp , Gp)
    if (nargin  > 3) then
      error("dwt: Too many input arguments");
    end
  
    tmp = wconv (1, x, Hp, "valid");
    u = tmp(1:2:$);
    
    tmp = wconv (1, x, Gp, "valid");
    v = tmp(1:2:$);
  
  endfunction

  function y = wconv (type, x, f, shape)

    if (nargin < 3 || nargin > 4)
      error("wconv: Invalid number of input arguments");
    end
    if nargin < 4 then shape = "full" end
    
    switch (type)
      case 1
        y = conv2 (1,x(:).', f(:).', shape);
        if (size(x,1) > 1)
          y = y.';
        end
      case 2
        y = conv2 (1,x, f, shape);
      otherwise
        error("wconv: Invalid type");
    end
  endfunction
