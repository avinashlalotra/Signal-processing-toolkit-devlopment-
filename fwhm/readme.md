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
 x=-%pi:0.001:%pi; y=cos(x);
 fwhm(x, y) 
```
```output
 ans  =

   2.0943951

    ```

2.
```scilab
x=-20:1:20;
y1=-4+zeros(size(x,1) , size( x ,2)); y1(4:10)=8;
y2=-2+zeros(size(x,1) , size( x ,2)); y2(4:11)=2;
y3= 2+zeros(size(x,1) , size(x , 2)); y3(5:13)=10;
fwhm(x, [y1;y2;y3]')
 
```
```output
ans  =

   6.6666667   7.5   9.25

```
3.
```scilab
x=1:3; y=[-1,3,-1];
fwhm(x,y, 'alevel', 2.5)
fwhm(x,y,'alevel', -0.5)

```
```output
-->fwhm(x,y, 'alevel', 2.5)
 ans  =

   0.25

-->fwhm(x,y,'alevel', -0.5)
 ans  =

   1.75

```
4.
```scilab
x=1:3; y=[-1,3,-1];
fwhm(x,y, 'rlevel', 0.1)
fwhm(x,y,'zero', 'rlevel', 0.1)   //test case failed
fwhm(x,y,'min', 'rlevel', 0.1)

```
```output


```
5.
```scilab
x=-5:5; y=18-x.*x; 
fwhm(y)
fwhm(x,y,'zero')
fwhm(x,y,'min')

```
```output

-->fwhm(y)
 ans  =

   6.

-->fwhm(x,y,'zero')
 ans  =

   6.

-->fwhm(x,y,'min')
 ans  =

   7.

```
