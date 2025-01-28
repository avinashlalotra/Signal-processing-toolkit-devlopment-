function freqz_plot (w, h, freq_norm)
  if (nargin < 2)
    error("Invalid numbers of inputs");
  end

  if nargin < 3 then
    freq_norm = %f 
  end
  n = size(max(w));
  mag = 20 * log10 (abs (h));
  phase = unwrap2 (angle (h));

  if (freq_norm)
    x_label = 'Normalized Frequency (\times\pi rad/sample)';
  else
    x_label = "Frequency (Hz)";
  end
  subplot (2, 1, 1);
  plot (w, mag);
  xgrid;
  xlabel (x_label);
  ylabel ("Magnitude (dB)");

  subplot (2, 1, 2);
  plot (w, phase*360/(2*%pi));
  xgrid;
  xlabel (x_label);
  ylabel ("Phase (degrees)");

endfunction
/*

Working fine 

*/
