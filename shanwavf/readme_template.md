# shanwavf
## Description
Compute the Complex Shannon wavelet.

The complex Shannon wavelet is defined by a bandwidth parameter fb, a wavelet center frequency fc, and the expression

# $\psi(x) = f b^{\frac{1}{2}} \text{sinc}(fb \cdot x) e^{\pi i f c x}$


on an n-point regular grid in the interval of lb to ub.

## Calling Sequence

- `[psi, x]= shanwavf(lb, ub, n, fb, fc)`
## Parameters

- `lb, ub	`
Lower and upper bounds of the interval to evaluate the waveform on.

- `n`	
Number of points on the grid between lb and ub (length of the wavelet).

- `fb`	
Time-decay parameter of the wavelet (bandwidth in the frequency domain). Must be a positive scalar.

- `fc`	
Center frequency of the wavelet. Must be a positive scalar.

## Examples
1. 
```scilab
fb= 1
fc = 1.5
lb = -20
ub = 20
n = 1000
[psi,x]=shanwavf(lb,ub,n,fb,fc);
plot(psi,x)
```

<img title="OUTPUT" alt="Alt text" src="/images/boo.svg">

2. 
```scilab
[psi,x]=shanwavf(lb,ub,n,fb,fc);
plot(psi,x)
```
<img title="OUTPUT" alt="Alt text" src="/images/boo.svg">

3.
```scilab
[psi,x]=shanwavf(lb,ub,n,fb,fc);
plot(psi,x)
```
<img title="OUTPUT" alt="Alt text" src="/images/boo.svg">

4.
```scilab
[psi,x]=shanwavf(lb,ub,n,fb,fc);
plot(psi,x)
```
<img title="OUTPUT" alt="Alt text" src="/images/boo.svg">

5.
```scilab
[psi,x]=shanwavf(lb,ub,n,fb,fc);
plot(psi,x)
```
<img title="OUTPUT" alt="Alt text" src="/images/boo.svg">
