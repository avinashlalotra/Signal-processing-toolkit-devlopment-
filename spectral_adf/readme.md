#  spectral_adf
## Calling Sequence

- ` spectral_adf (c) `
- ` spectral_adf (c, win) `
- ` spectral_adf (c, win, b) `

## Description
Return the spectral density estimator given a vector of autocovariances c, window name win, and bandwidth, b.

The window name, e.g., "triangle" or "rectangle" is used to search for a function called win_lw.

If win is omitted, the triangle window is used.

If b is omitted, 1 / sqrt (length (x)) is used.

### Dependencies: 
fft1 


-
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
