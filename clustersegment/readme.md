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
