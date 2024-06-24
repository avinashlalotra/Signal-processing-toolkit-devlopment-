# shanwavf
## Description
Compute the 2D cross-correlation of matrices a and b.
If b is not specified, a's autocorrelation is computed, i.e., the same as xcorr (a, a).

The optional argument scale defines the type of scaling applied to the cross-correlation matrix.
## Calling Sequence

- `y = xcor2( a )`
- ` y = xcor2( a , b) `
-  ` y = xcor2( a , b , scale) `
## Parameters

- `a, b`
  Matrices

- `scale : `
  
<h3> none (default)  </h3>
<div>  No scaling. </div>

<h3> biased </h3>
<div>
  Scales the raw cross-correlation by the maximum number of elements of a and b involved in the generation of any element of c.
</div>


<h3>unbiased </h3>
<div>
  Scales the raw correlation by dividing each element in the cross-correlation matrix by the number of products a and b used to generate that element.
</div>


<h3>coeff</h3>
<div>
  Scales the normalized cross-correlation on the range of [0 1] so that a value of 1 corresponds to a correlation coefficient of 1
</div>

## Examples
1. 



2. 


3.


4.

5.

