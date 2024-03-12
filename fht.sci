function y=fht(data,n,dim)
//The Function calculates the Fast Hartley Transform of real input.
//Calling Sequence
//M = fht (D)
//M = fht (D, N)
//M = fht (D, N, DIM)
//Parameters 
//Description
//This function calculates the Fast Hartley transform of real input D. If D is a matrix, the Hartley transform is calculated along the columns by default.
//Examples
//fht(1:4)
//ans =
//   10   -4   -2   0  
//
//This 9function is being called from Octave.
funcprot(0);
rhs=argn(2);
if(rhs<1 | rhs>3)
    error("Wrong number of input arguments.")
end
dimension=size(data)
nsdim=1
for i=1:length(dimension)
    if dimension(i) ~=1 
        nsdim=i
        break    
    end
   end 
select(rhs)
case 1 then
    
    y=fft(data,-1,i)
case 2 then
     if isempty(n) then
        n = size(data, i);
    end
    new_size=size(data)
    new_size(i)=n
    data=resize_matrix(data,new_size)
    y=fft(data,-1,i) 
case 3 then
     if isempty(n) then
        n = size(data,dim);
    end
    new_size=size(data)
    new_size(dim)=n
    data=resize_matrix(data,new_size)
    y=fft(data,-1,dim)
end
y=real(y)-imag(y)
endfunction
