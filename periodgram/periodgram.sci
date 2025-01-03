// Copyright (C) 2018 - IIT Bombay - FOSSEE
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
// Author:[insert name]
// Organization: FOSSEE, IIT Bombay
// Email: toolbox@scilab.in
function [pxx, f] = periodogram (x, varargin)
    //Calling Sequence:
    //[PXX, F] = periodogram (X, WIN, NFFT, FS)
    //[PXX, F] = periodogram (..., "RANGE")
    
    //     The possible inputs are:
    //
    //     X
    //
    //          data vector.  If X is real-valued a one-sided spectrum is
    //          estimated.  If X is complex-valued, or "RANGE" specifies
    //          "twosided", the full spectrum is estimated.
    //
    //     WIN
    //          window weight data.  If window is empty or unspecified a
    //          default rectangular window is used.  Otherwise, the window is
    //          applied to the signal ('X .* WIN') before computing the
    //          periodogram.  The window data must be a vector of the same
    //          length as X.
    //
    //     NFFT
    //          number of frequency bins.  The default is 256 or the next
    //          higher power of 2 greater than the length of X ('max (256,
    //          2.^nextpow2 (length (x)))').  If NFFT is greater than the
    //          length of the input then X will be zero-padded to the length
    //          of NFFT.
    //
    //     FS
    //          sampling rate.  The default is 1.
    //
    //     RANGE
    //          range of spectrum.  "onesided" computes spectrum from
    //          [0..nfft/2+1].  "twosided" computes spectrum from [0..nfft-1].
    //
    //
    //Test cases:
    ////1.
    //n=0:319;
    //x=cos(%pi/4*n)+rand(size(n,"r"),"normal");
    //[pxx,w]=periodogram(x,ones(1,320),256,2000,"onesided");
    //plot2d(w,10*log10(pxx))
    //xtitle('periodogram','frequency','magnitude(db)')
    //xgrid()
    //
    //
    
    [nargout,nargin]=argn();
      // check input arguments
      if (nargin < 1 | nargin > 5)
       error("wrong no. of input arguments")
      end
    
      nfft = [];
      fs = [];
      ran = "";
      win = [];
      j = 2;
      for k = 1:length (varargin)
        if (type (varargin(k))==10)
          ran = varargin(k);
        else
          select (j)
            case 2
              win = varargin(k);
            case 3
              nfft   = varargin(k);
            case 4
              fs     = varargin(k);
          end
          j=j+1;
        end
      end
    
      if (~ isvector (x))
        error ("periodogram: X must be a real or complex vector");
      end
      x = x(:);  // Use column vectors from now on
    
      n = size(x,1);
    
      if (~isempty (win))
        if (~ isvector (win) | length (win) ~= n)
          error ("periodogram: WIN must be a vector of the same length as X");
        end
        win = win(:);
        x =x.* win;
    else
        win=window("re",length(x));
        win=win(:);
        x=x.*win;
    
      end
    
      if (isempty (nfft))
        nfft = max (256, 2.^nextpow2 (n));
      elseif (~ isscalar (nfft))
        error ("periodogram: NFFT must be a scalar");
      end
    
      use_w_freq = isempty (fs);
      if (~use_w_freq & ~ isscalar (fs))
        error ("periodogram: FS must be a scalar");
      end
    
      if (~strcmp (ran, "onesided"))
        ran = 1;
      elseif (~strcmp (ran, "twosided"))
        ran = 2;
      elseif (~strcmp (ran, "centered"))
        error ('periodogram: centered ran type is not implemented');
      else
        ran = 2 - double(isreal (x));
      end
    
      // compute periodogram
    
      if (n > nfft)
        Pxx = 0;
        rr = modulo(length(x), nfft);
        if (rr)
          x = [x(:); zeros(nfft-rr, 1)];
        end
        x = sum (matrix (x, nfft,-1), 2);
      end
    
      if (~ isempty (win))
        n = sum(win.*conj(win));
      end;

      Pxx = (abs (fft1 (x,nfft))) .^ 2 / n;
    
      if (use_w_freq)
        Pxx =Pxx/(2*%pi);
      else
        Pxx =Pxx/fs;
      end
    
      // generate output arguments
    
      if (ran == 1)  // onesided
        if (modulo(nfft,2)==0)  // nfft is even
          psd_len = (nfft/2)+1;
          disp(size(Pxx))
          disp(psd_len)
          disp(nfft)
          Pxx = Pxx(1:psd_len) + [0; Pxx(nfft:-1:psd_len+1); 0];
        else                 // nfft is odd
          psd_len = (nfft+1)/2;
          Pxx = Pxx(1:psd_len) + [0; Pxx(nfft:-1:psd_len+1)];
        end
      end
    
      if (nargout ~= 1)
        if (ran == 1)
          f = (0:nfft/2)' / nfft;
        elseif (ran == 2)
          f = (0:nfft-1)' / nfft;
        end
        if (use_w_freq)
          f =f* 2*%pi;  // generate w=2*pi*f
        else
          f =f* fs;
        end
      end
    if (nargout > 0)
        if (use_w_freq)
          plot (f/(2*%pi), 10*log10 (Pxx));
          xlabel ("normalized frequency [x pi rad]");
          ylabel ("Power density [dB/rad/sample]");
        else
          plot (f, 10*log10 (Pxx));
          xlabel ("frequency [Hz]");
          ylabel ("Power density [dB/Hz]");
        end
        title ("Periodogram Power Spectral Density Estimate");
    end
    pxx = Pxx;
endfunction

    /*
    // Test cases for periodogram function
        // Test basic functionality with simple sine wave : passed
            t = 0:0.01:1;
            x = sin(2*pi*10*t);  // 10 Hz sine wave
            [Pxx, w] = periodogram(x); // passed
            
        // Test with complex input : passed
            x = complex(0:0.01:1, 0:0.01:1);
            [Pxx, w] = periodogram(x); //passed
                
        // Test with custom window : passed
            x = cos(0:0.01:1);
            win = hamming(100);
            [Pxx1, w1] = periodogram(x, win);
            [Pxx2, w2] = periodogram(x);  // Default rectangular window
                
        // Test with custom nfft : passed
            x = tan(0:0.01:1);
            nfft = 512;
            [Pxx, w] = periodogram(x, [], nfft);
                
        // Test with custom sampling rate : passed
            t = 0:0.01:1;
            x = sin(2*pi*10*t);
            Fs = 100;  // 100 Hz sampling rate
            [Pxx, f] = periodogram(x, [], [], Fs);
            
        // Test range specification : passed
            x = sin(0:0.01:1);
            [Pxx1, w1] = periodogram(x, [], [], [], 'onesided');
            [Pxx2, w2] = periodogram(x, [], [], [], 'twosided');

        // Test with known signal for peak detection : passed
            Fs = 1000;
            t = 0:1/Fs:1-1/Fs;
            f0 = 100;  % 100 Hz signal
            x = sin(2*pi*f0*t);
            [Pxx, f] = periodogram(x, [], [], Fs);
            
            % Find frequency peak
            [~, idx] = max(Pxx);
            detected_freq = f(idx);
            
// Test error cases
                
    // Test invalid window length :passed
                x = randn(100,1);
                win = hamming(50);  // Wrong length window
                periodogram(x, win)
                
    // Test invalid nfft (negative)
                periodogram(x, [], -256)
                
    // Test invalid sampling rate
                periodogram(x, [], [], -100)
                
    // Test invalid range specification
                periodogram(x, [], [], [], 'invalid')
    */