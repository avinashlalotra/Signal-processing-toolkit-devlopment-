/*2024 
Author: Abinash Singh <abinashsinghlalotra@gmail.com>
*/
 /*  
 Produce the cepstrum of the signal x, and if desired, the minimum phase reconstruction of the signal x.
    Calling Sequence
        [y, xm] = rceps(x)
    Parameters 
        x: real or complex vector input
    Produce the cepstrum of the signal x, and if desired, the minimum phase reconstruction of the signal x. If x is a matrix, do so for each column of the matrix.
    Examples
*/
function [y, xm]= rceps(x)
    if(argn(2)~= 1 )
    error("Wrong number of Input Arguments");
    end
    
    if(argn(1)>2)
    error("Wrong number of Output Arguments")
    end
      f = abs(fft1(x));
      if (or(f == 0))
        error ("The spectrum of x contains zeros, unable to compute real cepstrum");
      end
       
      y = real(ifft1(log(f)));
      
      if argn(1) == 2 then
        n=max(size(x));
        if size(x,1)==1 then
          if (n-fix(n./2).*2) ==1 then
            xm = [y(1), 2*y(2:n/2+1), zeros(1,n/2)];
          else
            xm = [y(1), 2*y(2:n/2), y(n/2+1), zeros(1,n/2-1)];
          end
        else
          if (n-fix(n./2).*2)==1
            xm = [y(1,:); 2*y(2:n/2+1,:); zeros(n/2,size(y,2))];
          else
            xm = [y(1,:); 2*y(2:n/2,:); y(n/2+1,:); zeros(n/2-1,size(y,2))];
          end
        end
        xm = real(ifft1(exp(fft1(xm))));
      end
      
    endfunction
