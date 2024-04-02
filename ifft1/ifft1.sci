function res =  ifft1 (x, n, dim)
//Calculates the inverse discrete Fourier transform of a matrix using Fast Fourier Transform algorithm.
//Calling Sequence
//ifft (x, n, dim)
//ifft (x, n)
//ifft (x)
//Parameters 
//x: input matrix
//n: Specifies the number of elements of x to be used
//dim: Specifies the dimention of the matrix along which the inverse FFT is performed
//Description
//This is an Octave function.
//Description
//This is an Octave function.
//The inverse FFT is calculated along the first non-singleton dimension of the array. Thus, inverse FFT is computed for each column of x.
//
//n is an integer specifying the number of elements of x to use. If n is larger than dimention along. which the inverse FFT is calculated, then x is resized and padded with zeros.
//Similarly, if n is smaller, then x is truncated.
//
//dim is an integer specifying the dimension of the matrix along which the inverse FFT is performed.
//Examples
//x = [1 2 3; 4 5 6; 7 8 9]
//n = 3
//dim = 2
//ifft1 (x, n, dim)
//ans =
//
//   2.00000 + 0.00000i  -0.50000 - 0.28868i  -0.50000 + 0.28868i
//   5.00000 + 0.00000i  -0.50000 - 0.28868i  -0.50000 + 0.28868i
//   8.00000 + 0.00000i  -0.50000 - 0.28868i  -0.50000 + 0.28868i

funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 1 | rhs > 3)
error("Wrong number of input arguments.")
end
 // The ifft will be calculated along the first non-singleton dimension of the array i.e along the columns by default.
    dimension = size(x);
    nsdim = 1;
    for i = 1:length(dimension)
        if dimension(i) ~= 1 then
            nsdim = i;
            break    
        end
    end 
size_x=size(x)
len=length(size_x)
select(rhs)
	
	case 1 then
 
    if len>2 then
        last_dim=size_x(len)
    else
        last_dim=1    
    end
    res=[]
     for i=1:last_dim
        res(:,:,i)=fft(x(:,:,i),1,nsdim);
    end;
	

	case 2 then
     //check for empty input
     // if n is not specified as None, then default value will be used
     if isempty(n) then
                n = size(x, nsdim);
            else
                n = n;
            end
    //handling multidimensional arrays        
    if len>2 then
        last_dim=size_x(len)
    else
        last_dim=1    
    end
    
    res=[]
    for i=1:last_dim
        if (size(x(:,:,i))(1)==1) then
           res(:,:,i) =resize_matrix(x(:,:,i),1,n);
        else
            res(:,:,i)=resize_matrix(x(:,:,i),n,size(x(:,:,i))(2));    
        end
        res(:,:,i)=fft(res(:,:,i),1,nsdim);
        end
    

	case 3 then
      // check for empty input 
       if isempty(n) then
                n = size(x, nsdim);
            else
                n = n;
            end
    if len>2 then
        last_dim=size_x(len)
    else
        last_dim=1    
    end
    size_x(dim)=n;
    res=[]
    for i=1:last_dim
        res(:,:,i)=fft(resize_matrix(x(:,:,i),size_x),1,dim);
        end
     
	end
endfunction
