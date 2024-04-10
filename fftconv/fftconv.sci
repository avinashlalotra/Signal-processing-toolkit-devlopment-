/*
April 2024
Author: Abinash Singh
Email: abinashsinghlalotra@gmail.com
GitHub: https://github.com/abinash108
LinkedIn: https://www.linkedin.com/in/abinash-singh-809b89280
Description: 
I am currently pursuing a Bachelor of Technology (B.Tech) in Electronics and Communication Engineering (ECE) 
from the School of Engineering, Cochin University of Science and Technology (CUSAT). My interests lie in 
signal processing, computing, and artificial intelligence (AI). I am particularly passionate about exploring 
how these fields intersect and can be applied to solve real-world problems. I enjoy contributing to open-source 
projects and am eager to learn and collaborate with others in the community. Feel free to connect with me for 
discussions or collaborations!
*/
/*
Convolve two vectors using the FFT for computation.
    Calling Sequence
        Y = fftconv(X, Y)
        Y = fftconv(X, Y, n)
    Parameters
        X, Y: Vectors 
    Description
        Convolve two vectors using the FFT for computation. 'c' = fftconv (X, Y)' returns a vector of length equal to 'length(X) + length (Y) - 1'.  If X and Y are         the coefficient vectors of two polynomials, the returned value is the coefficient vector of the product polynomial.
        If the optional argument n is specified, an N-point FFT is used.
    Examples
        fftconv([1,2,3], [3,4,5])
        ans = 
            3.    10.    22.    22.    15. 
 */
 function y = fftconv(X, Y, n)
     funcprot(0);
     rhs = argn(2);
     if(rhs<2 | rhs>3)
         error("Wrong number of input arguments.");
     end
     shape_x = size(X);
     shape_y = size(Y);
     if (shape_x(1) ~= 1 || length(shape_x) ~= 2 || shape_y(1) ~= 1 || length(shape_y) ~= 2)
         error('The inputs must be a vector');
     end
     nx=length(X);
     ny=length(Y);
     select(rhs)
     case 2 then
         n=nx + ny;
         X=resize_matrix(X,1,n);
         Y=resize_matrix(Y,1,n);
         fftX=fft(X);
         fftY=fft(Y);
         y=fft(fftX.*fftY,1);
         y=y(1:nx+ny-1);
     case 3 then
         n = 2^(fix(log2(nx+ny))+1);
         X=resize_matrix(X,1,n);
         Y=resize_matrix(Y,1,n);
         fftX=fft(X);
         fftY=fft(Y);
         y=fft(fftX.*fftY,1);
         y=y(1:nx+ny-1);
     end
 endfunction
  

