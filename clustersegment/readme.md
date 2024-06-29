# clustersegment
## Description
Calculate boundary indexes of clusters of 1’s.

The function calculates the initial index and end index of the sequences of 1’s in the rows of unos. The clusters are sought in the rows of the array unos.

The result is returned in a cell array of size 1-by-Np, where Np is the number of rows in unos. Each element of the cell has two rows. The first row is the initial index of a sequence of 1’s and the second row is the end index of that sequence.

If Np == 1 the output is a matrix with two rows.

The function works by finding the indexes of jumps between consecutive values in the rows of unos.



## Calling Sequence

- ` clustersegment (unos)  `

## Parameters
- `  unos ` :  A vector or Matrix 
## Examples
1. 
```scilab
    xhi = [0 0 1 1 1 0 0 1 0 0 0 1 1];
    ranges = clustersegment (xhi);
    ranges{1}
```
```output
ranges  = 

  [2x3 constant]

 ans  =

   3.   8.   12.
   5.   8.   13.

    ```

2.
```scilab
xhi =  [ 1 0 0 0 1 1 0 1 1 1 0 1 0 ; 1 0 1 0 1 0 0 0 1 0 0 1 0];
 ranges = clustersegment (xhi);
 ranges{1}, ranges{2}
```
```output
 ranges  = 

  [2x4 constant]    [2x5 constant]

  ans  =

   1.   5.   8.    12.
   1.   6.   10.   12.

 ans  =

   1.   3.   5.   9.   12.
   1.   3.   5.   9.   12.

```
3.
```scilab
xhi =  [ 1 0 0 0 1 1 0];
ranges = clustersegment (xhi)
ranges{1}
```
```output
 ranges  = 

  [2x2 constant]

  ans  =

   1.   5.
   1.   6.

```

4.
```scilab
ranges = clustersegment ([])
```
```output
 ranges  = 

  {}
 ```
 5.
 ```scilab
 xhi =  [ 23 4 5 6 5 43 2];

ranges = clustersegment (xhi)
ranges{1}
```
```output

 ans  =

   3.   4.   6.
   1.   4.   6.

```   