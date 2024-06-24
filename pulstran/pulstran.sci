function y = pulstran(t, d, pulse, varargin)
  nargin= argn(2)
  if nargin<3 || (~( type(pulse) == 10 ) & nargin>5)
    error("Invalid number of inputs");
  end
  y = zeros(size(t));
  if isempty(y), return; end
  if size(d,1) == 1, d=d'; end
  if size(d,2) == 2,
    a=d(:,2);
  else
    a=ones(size(d,1),1);
  end
  if (type(pulse) ==10 )
    // apply function t+d for all d
    for i=1:size(d,1)
      y = y+a(i)*feval(pulse,t-d(i,1),varargin{:});
    end
  else
    // interpolate each pulse at the specified times
    Fs = 1; method = 'linear';
    if nargin==4
      arg=varargin{1};
      if type(arg)==10,
        method=arg;
      else
        Fs = arg;
      end
    elseif nargin==5
      Fs = varargin{1};
      method = varargin{2};
    end
    span = (max(size(pulse))-1)/Fs;
    t_pulse = (0:(max(size(pulse)))-1)/Fs;
    for i=1:size(d,1)
      dt = t-d(i,1);
      idx = find(dt>=0 & dt<=span);
      y(idx) = y(idx) + a(i)*interp1(t_pulse, pulse, dt(idx), method);
    end
  end

endfunction
