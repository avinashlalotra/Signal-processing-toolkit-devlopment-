
// @example
//       B = [1/2 1];
//       A = [1 1];
//       w = linspace(0,4,128);
//       H = freqs(B,A,w);
//       [Bh,Ah] = invfreqs(H,w,1,1);
//       Hh = freqs(Bh,Ah,w);
//       plot(w,[abs(H);abs(Hh)])
//       legend('Original','Measured');
//       err = norm(H-Hh);
//       disp(sprintf('L2 norm of frequency response error = %f',err));
// @end example
// @end deftypefn

// FIXME: check invfreq.sci for todo's

function [B, A, SigN] = invfreqs(H,F,nB,nA,W,iter,tol,tr, varargin)

  if nargin < 9
    varargin = {};
    if nargin < 8
      tr = '';
      if nargin < 7
        tol = [];
        if nargin < 6
          iter = [];
          if nargin < 5
            W = ones(1,length(F));
          end
        end
      end
    end
  end

  // now for the real work
  [B, A, SigN] = invfreq(H, F,nB, nA, W, iter, tol, tr, 's', varargin);

endfunction
/*
demo
// octave 

 B = [1 0 0];
 A = [1 6 15 15]/15;
 w = linspace(0, 8, 128);
 H0 = freqz(B, A, w);
 Nn = (randn(size(w))+j*randn(size(w)))/sqrt(2);
 order = length(A) - 1;
 [Bh, Ah, Sig0] = invfreqs(H0, w, [length(B)-1 2], length(A)-1);
 Hh = freqz(Bh,Ah,w);
 [BLS, ALS, SigLS] = invfreqs(H0+1e-5*Nn, w, [2 2], order, [], [], [], [], "method", "LS");
 HLS = freqz(BLS, ALS, w);
 [BTLS, ATLS, SigTLS] = invfreqs(H0+1e-5*Nn, w, [2 2], order, [], [], [], [], "method", "TLS");
 HTLS = freqs(BTLS, ATLS, w);
 [BMLS, AMLS, SigMLS] = invfreqs(H0+1e-5*Nn, w, [2 2], order, [], [], [], [], "method", "QR");
 HMLS = freqz(BMLS, AMLS, w);
 plot(w,[abs(H0); abs(Hh)])
 xlabel("Frequency (rad/sec)");
 ylabel("Magnitude");
 legend('Original','Measured');
 err = norm(H0-Hh);
 disp(sprintf('L2 norm of frequency response error = %f',err));
 
 // scilab passed
 B = [1 0 0];
 A = [1 6 15 15]/15;
 w = linspace(0, 8, 128);
 [H0 ,_ ] = freqz(B, A, w);
 Nn = (rand(size(w,1),size(w,2),'normal')+%i*rand(size(w,1),size(w,2),'normal'))/sqrt(2);
 order = length(A) - 1;
 [Bh, Ah, Sig0] = invfreqs(H0, w, [length(B)-1 2], length(A)-1);
 [Hh ,_ ] = freqz(Bh,Ah,w);
 [BLS, ALS, SigLS] = invfreqs(H0+1e-5*Nn, w, [2 2], order, [], [], [], [], "method", "LS");
 [HLS,_] = freqz(BLS, ALS, w);
 [BTLS, ATLS, SigTLS] = invfreqs(H0+1e-5*Nn, w, [2 2], order, [], [], [], [], "method", "TLS");
 [HTLS,_] = freqs(BTLS, ATLS, w);
 [BMLS, AMLS, SigMLS] = invfreqs(H0+1e-5*Nn, w, [2 2], order, [], [], [], [], "method", "QR");
 [HMLS,_] = freqz(BMLS, AMLS, w);
 plot(w,[abs(H0); abs(Hh)])
 xlabel("Frequency (rad/sec)");
 ylabel("Magnitude");
 legend('Original','Measured');
 err = norm(H0-Hh);
 disp(sprintf('L2 norm of frequency response error = %f',err));
 

*/
