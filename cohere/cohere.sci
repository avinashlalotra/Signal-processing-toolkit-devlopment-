function varargout = cohere(varargin)
      if ( nargin<2 )
        error( 'cohere: Need at least 2 args. Use help cohere.' );
      end
      nvarargin = length(varargin);
      // remove any pwelch RESULT args and add 'trans'
      for iarg=1:nvarargin
        arg = varargin(iarg);
        if ( ~isempty(arg) && (type(arg)== 10) && ( ~strcmp(arg,'power') || ...
               ~strcmp(arg,'cross') || ~strcmp(arg,'trans') || ...
               ~strcmp(arg,'coher') || ~strcmp(arg,'ypower') ))
          varargin(iarg) = [];
        end
      end
      varargin(nvarargin+1) = 'coher';
      
      saved_compatib = pwelch('R11-');
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
      saved_compatib = 0;
    endfunction