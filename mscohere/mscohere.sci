/*
Calling Sequence:
Function File: [Pxx, freq] = mscohere (x, y) 
Function File: […] = mscohere (x, y, window) 
Function File: […] = mscohere (x, y, window, overlap) 
Function File: […] = mscohere (x, y, window, overlap, Nfft) 
Function File: […] = mscohere (x, y, window, overlap, Nfft, Fs) 
Function File: […] = mscohere (x, y, window, overlap, Nfft, Fs, range) 
Function File: mscohere (…) 
Description:
Estimate (mean square) coherence of signals x and y. Use the Welch (1967) periodogram/FFT method.
*/
function varargout = mscohere(varargin)
    // Check fixed argument
    if (nargin < 2 || nargin > 7)
      error("Invalid number of arguments");
    end
    nvarargin = length(varargin);
    // remove any pwelch RESULT args and add 'cross'
    for iarg=1:nvarargin
      arg = varargin(iarg);
      if ( ~isempty(arg) && ( type(arg) == 10 ) && ( ~strcmp(arg,'power') || ...
             ~strcmp(arg,'cross') || ~strcmp(arg,'trans') || ...
             ~strcmp(arg,'coher') || ~strcmp(arg,'ypower') ))
        varargin(iarg) = [];
      end
    end
    varargin(nvarargin+1) = 'coher';
    disp(varargin)
    if ( nargout==0 )
      pwelch(varargin(:));
    elseif ( nargout==1 )
      Pxx = pwelch(varargin(:));
      varargout(1) = Pxx;
    elseif ( nargout>=2 )
      [Pxx,f] = pwelch(varargin(:));
      varargout(1) = Pxx;
      varargout(2) = f;
    end
  endfunction
  /*
  
test cases  1 2 3 4
    
t = linspace(0,10,1000); x = sin(t) ; y = cos(t);
subplot(2,2,1)
mscohere(x,y)
subplot(2,2,2)
mscohere(t,x,5)
subplot(2,2,3)
mscohere(t,y,6,0.45)
subplot(2,2,4)
t = linspace(1,10,1000); x =sin(t);
y = filter(0.23,x,t);
mscohere(x,y,7,0.70,300)
------------------------------------------run seperately------------------

test case 5 6
subplot(2,2,1)
t = linspace(1,10,1000); x =cos(t);
y = filter(0.9999,x,t);
mscohere(x,y,5,0.32,212,1000)
subplot(2,2,2)
t = linspace(1,10,1000); x =filter(0.3245,cos(t),t); y = filter(0.0034,x,sin(t));
mscohere(x,y,8,0.49,300,100,"onesided")
  
  */
