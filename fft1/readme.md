# Function: fft1

## Description:
Calculates the discrete Fourier transform of a matrix using the Fast Fourier Transform (FFT) algorithm. By default, the FFT is computed along the first non-singleton dimension of the input matrix, effectively performing the FFT operation on each column of the matrix.

## Calling Sequence:
- `fft1(x)`
- `fft1(x, n)`
- `fft1(x, n, dim)`

## Parameters:
- `x`: Input matrix for which the discrete Fourier transform is to be calculated.
- `n` (optional): Specifies the number of elements of x to be used in the computation. If n is larger than the dimension along which the FFT is calculated, x is resized and padded with zeros. If n is smaller, x is truncated.
- `dim` (optional): Specifies the dimension of the matrix along which the FFT is performed. By default, the FFT is computed along the first non-singleton dimension of the array.

## Returns:
- Matrix containing the discrete Fourier transform of the input matrix x.

## Examples:
1. DFT of a 2d array
```scilab
x = [1 2 3; 4 5 6; 7 8 9];
fft1(x);
```


```output
6.0000 +  0.0000i   -1.5000 +  0.8660i   -1.5000 -  0.8660i
15.0000 +  0.0000i   -1.5000 +  0.8660i   -1.5000 -  0.8660i
24.0000 +  0.0000i   -1.5000 +  0.8660i   -1.5000 -  0.8660i
```
2. DFT of a complex array
```scilab
x = [0 %pi 2+3*%i; 3+0.2*%i 2-0.3*%i 15+0.22*%i];
fft1(x);
```


```
3. + 0.2i   5.1415927 - 0.3i   17. + 3.22i
-3. - 0.2i   1.1415927 + 0.3i  -13. + 2.78i
```
3. DFT of a 3D array
```scilab
a=[8 6 0;9 6 2+%i;2 8 3];
a(:,:,2)=[700 388 267;908 321 678;12 23 78];
fft1(a,5,1);
```


``` output
(:,:,1)

         column 1 to 2

   19.      + 0.i          20.      + 0.i       
   9.163119 - 9.7350792i   1.381966 - 10.408621i
   1.336881 - 3.3879542i   3.618034 + 4.0817406i
   1.336881 + 3.3879542i   3.618034 - 4.0817406i
   9.163119 + 9.7350792i   1.381966 + 10.408621i

         column 3

   5.        + i         
  -0.8579605 - 3.3564518i
  -0.1031978 + 0.868582i 
  -1.2787683 - 2.486616i 
  -2.7600735 + 3.9744858i

(:,:,2)

         column 1 to 2

   1620.     + 0.i          732.      + 0.i       
   970.87923 - 870.61274i   468.58706 - 318.8082i 
  -30.879227 - 522.29633i   135.41294 - 166.80477i
  -30.879227 + 522.29633i   135.41294 + 166.80477i
   970.87923 + 870.61274i   468.58706 + 318.8082i 

         column 3

   1023.    + 0.i       
   413.4102 - 690.66357i
  -257.4102 - 324.33599i
  -257.4102 + 324.33599i
   413.4102 + 690.66357i
```
