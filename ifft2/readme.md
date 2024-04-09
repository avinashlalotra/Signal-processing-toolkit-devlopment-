
# Function:  ifft2

## Description
Compute the inverse two-dimensional discrete Fourier transform of A using a Fast Fourier Transform (FFT) algorithm.

## Calling Sequence
- `ifft2 (A)`
- `ifft2 (A, m, n)`

## Parameters
- `A` : Input matrix for which the inverse two-dimensional discrete Fourier transform is to be calculated.
- `m,n`: The optional arguments m and n may be used specify the number of rows and columns of A to use. If either of these is larger than the size of A, A is resized and padded with zeros.

If A is a multi-dimensional matrix, each two-dimensional sub-matrix of A is treated separately

## Examples:
1.
```scilab
A=[88 66 34;999 333 234];
ifft2(A);
```
```output
ans  =

   292.33333 + 0.i   125.58333 + 18.908221i   125.58333 - 18.908221i
  -229.66667 + 0.i  -112.91667 - 9.670617i   -112.91667 + 9.670617i 
```
2.
```scilab
A=[567 89 388; 93 4 80];
m=1;
n=4;
ifft2(A,m,n);
```
```output
ans  =

   261. + 0.i   44.75 + 22.25i   216.5 + 0.i   44.75 - 22.25i
```




