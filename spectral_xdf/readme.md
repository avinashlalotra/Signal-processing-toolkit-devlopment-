# spectral_xdf
## Calling Sequence

- `spectral_xdf (x)`
- `spectral_xdf (x, win)`
- `spectral_xdf (x, win, b)`

## Description
Return the spectral density estimator given a data vector x, window name win, and bandwidth, b.

The window name, e.g., "triangle" or "rectangle" is used to search for a function called win_sw.

If win is omitted, the triangle window is used.

If b is omitted, 1 / sqrt (length (x)) is used.

### Dependencies: 
fft1 ifft1

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
