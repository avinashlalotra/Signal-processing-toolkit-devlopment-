function [B, A, SigN] = invfreq(H, F, nB, nA, W, iter, tol, tr, plane, varargin)

  if max(size(nB)) > 1, zB = nB(2); nB = nB(1); else zB = 0; end
  n = max(nA, nB);
  m = n+1; mA = nA+1; mB = nB+1;
  nF = max(size(F));
  if nargin < 5 || isempty(W), W = ones(1, nF); end
  if nargin < 6, iter = []; end
  if nargin < 7  tol = []; end
  if nargin < 8 || isempty(tr), tr = ''; end
  if nargin < 9, plane = 'z'; end
  if nargin < 10, varargin = {}; end

  if ( strcmp (plane, "s") &&  strcmp (plane, "z"))
    error ("invfreq: invealid PLANE argument %s, expected  s  or  z ", plane)
  end

  fname = ["invfreq", plane];

  if (nF ~= max(size(H)))
    error ("%s: Length of H and F must be the same\n", fname)
  end

  if (~ isempty (iter) || ~ isempty (tol))
    warning (["%s: iterative algorithm not yet implemented, ", ...
              "ITER and TOL arguments are ignored\n"], fname);
  end
  disp("Checkpoint 1") // invfreq([%i 1+2*%i 0],[1 2 3],4,4) passed

 // Displaying the variables
  disp("H = "), disp(H)
  disp("F = "), disp(F)
  disp("nB = "), disp(nB)
  disp("nA = "), disp(nA)
  disp("W = "), disp(W)
  disp("iter = "), disp(iter)
  disp("tol = "), disp(tol)
  disp("tr = "), disp(tr)
  disp("plane = "), disp(plane)
  disp("varargin = "), disp(varargin)
  prop = varargin;
  // should we normalize freqs to avoid matrices with rank deficiency ?
  norm = %f;
  // by default, use Ordinary Least Square to solve normal equations
  method = 'LS';
  if max(size(prop)) > 0
    indi = 1; while indi <= max(size(prop))
      switch prop{indi}
        case 'norm'
          if (indi < max(size(prop)) && ~type(prop{indi+1}) == 10 )
            norm = logical(prop{indi+1});
            prop(indi:indi+1) = [];
            continue
          else
            norm = true; prop(indi) = [];
            continue
          end
        case 'method'
          if indi < max(size(prop)) && type(prop{indi+1}) == 10
            method = prop{indi+1};
            prop(indi:indi+1) = [];
            continue
          else
            error('invfreq.m: incorrect/missing method argument');
          end
        otherwise // FIXME: just skip it for now
          disp(sprintf("Ignoring unknown argument %s", varargin{indi}));
          indi = indi + 1;
      end
    end
    disp("Intermediate checkpoint")
    disp("norm"),disp(norm)
    disp("indi"),disp(indi)
    disp("method :"),disp(method)

  end
////////////////////////////////////////////////////////////////

  Ruu = zeros(mB, mB); Ryy = zeros(nA, nA); Ryu = zeros(nA, mB);
  Pu = zeros(mB, 1);   Py = zeros(nA,1);
  if ~strcmp(tr,'trace')
    disp(' ')
    disp('Computing nonuniformly sampled, equation-error, rational filter.');
    disp(['plane = ',plane]);
    disp(' ')
  end

  s = sqrt(-1)*F;
  switch plane
    case 'z' 
      if max(F) > %pi || min(F) < 0
        disp('hey, you frequency is outside the range 0 to %pi, making my own')
        F = linspace(0, %pi, max(size(H)));
        s = sqrt(-1)*F;
      end
      s = exp(-s);
    case 's'
      if max(F) > 1e6 && n > 5,
        if ~norm,
          disp('Be careful, there are risks of generating singular matrices');
          disp('Call invfreqs as (..., norm, true) to avoid it');
        else
          Fmax = max(F); s = sqrt(-1)*F/Fmax;
        end
      end
  end
  disp("Checkpoint 2 --------------------------------------------------------------")
  disp("Ruu"),disp(Ruu)
  disp("Pu") , disp(Pu)
  disp("s"),disp(s)
  if norm 
    disp("Fmax") ,disp(Fmax)
  end  
  //////////////////////////////
  for k=1:nF,
    Zk = (s(k).^[0:n]).';
    Hk = H(k);
    aHks = Hk*conj(Hk);
    Rk = (W(k)*Zk)*Zk';
    rRk = real(Rk);
    Ruu = clean(Ruu + rRk(1:mB, 1:mB));
    Ryy = Ryy + aHks*rRk(2:mA, 2:mA);
    Ryu = Ryu + real(Hk*Rk(2:mA, 1:mB));
    Pu = Pu + W(k)*real(conj(Hk)*Zk(1:mB));
    Py = Py + (W(k)*aHks)*real(Zk(2:mA));
  end
  Rr = ones(max(size(s)), mB+nA); Zk = s;
  for k = 1:min(nA, nB),
    Rr(:, 1+k) = Zk;
    Rr(:, mB+k) = -Zk.*H;
    Zk = Zk.*s;
  end
  for k = 1+min(nA, nB):max(nA, nB)-1,
    if k <= nB, Rr(:, 1+k) = Zk; end
    if k <= nA, Rr(:, mB+k) = -Zk.*H; end
    Zk = Zk.*s;
  end
  k = k+1;
  if k <= nB, Rr(:, 1+k) = Zk; end
  if k <= nA, Rr(:, mB+k) = -Zk.*H; end

  // complex to real equation system -- this ensures real solution
  Rr = Rr(:, 1+zB:$);
  Rr = [real(Rr); imag(Rr)]; Pr = [real(H(:)); imag(H(:))];
  // normal equations -- keep for ref
  // Rn= [Ruu(1+zB:mB, 1+zB:mB), -Ryu(:, 1+zB:mB)';  -Ryu(:, 1+zB:mB), Ryy];
  // Pn= [Pu(1+zB:mB); -Py];
  ////////////////////////////////////////////////
  disp("Checkpoint 3 Start----------------------------")
  disp("ZK"),disp(Zk) 
  disp("HK"),disp(Hk)// passed for //invfreq([%i 1+2*%i 0],[1 2 3],4,4)

  disp("aHks"),disp(aHks)
  disp("RK"),disp(Rk)
  disp("rRK"),disp(rRk)
  disp("Ruu"),disp(Ruu)
  disp("Ryy"),disp(Ryy)
  disp("Ryu"),disp(Ryu)
  disp("Pu"),disp(Pu)
  disp("Py"),disp(Py)
  disp("Rr"),disp(Rr)
  disp("Pr"),disp(Pr)
  disp("-------------------Checkpoint 3 complete---------------------------")
  disp("Method"),disp(method)
  switch method
    case {'ls' 'LS'}
      // avoid scaling errors with Theta = R\P;
      // [Q, R] = qr([Rn Pn]); Theta = R(1:$, 1:$-1)\R(1:$, $);
      [Q, R] = qr([Rr Pr]); Theta = pinv(R(1:$-1, 1:$-1)) * R(1:$-1, $);
      //////////////////////////////////////////////////
      //////////////////checkpoint for theta///////////
      disp("Checkpoint for theta --------------------------------------------")
      disp("R(1:end-1, 1:end-1)"),disp(R(1:$-1, 1:$-1)) //passed for //invfreq([%i 1+2*%i 0],[1 2 3],4,4)
      disp("R(1:end-1, end)"),disp(R(1:$-1,$))
      disp("-------------------------------------------------------------")
      /////////////////////checkpoint over/////////////
      // SigN = R($, $-1);
      SigN = R($, $);
      disp("Checkpoint: method ls ---------------------------------")
      disp("Q"),disp(Q)
      disp("R"),disp(R) //passed for //invfreq([%i 1+2*%i 0],[1 2 3],4,4)
      disp("Theta"),disp(Theta)
      disp("SigN"),disp(SigN)
      disp("Checkpoint method LS complete --------------------------")
    case {'tls' 'TLS'}
      // [U, S, V] = svd([Rn Pn]);
      // SigN = S($, $-1);
      // Theta =  -V(1:$-1, $)/V($, $);
      [U, S, V] = svd([Rr Pr], 0);
      SigN = S($, $);
      Theta =  -V(1:$-1, $)/V($, $);
    case {'mls' 'MLS' 'qr' 'QR'}
      // [Q, R] = qr([Rn Pn], 0);
      // solve the noised part -- DO NOT USE ECONOMY SIZE ~
      // [U, S, V] = svd(R(nA+1:$, nA+1:$));
      // SigN = S($, $-1);
      // Theta = -V(1:$-1, $)/V($, $);
      // unnoised part -- remove B contribution and back-substitute
      // Theta = [R(1:nA, 1:nA)\(R(1:nA, $) - R(1:nA, nA+1:$-1)*Theta)
      //         Theta];
      // solve the noised part -- economy size OK as #rows > #columns
      [Q, R] = qr([Rr Pr], 0);
      eB = mB-zB; sA = eB+1;
      [U, S, V] = svd(R(sA:$, sA:$));
      // noised (A) coefficients
      Theta = -V(1:$-1, $)/V($, $);
      // unnoised (B) part -- remove A contribution and back-substitute
      Theta = [R(1:eB, 1:eB)\(R(1:eB, $) - R(1:eB, sA:$-1)*Theta)
               Theta];
      SigN = S($, $);
    otherwise
      error("invfreq: unknown method %s", method);
  end

  B = [zeros(zB, 1); Theta(1:mB-zB)].';
  A = [1; Theta(mB-zB+(1:nA))].';
  disp("Checkpoint B A I ------start ----------------------")
  disp("B"),disp(B)
  disp("A"),disp(A)
  disp("Checkpoint B A I --------complete ------------------")
  if ~strcmp(plane,'s')
    B = B(mB:-1:1);
    A = A(mA:-1:1);
    if norm, // Frequencies were normalized -- unscale coefficients
      Zk = Fmax.^[n:-1:0].';
      for k = nB:-1:1+zB, B(k) = B(k)/Zk(k); end
      for k = nA:-1:1, A(k) = A(k)/Zk(k); end
    end
  end
endfunction
