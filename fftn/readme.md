


# fftn: N-Dimensional Fast Fourier Transform
This document describes the fftn function, which calculates the N-dimensional discrete Fourier transform (DFT) 
of an input array using a Fast Fourier Transform (FFT) algorithm.

## Syntax
-`Y=fftn(A)`

-`Y = fftn(A, size)`
### Parameters:

-`A` : The input array for which the Fourier transform is to be computed.

-`size` (optional): A vector specifying the desired dimensions of the output array Y.

### Details
`fftn(A)` computes the N-dimensional DFT along each dimension of the input array A.

`fftn(A, size)` allows you to specify the desired output size before computing the DFT.

If any element in size is smaller than the corresponding dimension of A, that dimension will be truncated before the FFT.

Conversely, if any element in size is larger, A will be resized and padded with zeros to match the specified size.
### Usage
Example 1: Computing the DFT without resizing
```scilab
original_array = ...  # Your N-dimensional data\
transformed_array = fftn(original_array)\
```
This computes the DFT of original_array using its original dimensions.

Example 2: Computing the DFT with resizing
```scilab
original_array = ...  # Your N-dimensional data\
desired_size = (...)  # Target dimensions for the output\
transformed_array = fftn(original_array, desired_size)
```
This computes the DFT of original_array after resizing it to match the elements specified in desired_size.
Dimensions smaller than the original array will be truncated, and larger dimensions will be padded with zeros.
