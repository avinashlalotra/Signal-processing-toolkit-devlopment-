#  arch_fit
## Calling Sequence

- ` [a, b] = arch_fit (y, x, p) `
- ` [a, b] = arch_fit (y, x, p, iter, gamma, a0, b0) `
##  Parameters
- `y`(vector) :  A time-series data vector up to time t-1 .
- `x` (Matrix):  A matrix of (ordinary) regressors x up to t.
- `p` (scalar):  The order of the regression of the residual variance.
- `iter` (scaler) : Number of iterations
- `gamma` (real number) : updating factor
- `a0 b0` (real numbers) : Initial values for the scoring algorithm
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
ols autoreg_matrix


## Examples
1. 
```scilab
[a,b] = arch_fit ( [1 2 3 4],[3 4 2 5]',1) // calling sequence arch_fit(y,x,p)

```
```output
a =

   1.4396
  -0.2278

b = 0.6160

  ```

2.
```scilab

[a,b] = arch_fit ( [1 2 3 4],[3 4 2 5]',0,50,0.02, 1,1 )
 
```
```output
a = 1.4066
b = 0.7998

```
3.
```scilab
[a,b] = arch_fit ( [1 2 3 4],[3 4 2 5]',0 ,50,0.02,0,0)


```
```output
a = NaN
b = NaN
```
4.
```scilab

 [a,b] = arch_fit ( [1:100],[1:100]',0 ,5000,0.001,10,12)

```
```output
a = 2730.5
b = 1.0739

```
5.
```scilab

[a,b] = arch_fit ( [1:100],ones(100,1),0,500,0.1,8,9)
```
```output
a = 833.25
b = 50.500

```
