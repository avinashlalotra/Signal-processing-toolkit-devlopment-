#  fwhm
## Description
- `f = fwhm(y)` : Compute peak Full-Width at Half Maximum (FWHM) for vector or matrix data y.
- `f = fwhm(x, y)'` : Compute FWHM for vector or matrix data y, optionally sampled as y(x).
- `f = fwhm(..., "zero")` :Compute FWHM at half maximum (0.5 * max(y)).
- `f = fwhm(..., "min") ` : Compute FWHM at middle curve (0.5 * (min(y) + max(y))).
- `f = fwhm(..., "alevel", level)` :Compute FWHM at given absolute level of y.
- `f = fwhm(..., "rlevel", level)` : Compute FWHM at given relative level of peak profile.
Return 0 if FWHM does not exist (e.g. monotonous function or does not intersect specified level).

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
