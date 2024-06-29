# arch_test
## Calling Sequence

- ` [pval, lm] = arch_test (y, x, p) `


## Description
For a linear regression model

y = x * b + e
perform a Lagrange Multiplier (LM) test of the null hypothesis of no conditional heteroscedascity against the alternative of CH(p).

I.e., the model is

y(t) = b(1) * x(t,1) + … + b(k) * x(t,k) + e(t),
given y up to t-1 and x up to t, e(t) is N(0, h(t)) with

h(t) = v + a(1) * e(t-1)^2 + … + a(p) * e(t-p)^2,
and the null is a(1) == … == a(p) == 0.

If the second argument is a scalar integer, k, perform the same test in a linear autoregression model of order k, i.e., with

[1, y(t-1), …, y(t-k)]
as the t-th row of x.

Under the null, LM approximately has a chisquare distribution with p degrees of freedom and pval is the p-value (1 minus the CDF of this distribution at LM) of the test.

If no output argument is given, the p-value is displayed.

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
