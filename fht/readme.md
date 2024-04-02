# fht: Fast Hartley Transform Function 

## Description

## Calling sequences
There are three ways to call the fht function:

- `fht(d)`

- `fht(d, n)`

- `fht(d, n, dim)`
# Parameters:

- `d` : The real input array or matrix for which the FHT is to be computed.

- `n` (optional): A positive integer specifying the desired output size along each dimension (similar to the fft function).

If not provided, the original size of d is used.

If n is larger than the dimension along which the FHT is calculated, d is resized and padded with zeros.

If n is smaller, d is truncated.

- `dim` (optional): An integer specifying the dimension along which to perform the FHT.

By default, the transform is computed along columns (dim=1) for matrices.

# Details
The fht function calculates the FHT of the real input d.

If d is a matrix, the FHT is computed along the columns by default (similar to dim=1).

The n and dim parameters allow you to control the output size and transformation direction.

n: Specifying n allows you to zero-pad or truncate the output to a desired size.

dim: Setting dim to a specific value performs the FHT along that particular dimension.

## Examples
1. FHT of a 1D array (default)
```scilab

data = [1, 2, 3, 4];

transformed_data = fht(data);
```

This computes the FHT of the 1D array data.

2. FHT of a matrix along rows (specifying dim)

```scilab
matrix = [ [1, 2], [3, 4] ];

transformed_matrix = fht(matrix, dim=2);
```
This computes the FHT of the matrix matrix along the rows (dimension 2).

3. FHT with zero-padding (using n)
```scilab

original_array = [5, 6, 7];

desired_size = 8;

transformed_array = fht(original_array, desired_size);
```

This computes the FHT of original_array and zero-pads the output to a size of 8 elements. 

