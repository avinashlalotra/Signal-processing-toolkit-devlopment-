# ifftn
## Description
Compute the inverse N-dimensional discrete Fourier transform of A using a Fast Fourier Transform (FFT) algorithm.

## Calling Sequence

- `ifftn(A)`

- `ifftn(A,size)`
## Parameters
- `A` : input matrix
- `size` :(optional) The optional vector argument size may be used specify the dimensions of the
array to be used. If an element of size is smaller than the corresponding dimension of A, then
the dimension of A is truncated prior to performing the inverse FFT. Otherwise, if an element of 
size is larger than the corresponding dimension then A is resized and padded with zeros
## Examples
1.
```scilab
A=[1:5;6:10];a(:,:,2)=[3:7;9:13];
ifftn(A);
```
```output
 ans  =

(:,:,1)

         column 1 to 3

   6.75 + 0.i  -0.5       - 0.688191i   -0.5       - 0.1624598i
  -2.75 + 0.i   1.241D-16 - 2.112D-16i  -1.241D-16 - 1.305D-16i

         column 4 to 5

  -0.5       + 0.1624598i  -0.5       + 0.688191i 
  -1.241D-16 + 1.305D-16i   1.241D-16 + 2.112D-16i
(:,:,2)

         column 1 to 3

  -1.25 + 0.i   6.206D-17 + 1.444D-16i  -6.206D-17 - 5.665D-17i
   0.25 + 0.i  -1.400D-16 - 2.640D-17i   1.513D-17 - 1.631D-17i

         column 4 to 5

  -6.206D-17 + 5.665D-17i   6.206D-17 - 1.444D-16i
   1.513D-17 + 1.631D-17i  -1.400D-16 + 2.640D-17i

```
2.
```scilab
A=[1 2 9: 0 1 2];
size=[1 2];
ifftn(A,size);
```
```output
ans  =

   1.5  -0.5
```
3.
```scilab
 a=[1:5;6:10];a(:,:,2)=[3:7;9:13];
 ifftn(a);
 ```
 ``` 
 ans  =

(:,:,1)

         Columns 1 to 3

   6.75 + 0.i  -0.5       - 0.688191i   -0.5       - 0.1624598i
  -2.75 + 0.i   1.241D-16 - 2.112D-16i  -1.241D-16 - 1.305D-16i

         column 4 to 5

  -0.5       + 0.1624598i  -0.5       + 0.688191i 
  -1.241D-16 + 1.305D-16i   1.241D-16 + 2.112D-16i
(:,:,2)

         Columns 1 to 3

  -1.25 + 0.i   6.206D-17 + 1.444D-16i  -6.206D-17 - 5.665D-17i
   0.25 + 0.i  -1.400D-16 - 2.640D-17i   1.513D-17 - 1.631D-17i

         column 4 to 5

  -6.206D-17 + 5.665D-17i   6.206D-17 - 1.444D-16i
   1.513D-17 + 1.631D-17i  -1.400D-16 + 2.640D-17i
```
4.
```
ifftn([99 45 67;32 12 356;887 546 321],[2 3]);
```
```
 ans  =

   101.83333 + 0.i  -18.166667 - 52.82755i   -18.166667 + 52.82755i 
  -31.5      + 0.i   32.5      + 46.476697i   32.5      - 46.476697i
  ```

5.
```
ifftn([1 2 9: 0 1 2],[1 2]);
```
```
 ans  =

   1.5  -0.5
   ```

