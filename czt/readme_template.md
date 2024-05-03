# czt
## Description
Chirp z-transform. 
Compute the frequency response starting at a and stepping by w for m steps. a is a point in the complex plane, and w is the ratio between points in each step (i.e., radius increases exponentially, and angle increases linearly).

## Calling Sequence

- `czt(x)`
- `czt(x, m)`
- `czt(x, m, w)`
- `czt(x, m, w, a)`
## Parameters
- `x` : A Matrix or a vector
- `m` : number of steps
- `w` : ratio between points in each step
- `a` : a point in the complex plane
- 
If you don’t specify them, then the parameters default to a Fourier transform: m=length(x), w=exp(-j*2*pi/m), a=1

If x is a matrix, the transform will be performed column-by-column.
## Examples
1. To evaluate the frequency response for the range f1 to f2 in a signal with sampling frequency Fs, use the following:
```scilab
m = 32;                               ## number of points desired
w = exp(-j*2*pi*(f2-f1)/((m-1)*Fs));  ## freq. step of f2-f1/m
a = exp(j*2*pi*f1/Fs);                ## starting at frequency f1
y = czt(x, m, w, a);
```

2. comments if any
```scilab
Scilab code here
```
```output
Output here

```
3. comments if any
```scilab
Scilab code here
```
```output
Output here

```
4. comments if any
```scilab
Scilab code here
```
```output
Output here

```
5.comments if any
```scilab
Scilab code here
```
```output
Output here

```
