# ifft1
## Description
Compute the inverse discrete Fourier transform of A using a Fast Fourier Transform (FFT) algorithm.
The inverse FFT is calculated along the first non-singleton dimension of the array.
 ## Parameters
`x` : input matrix

`n` : Specifies the number of elements of x to be used

`dim` : Specifies the dimention of the matrix along which the inverse FFT is performed

## Calling Sequence
- `ifft1(x)` : 
  
- `ifft1(x,n)`:
 - `ifft1(x,n,dim)`

    
 fft (x) computes the inverse FFT for each column of x.
 
 If called with two arguments, n is expected to be an integer specifying the number
 of elements of x to use, or an empty matrix to specify that its value should be ignored. 
 If n is larger than the dimension along which the inverse FFT is calculated, then x is resized and padded with zeros.
 Otherwise, if n is smaller than the dimension along which the inverse FFT is calculated, then x is truncated.
 
 If called with three arguments, dim is an integer specifying the dimension of the matrix along which the inverse FFT is performed


 
