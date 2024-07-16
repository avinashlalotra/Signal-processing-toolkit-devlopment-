# unwrap2
### Dependencies: 
ipermute
## Calling Sequence

- `b = unwrap(x)`
- `b = unwrap(x, tol)`
- `b = unwrap(x, tol, dim)`

## Parameters
- `x` : Input array containing radian phases to be unwrapped.
- `tol` (optional): Tolerance parameter specifying the maximum jump allowed between consecutive phases before adding or subtracting 2π. Defaults to 𝜋
- `dim` (optional): Dimension along which to unwrap the phases. If unspecified, dim defaults to the first non-singleton dimension of the array x.
## Description
The unwrap function adjusts radian phases in the input array x by adding or subtracting multiples of 
2π as necessary to remove phase jumps that exceed the specified tolerance tol. If tol is not provided, it defaults to 𝜋
- `Radian Phases`: These are typically angles or phases expressed in radians, commonly encountered in signal processing and communication systems.
- `Tolerance` (tol): Determines the maximum allowable discontinuity in the phases. 
If the difference between consecutive phases exceeds tol, unwrap adjusts the phase by adding or subtracting 2π.
- `Dimension` (dim): Specifies the dimension along which the unwrapping operation is applied. 
By default, unwrap operates along the first non-singleton dimension of the input array x.
## Examples
1. 
```scilab
Real examples will be added soon. Test cases are in source file itself.
```

 
