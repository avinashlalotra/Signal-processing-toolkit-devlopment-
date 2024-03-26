function res =  fft1 (D, N, DIM)
//Calculates the discrete Fourier transform of a matrix using Fast Fourier Transform algorithm.
//Calling Sequence
//fft1 (x, n, dim)
//fft1 (x, n)
//fft1 (x)
//Parameters 
//x: input matrix
//n: Specifies the number of elements of x to be used
//dim: Specifies the dimention of the matrix along which the FFT is performed
//Description

//The FFT is calculated along the first non-singleton dimension of the array. Thus, FFT is computed for each column of x.
//
//n is an integer specifying the number of elements of x to use. If n is larger than dimention along. which the FFT is calculated, then x is resized and padded with zeros.
//Similarly, if n is smaller, then x is truncated.
//
//dim is an integer specifying the dimension of the matrix along which the FFT is performed.
//Examples
//x = [1 2 3; 4 5 6; 7 8 9]
//n = 3
//dim = 2
//fft1 (x, n, dim)
//ans =
//
//    6.0000 +  0.0000i   -1.5000 +  0.8660i   -1.5000 -  0.8660i
//   15.0000 +  0.0000i   -1.5000 +  0.8660i   -1.5000 -  0.8660i
//   24.0000 +  0.0000i   -1.5000 +  0.8660i   -1.5000 -  0.8660i

funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 1 | rhs > 3)
error("Wrong number of input arguments.")
end

// The fht will be calculated along the first non-singleton dimension of the array i.e along the columns by default.
//read the documentation of fft function of scilab . by default it doesn't calculate fht along the first non-singleton dim.
    dimension = size(D);
    nsdim = 1;
    for i = 1:length(dimension)
        if dimension(i) ~= 1 then
            nsdim = i;
            break    
        end
    end 

    // Process input arguments
    select(rhs)
        case 1 then
            res = fft(D, -1, nsdim);
        case 2 then
            if isempty(N) then
                n = size(D, nsdim);
            else
                n = N;
            end
            new_size = size(D);
            new_size(nsdim) = n;
            D = resize_matrix(D, new_size);
            res = fft(D, -1, nsdim);
        case 3 then
            if isempty(N) then
                n = size(D, DIM);
            else
                n = N;
            end
            new_size = size(D);
            new_size(DIM) = n;
            D = resize_matrix(D, new_size);
            res= fft(D, -1, DIM);
    end
endfunction
