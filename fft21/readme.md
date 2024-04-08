# Function: fft21

## Description
Compute the two-dimensional discrete Fourier transform of a Matrix using the Fast Fourier Transform (FFT) algorithm.

## Calling Sequence:
- `fft21(A)`
- `fft21(A,m,n)`
## Parameters 
-`A` : Input Matrix

-`m` : number of rows of A to be used 

-`n` : number of columns of A to be used

 You can use the variables m and n to specify the number of rows and columns of A that you want to use. If either of these variables is larger than the size of A, then A will be resized, and zeros will be added as padding. If A is a multi-dimensional matrix, the function will treat each two-dimensional sub-matrix of A separately.

## Examples
1.
```scilab
A=[500 3000;200 4000];
fft21(A);
```
```output
ans  =

   7700.  -6300.
  -700.    1300.
```
2.
```scilab
A=[12 67 48;89 2 1;965 4 231;56 32 19];
m=2;
n=2;
fft21(A,m,n);
```
```output
 ans  =

   170.   32. 
  -12.   -142.
```

