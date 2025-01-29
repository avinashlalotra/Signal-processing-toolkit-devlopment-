function [psd,f_out]=pyulear(x,poles,varargin)
  if ( nargin<2 )
    error( "pyulear: need at least 2 args." );
  end
  [ar_coeffs,residual,k]=aryule(x,poles);
  if ( nargout== 1 )
    psd = ar_psd(ar_coeffs,residual,varargin(:));
  elseif ( nargout>=2 )
    [psd,f_out] = ar_psd(ar_coeffs,residual,varargin(:));
  end
endfunction

/*
demo
 a = [1.0 -1.6216505 1.1102795 -0.4621741 0.2075552 -0.018756746];
 Fs = 25;
 n = 16384;
 signal = detrend (filter (0.70181, a, rand (1, n)));
 // frequency shift by modulating with exp(j.omega.t)
 skewed = signal .* exp (2*%pi*%i*2/Fs*[1:n]);
  set(gca(),"auto_clear","off")  // hold on;
 pyulear (signal, 3, [], Fs);
 pyulear (signal, 4, [], Fs, "whole");
 pyulear (signal, 5, 128, Fs, "shift", "semilogy");
 pyulear (skewed, 7, 128, Fs, "shift", "semilogy");
 user_freq = [-0.2:0.02:0.2]*Fs;
 pyulear (skewed, 7, user_freq, Fs, "semilogy"); // bug in ar_psd can't handle vector of user freqs while no issue with scalar . 
 //hold off;
*/
