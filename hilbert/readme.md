# hilbert
## Description
Analytic extension of real valued signal.


## Calling Sequence  and  Parameters

- `   h = hilbert (f) `  
- `   h = hilbert (f, N) `
- `   h = hilbert (f, N, dim) `
h = hilbert (f) computes the extension of the real valued signal f to an analytic signal. If f is a matrix, the transformation is applied to each column. For N-D arrays, the transformation is applied to the first non-singleton dimension.

real (h) contains the original signal f. imag (h) contains the Hilbert transform of f.

hilbert (f, N) does the same using a length N Hilbert transform. The result will also have length N.

hilbert (f, [], dim) or hilbert (f, N, dim) does the same along dimension dim.
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
