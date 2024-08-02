# unwrap2

## Description
The unwrap function adjusts radian phases in the input array x by adding or subtracting multiples of 
2π as necessary to remove phase jumps that exceed the specified tolerance tol. If tol is not provided, it defaults to 𝜋
- `Radian Phases`: These are typically angles or phases expressed in radians, commonly encountered in signal processing and communication systems.
- `Tolerance` (tol): Determines the maximum allowable discontinuity in the phases. 
If the difference between consecutive phases exceeds tol, unwrap adjusts the phase by adding or subtracting 2π.
- `Dimension` (dim): Specifies the dimension along which the unwrapping operation is applied. 
By default, unwrap operates along the first non-singleton dimension of the input array x.
## Calling Sequence

- `b = unwrap(x)`
- `b = unwrap(x, tol)`
- `b = unwrap(x, tol, dim)`

## Parameters
- `x` : Input array containing radian phases to be unwrapped.
- `tol` (optional): Tolerance parameter specifying the maximum jump allowed between consecutive phases before adding or subtracting 2π. Defaults to 𝜋
- `dim` (optional): Dimension along which to unwrap the phases. If unspecified, dim defaults to the first non-singleton dimension of the array x.
### Dependencies: 
ipermute
## Examples
```scilab
Demos will be added soon
```
#### Test Cases
```scilab
i = 0;
t = [];
r = [0:100];                         // original vector
w = r - 2*%pi*floor ((r+%pi)/(2*%pi));  // wrapped into [-pi,pi]
tol = 1e3*%eps;
assert_checkalmostequal (r,  unwrap2 (w),  tol)
assert_checkalmostequal (r', unwrap2 (w'), tol)
assert_checkalmostequal ([r',r'], unwrap2 ([w',w']), tol)
assert_checkalmostequal ([r; r ], unwrap2 ([w; w ], [], 2), tol)
assert_checkalmostequal(r + 10, unwrap2 (10 + w), tol)
assert_checkequal (w', unwrap2 (w', [], 2))
assert_checkequal(w,  unwrap2 (w,  [], 1))
assert_checkequal([w; w], unwrap2 ([w; w]))
```

 Test that small values of tol have the same effect as tol = pi
```scilab
assert_checkalmostequal(r, unwrap2 (w, 0.1), tol)
assert_checkalmostequal(r, unwrap2 (w, %eps), tol)
```
 Test that phase changes larger than 2*pi unwrap properly
```scilab
assert_checkalmostequal([0;  1],        unwrap2([0;  1]))
assert_checkalmostequal([0;  4 - 2*%pi], unwrap2 ([0;  4]))
assert_checkalmostequal([0;  7 - 2*%pi], unwrap2 ([0;  7]))
assert_checkalmostequal([0; 10 - 4*%pi], unwrap2 ([0; 10]))
assert_checkalmostequal([0; 13 - 4*%pi], unwrap2 ([0; 13]))
assert_checkalmostequal([0; 16 - 6*%pi], unwrap2 ([0; 16]))
assert_checkalmostequal([0; 19 - 6*%pi], unwrap2 ([0; 19]))
```
test
```
A = [%pi*(-4), %pi*(-2+1/6), %pi/4, %pi*(2+1/3), %pi*(4+1/2), %pi*(8+2/3), %pi*(16+1), %pi*(32+3/2), %pi*64];
assert_checkalmostequal (unwrap2 (A), unwrap2 (A, %pi));
assert_checkalmostequal (unwrap2 (A, %pi), unwrap2 (A, %pi, 2));
assert_checkalmostequal (unwrap2 (A', %pi), unwrap2 (A', %pi, 1));
```
test
```
A = [%pi*(-4); %pi*(2+1/3); %pi*(16+1)];
B = [%pi*(-2+1/6); %pi*(4+1/2); %pi*(32+3/2)];
C = [%pi/4; %pi*(8+2/3); %pi*64];
D = [%pi*(-2+1/6); %pi*(2+1/3); %pi*(8+2/3)];
E(:, :, 1) = [A, B, C, D];
E(:, :, 2) = [A+B, B+C, C+D, D+A];
F(:, :, 1) = [unwrap2(A), unwrap2(B), unwrap2(C), unwrap2(D)];
F(:, :, 2) = [unwrap2(A+B), unwrap2(B+C), unwrap2(C+D), unwrap2(D+A)];
assert_checkalmostequal (unwrap2 (E), F);
```
 Test trivial return for m = 1 and dim > nd
```
assert_checkalmostequal (unwrap2 (ones(4,1), [], 1), ones(4,1))
assert_checkalmostequal (unwrap2 (ones(4,1), [], 2), ones(4,1))
assert_checkalmostequal (unwrap2 (ones(4,1), [], 3), ones(4,1))
assert_checkalmostequal (unwrap2 (ones(4,3,2), [], 99), ones(4,3,2))
```
Test empty input return
```
assert_checkalmostequal (unwrap2 ([]), [])
assert_checkalmostequal (unwrap2 (ones (1,0)), ones (1,0))
assert_checkalmostequal (unwrap2 (ones (1,0), [], 1), ones (1,0))
assert_checkalmostequal (unwrap2 (ones (1,0), [], 2), ones (1,0))
assert_checkalmostequal (unwrap2 (ones (1,0), [], 3), ones (1,0))
```
Test trivial return for m = 1 and dim > nd
```scilab
assert_checkalmostequal (unwrap2 (ones(4,1), [], 1), ones(4,1))
assert_checkalmostequal (unwrap2 (ones(4,1), [], 2), ones(4,1))
assert_checkalmostequal (unwrap2 (ones(4,1), [], 3), ones(4,1))
assert_checkalmostequal (unwrap2 (ones(4,3,2), [], 99), ones(4,3,2))
```
Test empty input return
```
assert_checkalmostequal (unwrap2 ([]), [])
assert_checkalmostequal (unwrap2 (ones (1,0)), ones (1,0))
assert_checkalmostequal (unwrap2 (ones (1,0), [], 1), ones (1,0))
assert_checkalmostequal (unwrap2 (ones (1,0), [], 2), ones (1,0))
assert_checkalmostequal (unwrap2 (ones (1,0), [], 3), ones (1,0))
```
 Test handling of non-finite values
```
x = %pi * [-%inf, 0.5, -1, %nan, %inf, -0.5, 1];
assert_checkalmostequal (unwrap2 (x), %pi * [-%inf, 0.5, 1, %nan, %inf, 1.5, 1], %eps)
assert_checkalmostequal (unwrap2 (x.'), %pi * [-%inf, 0.5, 1, %nan, %inf, 1.5, 1].', %eps)

```
 
