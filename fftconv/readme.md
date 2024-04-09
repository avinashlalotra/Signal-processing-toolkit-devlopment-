
## fftconv
## Description
Convolve two vectors using the FFT for computation
## Calling Sequence
- `fftconv(x,y)`
- `fftconv(x,y,n)`

## Parameters
`x` : A Vector 

`y` : A Vector

`n` : (optional) n is an integer

## Details
c = fftconv (x, y) returns a vector of length equal to length (x) + length (y) - 1. 
If x and y are the coefficient vectors of two polynomials, 
the returned value is the coefficient vector of the product polynomial.

If the optional argument n is specified, an N-point FFT is used.

