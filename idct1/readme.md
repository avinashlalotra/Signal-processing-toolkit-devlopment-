# idct1
### Compute the inverse discrete cosine transform of x.
## Calling Sequence
- `idct(x)`
- `idct1(x,n)`
## Parameters
-`x` : A matrix or an Integer

-`n` (optional) : If n is given, then x is padded or trimmed to length n before computing the transform. 
If x is a matrix, compute the transform along the columns of the the matrix

The inverse discrete cosine transform x can be defined as follows:


<p style="white-space: nowrap; font-size: 30px;">
    x[n] = Σ<sub>k=0</sub><sup>N-1</sup> w(k) X[k] cos(<span style="font-size: 16px;">π(2n+1)k/2N</span>), &nbsp; n = 0, ..., N-1
</p>
<p style="font-size: 16px;">with w(0) = √(1/N) and w(k) = √(2/N), k = 1, ..., N-1</p>

##  Examples
1.
```scilab
a=[1 2 3];a(:,:,2)=[1 4 6];
idct(a)
```
```output
ans  =

(:,:,1)

   3.2163087  -1.8721395   0.3878816
(:,:,2)

   5.8552671  -4.3216292   0.1984129
```
2.
```scilab
idct1([1 2;4 5;87 66;9 32],2)
```
```output
 ans  =

   3.5355339   4.9497475
  -2.1213203  -2.1213203
```
