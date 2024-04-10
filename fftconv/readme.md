## fftconv
## Description
Convolve two vectors using the FFT for computation
## Calling Sequence
- `fftconv(x,y)`
- `fftconv(x,y,n)`

## fftconv
## Description
Convolve two vectors using the FFT for computation
## Calling Sequence
- `fftconv(x,y)`
- `fftconv(x,y,n)`

## Parameters
`x` : A Vector 

`y` : A Vector

`n` : (optional) 

## Details
c = fftconv (x, y) returns a vector of length equal to length (x) + length (y) - 1. 
If x and y are the coefficient vectors of two polynomials, 
the returned value is the coefficient vector of the product polynomial.

If the optional argument n is specified, an N-point FFT is used.
## Examples
1.
```scilab
fftconv([1 2 3],[4  5 6]);
```
```output
 ans  =

   4.   13.   28.   27.   18.
```
2.
```scilab
fftconv([%i %pi 2],[%pi %i],1);
```
```output
ans  =

         column 1 to 3

   0. + 3.1415927i   8.8696044 + 3.140D-16i   6.2831853 + 3.1415927i

         column 4

   0. + 2.i
```

