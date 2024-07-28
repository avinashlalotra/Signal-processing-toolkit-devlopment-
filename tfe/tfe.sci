/*2024 Author: Abinash Singh <abinashsinghlalotra@gmail.com>*/
/*
Dependency : pwelch
Calling Sequence:
    [Pxx,freq] = tfe(x,y,Nfft,Fs,window,overlap,range,plot_type,detrend)
        Estimate transfer function of system with input "x" and output "y".
        Use the Welch (1967) periodogram/FFT method.
        Compatible with Matlab R11 tfe and earlier.
        See "help pwelch" for description of arguments, hints and references — especially hint (7) for Matlab R11 defaults.*/
function varargout = tfe(varargin)
    nargout = argn (1)
    nargin = argn(2)
    // Check fixed argument
    if ( nargin<2 )
      error( 'tfe: Need at least 2 args. Use help tfe.' );
    end
    nvarargin = max(size(varargin));
    // remove any pwelch RESULT args and add 'trans'
    for iarg=1:nvarargin
      arg = varargin(iarg);
      if ( ~isempty(arg) && type(arg) == [10 ] && ( ~strcmp(arg,'power') || ...
             ~strcmp(arg,'cross') || ~strcmp(arg,'trans') || ...
             ~strcmp(arg,'coher') || ~strcmp(arg,'ypower') ))
        varargin(iarg) = [];
      end
    end
    varargin(nvarargin+1) = 'trans';
    //
    //disp(varargin)
    saved_compatib = pwelch('R11-');
    //disp(saved_compatib)
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
    pwelch(saved_compatib);
  endfunction
/*
//test case 1 
t = linspace(0,10,1000); x =sin(t);y=cos(t);
tfe(x,y)
//test case 2
tfe(t,x)
tfe(t,y)
//test case 3
t = linspace(1,10,1000); x =sin(t);
y = filter(0.23,x,t);
tfe(x,y)
//testcase 4
t = linspace(1,10,1000); x =cos(t);
y = filter(0.9999,x,t);
tfe(x,y)
//test case 5
t = linspace(1,10,1000); x =filter(0.3245,cos(t),t); y = filter(0.0034,x,sin(t));
tfe(x,y)
*/    
