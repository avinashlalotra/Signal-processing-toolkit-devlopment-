/*
Function File: [Pxx, freq] = cpsd (x, y) ¶
Function File: […] = cpsd (x, y, window) ¶
Function File: […] = cpsd (x, y, window, overlap) ¶
Function File: […] = cpsd (x, y, window, overlap, Nfft) ¶
Function File: […] = cpsd (x, y, window, overlap, Nfft, Fs) ¶
Function File: […] = cpsd (x, y, window, overlap, Nfft, Fs, range) ¶
Function File: cpsd (…) ¶
Estimate cross power spectrum of data x and y by the Welch (1967) periodogram/FFT method.
*/
function varargout = cpsd(varargin)
    // Check fixed argument
    if (nargin < 2 || nargin > 7)
      error( "Invalid number of inputs" );
    end
    nvarargin = length(varargin);
    // remove any pwelch RESULT args and add 'cross'
    for iarg=1:nvarargin
      arg = varargin(iarg);
      if ( ~isempty(arg) && (type(arg) == 10 ) && ( ~strcmp(arg,'power') || ...
             ~strcmp(arg,'cross') || ~strcmp(arg,'trans') || ...
             ~strcmp(arg,'coher') || ~strcmp(arg,'ypower') ))
        varargin(iarg) = [];
      end
    end
    varargin(nvarargin+1) = 'cross';
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
cpsd(x,y)

test case 2
    
cpsd(t,x,4)

testcase 3

cpsd(t,y,7,0.88,12,200,"half")

test case 4
t = linspace(1,10,1000); x =sin(t);
y = filter(0.23,x,t);
cpsd(x,y,5,0.5)


test case 5 

t = linspace(1,10,1000); x =cos(t);
y = filter(0.9999,x,t);
cpsd(x,y,8,0.33,200)

test case 6

t = linspace(1,10,1000); x =filter(0.3245,cos(t),t); y = filter(0.0034,x,sin(t));
cpsd(x,y,7,0.22, 400,1000)
  
  */
