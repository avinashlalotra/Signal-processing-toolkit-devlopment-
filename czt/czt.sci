/*2024 
Author: Abinash Singh <abinashsinghlalotra@gmail.com>
*/
/*
Chirp Z Transform
    Calling Sequence
        czt (x)
        czt (x, m)
        czt (x, m, w)
        czt (x, m, w, a)
    Parameters 
        x: Input scalar or vector
        m: Total Number of steps
        w: ratio between points in each step
        a: point in the complex plane 
    Description
        Chirp z-transform. Compute the frequency response starting at a and stepping by w for m steps. a is a point in the complex plane, 
        and w is the ratio between points in each step (i.e., radius increases exponentially, and angle increases linearly).
    Examples
        m = 32;                               ## number of points desired
        w = exp(-j*2*%pi*(f2-f1)/((m-1)*Fs));  ## freq. step of f2-f1/m
        a = exp(j*2*%pi*f1/Fs);                ## starting at frequency f1
        y = czt(x, m, w, a);
*/
function y = czt(x, m, w, a)
    funcprot(0);
    nargin=argn(2);
    if nargin < 1 || nargin > 4 then
        error("Please input valid number of arguments");
    end
    [row, col] = size(x);
    if row == 1 then
        x = x(:); col = 1;
    end
    if nargin < 2 || isempty(m) then
        m = length(x(:,1));
    end
    if length(m) > 1 then
        error("czt: m must be a single element\n");
    end
    if nargin < 3 || isempty(w) then
        w = exp(-2*%i*%pi/m);
    end
    if nargin < 4 || isempty(a) then
        a = 1;
    end
    if length(w) > 1 then
        error("czt: w must be a single element\n");
    end
    if length(a) > 1 then
        error("czt: a must be a single element\n");
    end
    // indexing to make the statements a little more compact
    n = length(x(:,1));
    N = [0:n-1]'+n;
    NM = [-(n-1):(m-1)]'+n;
    M = [0:m-1]'+n;
    nfft = 2^nextpow2(n+m-1); // fft pad
    W2 = w.^(([-(n-1):max(m-1,n-1)]'.^2)/2); // chirp
    for idx = 1:col
        fg = fft1(x(:,idx).*(a.^-(N-n)).*W2(N), nfft);
        fw = fft1(1./W2(NM), nfft);
        gg = ifft1(fg.*fw, nfft);
        y(:,idx) = gg(M).*W2(M);
    end
    if row == 1, y = y.';
    end
    y = clean ( y ) ;
endfunction

