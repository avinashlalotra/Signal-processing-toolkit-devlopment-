# pulstran
## Description
Generate the signal y=sum(func(t+d,...)) for each d. If d is a matrix of two columns, the first column is the delay d and the second column is the amplitude a, and y=sum(a*func(t+d)) for each d,a. Clearly, func must be a function which accepts a vector of times. Any extra arguments needed for the function must be tagged on the end.
## Calling Sequence

- `Fy = pulstran (t, d, func, …) `
- `y = pulstran (t, d, p) `
- `y = pulstran (t, d, p, Fs) `
- `y = pulstran (t, d, p, Fs, method) `

If instead of a function name you supply a pulse shape sampled at frequency Fs (default 1 Hz), an interpolated version of the pulse is added at each delay d. The interpolation stays within the the time range of the delayed pulse. The interpolation method defaults to linear, but it can be any interpolation method accepted by the function interp1.
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
