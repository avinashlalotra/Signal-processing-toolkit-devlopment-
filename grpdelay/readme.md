#  grpdelay
## Description
Compute the group delay of a filter.
Group delay, g(w) = -d/dw [arg{H(e^jw)}], is the rate of change of phase with respect to frequency. It can be computed as:

              d/dw H(e^-jw)
       g(w) = -------------
                H(e^-jw)
where

        H(z) = B(z)/A(z) = sum(b_k z^k)/sum(a_k z^k).
By the quotient rule,

                   A(z) d/dw B(z) - B(z) d/dw A(z)
       d/dw H(z) = -------------------------------
                              A(z) A(z)
Substituting into the expression above yields:

               A dB - B dA
       g(w) =  ----------- = dB/B - dA/A
                   A B
Note that,

       d/dw B(e^-jw) = sum(k b_k e^-jwk)
       d/dw A(e^-jw) = sum(k a_k e^-jwk)
which is just the FFT of the coefficients multiplied by a ramp.
### Dependencies: 
fft1 
## Calling Sequence  and Parameters
- `[g, w] = grpdelay (b) `
- `[g, w] = grpdelay (b, a) `
- `[g, w] = grpdelay (…, n) `
- `[g, w] = grpdelay (…, n, "whole") `
- `[g, f] = grpdelay (…, n, Fs) `
- `[g, f] = grpdelay (…, n, "whole", Fs) `
- `[g, w] = grpdelay (…, w) `
- `[g, f] = grpdelay (…, f, Fs) `
[g, w] = grpdelay(b) returns the group delay g of the FIR filter with coefficients b. The response is evaluated at 512 angular frequencies between 0 and pi. w is a vector containing the 512 frequencies. The group delay is in units of samples. It can be converted to seconds by multiplying by the sampling period (or dividing by the sampling rate fs).

[g, w] = grpdelay(b,a) returns the group delay of the rational IIR filter whose numerator has coefficients b and denominator coefficients a.

[g, w] = grpdelay(b,a,n) returns the group delay evaluated at n angular frequencies. For fastest computation n should factor into a small number of small primes.

[g, w] = grpdelay(b,a,n,’whole’) evaluates the group delay at n frequencies between 0 and 2*pi.

[g, f] = grpdelay(b,a,n,Fs) evaluates the group delay at n frequencies between 0 and Fs/2.

[g, f] = grpdelay(b,a,n,’whole’,Fs) evaluates the group delay at n frequencies between 0 and Fs.

[g, w] = grpdelay(b,a,w) evaluates the group delay at frequencies w (radians per sample).

[g, f] = grpdelay(b,a,f,Fs) evaluates the group delay at frequencies f (in Hz).

grpdelay(...) plots the group delay vs. frequency.

If the denominator of the computation becomes too small, the group delay is set to zero. (The group delay approaches infinity when there are poles or zeros very close to the unit circle in the z plane.)

## Examples
1. 
```scilab

```
```output

    ```

2.
```scilab
 
```
```output


```
3.
```scilab

```
```output

```
4.
```scilab


```
```output


```
5.
```scilab


```
```output



```
