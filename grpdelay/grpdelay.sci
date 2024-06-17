function [gd,w] = grpdelay (b, a, nfft, whole, Fs)
    lhs=argn(1);
    rhs= argn(2);
    if (rhs < 1 | rhs > 5) then
        error("Invalid number of inputs")
    end
    HzFlag= %F;
    
    select rhs
     case 1 then
         Fs=1; whole = "" ; nfft = 512 ; a = 1 ; 
     case 2 then
         Fs=1; whole = "" ; nfft = 512 ;  
     case 3 then
         Fs=1; whole = "" ;
     case 4 then
         Fs=1;
    end
   if (max(size(nfft)) > 1)
    if (rhs > 4)
      error("invalid inputs");
    elseif (rhs > 3)
      // grpdelay (B, A, F, Fs)
      Fs     = whole;
      HzFlag = true;
    else
      // grpdelay (B, A, W)
      Fs = 1;
    end
    w     = 2*%pi*nfft/Fs;
    nfft  = length (w) * 2;
    whole = "";
  else
    if (rhs < 5)
      Fs = 1; // return w in radians per sample
      if (rhs < 4)
          whole = "" ;
      elseif (type(whole)==10)
        Fs      = whole;
        HzFlag  = %T;
        whole   = "";
      end
      if (rhs < 3)
        nfft = 512;
      end
      if (rhs < 2)
        a = 1;
      end
    else
      HzFlag = %T;
    end

    if (isempty (nfft))
      nfft = 512;
    end
    if ( strcmp (whole, "whole"))
      nfft = 2*nfft;
    end
    w = Fs*[0:nfft-1]/nfft;
  end

  if (~ HzFlag)
    w = w * 2 * %pi;
  end
    a = a(:).';
    b = b(:).';
    oa = max(size(a)) -1;     // order of a(z)
    if (oa < 0)             // a can be []
      a  = 1;
      oa = 0;
    end
    ob = max(size(b)) -1;     // order of b(z)
    if (ob < 0)             // b can be [] as well
      b  = 1;
      ob = 0;
    end
    oc = oa + ob;           // order of c(z)
    c   = conv (b, flipdim(conj (a),2));  // c(z) = b(z)*conj(a)(1/z)*z^(-oa)
    cr  = c.*(0:oc);                    // cr(z) = derivative of c wrt 1/z
    num = fft1 (cr, nfft);
    den = fft1 (c, nfft);
    minmag    = 10*%eps;
    polebins  = find (abs (den) < minmag);
  for b = polebins
      warning ("signal:grpdelay-singularity", "grpdelay: setting group delay to 0 at singularity");
      num(b) = 0;
      den(b) = 1;
      //// try to preserve angle:
      //// db = den(b);
      //// den(b) = minmag*abs(num(b))*exp(j*atan2(imag(db),real(db)));
      //// warning(sprintf('grpdelay: den(b) changed from %f to %f',db,den(b)));
    end
    gd = real (num ./ den) - oa;
  
    if ( strcmp (whole, "whole"))
      ns = nfft/2; // Matlab convention ... should be nfft/2 + 1
      gd = gd(1:ns);
      w  = w(1:ns);
    else
      ns = nfft; // used in plot below
    end
  
    //// compatibility
    gd = gd(:);
    w  = w(:);
    if (lhs == 1)
      if (HzFlag)
        funits = "Hz";
      else
        funits = "radian/sample";
      end
      disp(" Plotting ")
      plot (w(1:ns), gd(1:ns));
      xlabel (["Frequency (" funits ")"]);
      ylabel ("Group delay (samples)");
    
  end
endfunction
