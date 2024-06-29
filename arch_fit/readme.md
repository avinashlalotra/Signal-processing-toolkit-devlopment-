#  arch_fit
## Calling Sequence

- ` [a, b] = arch_fit (y, x, p) `
- ` [a, b] = arch_fit (y, x, p, iter, gamma, a0, b0) `

## Description
Fit an ARCH regression model to the time series y using the scoring algorithm in Engle’s original ARCH paper.

The model is

y(t) = b(1) * x(t,1) + … + b(k) * x(t,k) + e(t),
h(t) = a(1) + a(2) * e(t-1)^2 + … + a(p+1) * e(t-p)^2
in which e(t) is N(0, h(t)), given a time-series vector y up to time t-1 and a matrix of (ordinary) regressors x up to t. The order of the regression of the residual variance is specified by p.

If invoked as arch_fit (y, k, p) with a positive integer k, fit an ARCH(k, p) process, i.e., do the above with the t-th row of x given by

[1, y(t-1), …, y(t-k)]
Optionally, one can specify the number of iterations iter, the updating factor gamma, and initial values a0 and b0 for the scoring algorithm.

### Dependencies: 
ols


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
