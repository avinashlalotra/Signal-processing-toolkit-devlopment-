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
Compute the inverse N-dimensional discrete Fourier transform of A using a Fast Fourier Transform (FFT) algorithm.
    Calling Sequence
        Y = ifftn(A)
        Y = ifftn(A, size)
    Parameters
        A: Matrix 
        SIZE : (optional) dimension of matrix to be used
    Description
        Compute the inverse N-dimensional discrete Fourier transform of A using a Fast Fourier Transform (FFT) algorithm. The optional vector argument SIZE may be u        sed specify the dimensions of the matrix to be used.  If an element of SIZE is smaller than the corresponding dimension of A, then the dimension of A is trun        cated prior to performing the inverse FFT. Otherwise, if an element of SIZE is larger than the corresponding dimension then A is resized and padded with zer        os.
    Examples
        ifftn([2,3,4])
        ans = 
            3.  - 0.5 - 0.2886751i  - 0.5 + 0.2886751i 
*/
function y = ifftn(A, SIZE)
    funcprot(0);
    funcprot(0);
    rhs = argn(2)
    if(rhs<1 | rhs>2)
        error("Wrong number of input arguments.");
    end
    select(rhs)
    case 1 then
        y=fft(A,1);
    case 2 then
        // Check if A needs resizing
        if size(A) == SIZE then
            // No resizing needed
            break;
        elseif length(size(A)) ~= length(SIZE) then
            error("Output size must have at least Ndims");
        else
            // Resize A using the resize_matrix function
            A = resize_matrix(A, SIZE);
        end
        y = fft(A,1);
    end
endfunction

