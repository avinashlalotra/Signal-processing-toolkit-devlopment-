  function res= postives(x)
      j = 1
      res = []
      for i=1:size(x,2)
          if or( x(:,i) < 0 ) 
              j = j - 1
              warning("warning: axis: omitting non-positive data in log plot")
          else
              res(:,j) = x (:,i)
          end
          j = j + 1    
      end
  endfunction
