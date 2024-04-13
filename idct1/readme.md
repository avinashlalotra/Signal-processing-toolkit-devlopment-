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
