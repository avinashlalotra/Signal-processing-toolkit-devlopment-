// Impulse invariant conversion from s to z domain
function [b_out, a_out] = invimpinvar (b_in, a_in, fs, tol)

  if (nargin <2)
    error("invimpinvar: Insufficient input arguments");
  end

  if nargin < 3 then fs = 1; end
  if nargin < 4 then tol = 0.0001; end
  // to be compatible with the matlab implementation where an empty vector can
  // be used to get the default
  if (isempty(fs))
    ts = 1;
  else
    ts = 1/fs; // we should be using sampling frequencies to be compatible with Matlab
  end

  b_in = [b_in 0]; // so we can calculate in z instead of z^-1

  [r_in, p_in, k_in] = residue(b_in, a_in); // partial fraction expansion
  
  // clean r_in for zero values
  n = length(r_in); // Number of poles/residues

  if (length(k_in) > 1) // Greater than one means we cannot do impulse invariance
    error("Order numerator > order denominator");
  end

  r_out  = zeros(1,n); // Residues of H(s)
  sm_out = zeros(1,n); // Poles of H(s)

  i=1;
  while (i<=n)
    m=1;
    first_pole = p_in(i); // Pole in the z-domain
    while (i<n && abs(first_pole-p_in(i+1))<tol) // Multiple poles at p(i)
      i=i+1; // Next residue
      m=m+1; // Next multiplicity
    end

    // Checkpoint for input arguments of inv_z_res
    disp("Starting checkpoint for input arguments of inv_z_res");
    disp("Residues (r_in):");
    disp(r_in(i-m+1:i));
    disp("Pole (first_pole):");
    disp(first_pole);
    disp("Sampling time (ts):");
    disp(ts);
    disp("Closing checkpoint for input arguments of inv_z_res");


    [r, sm, k]= inv_z_res(r_in(i-m+1:i), first_pole, ts); // Find s-domain residues

    disp("Starting checkpoint for output arguments of inv_z_res");
    disp("Residues (r):");
    disp(r);
    disp("Poles (sm):");
    disp(sm);
    disp("Constant term (k):");
    disp(k);
    disp("Closing checkpoint for output arguments of inv_z_res");

    k_in            = k_in - k;                                        // Just to check, should end up zero for physical system
    sm_out(i-m+1:i) = sm;                                       // Copy s-domain pole(s) to output
    r_out(i-m+1:i)  = r;                                        // Copy s-domain residue(s) to output

    i=i+1; // Next z-domain residue/pole
  end

  // Checkpoint for input arguments of inv_residue
  disp("Starting checkpoint for input arguments of inv_residue");
  disp("Residues (r_out):");
  disp(r_out);
  disp("Poles (sm_out):");
  disp(sm_out);
  disp("Closing checkpoint for input arguments of inv_residue");

  [b_out, a_out] = inv_residue(r_out, sm_out , 0, tol);
  a_out          = to_real(a_out);      // Get rid of spurious imaginary part
  b_out          = to_real(b_out);

  b_out          = polyreduce(b_out);

endfunction

// Inverse function of z_res (see impinvar source)

function [r_out, sm_out, k_out] = inv_z_res (r_in,p_in,ts)

  n    = length(r_in); // multiplicity of the pole
  r_in = r_in.';       // From column vector to row vector

  j=n;
  while (j>1) // Go through residues starting from highest order down
    r_out(j)   = r_in(j) / ((ts * p_in)^j);                   // Back to binomial coefficient for highest order (always 1)
    r_in(1:j) = r_in(1:j) - r_out(j) * polyrev(h1_z_deriv(j-1,p_in,ts)); // Subtract highest order result, leaving r_in(j) zero
    j=j-1;
  end

  // Single pole (no multiplicity)
  r_out(1) = r_in(1) / ((ts * p_in));
  k_out    = r_in(1) / p_in;
  sm_out   = log(p_in) / ts;
endfunction

/*
// tests passed
[b_out,a_out]=invimpinvar([1],[1 -0.5],0.01) 
[b_out,a_out]=invimpinvar([1],[1 -1 0.25],0.01)
[b_out,a_out]=invimpinvar([1 1],[1 -1 0.25],0.01)
[b_out,a_out]=invimpinvar([1],[1 -1.5 0.75 -0.125],0.01)
[b_out,a_out]=invimpinvar([1 1],[1 -1.5 0.75 -0.125],0.01)
[b_out,a_out]=invimpinvar([1],[1 0 0.25],0.01)


// FIXME : built in filter doesn't support complex parameters
// [b_out,a_out]=invimpinvar([1 1],[1 0 0.25],0.01)
// [b_out,a_out]=invimpinvar([1],[1 0 0.5 0 0.0625],0.01)
// [b_out,a_out]=invimpinvar([1 1],[1 0 0.5 0 0.0625],0.01)
// [b_out,a_out]=invimpinvar([1 1 1],[1 0 0.5 0 0.0625],0.01
// [b_out,a_out]=invimpinvar([1 1 1 1],[1 0 0.5 0 0.0625],0.01)

*/
