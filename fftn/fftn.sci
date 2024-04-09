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
 FFTN - Computes the N-dimensional discrete Fourier transform of A using a Fast Fourier Transform (FFT) algorithm.

    Usage:
         Y = fftn(A)
         Y = fftn(A, SIZE)

    Parameters:
        A: Matrix, the input data for which the FFT is computed.
        SIZE: Optional vector specifying the dimensions of the output array. If provided, the dimensions of A are adjusted accordingly.

    Description:
        This function computes the N-dimensional discrete Fourier transform of A using a Fast Fourier Transform (FFT) algorithm.
        The optional vector argument SIZE may be used to specify the dimensions of the array to be used.
        If an element of SIZE is smaller than the corresponding dimension of A, then the dimension of A is truncated prior to performing the FFT.
        Otherwise, if an element of SIZE is larger than the corresponding dimension, then A is resized and padded with zeros.

    Examples:
        fftn([6 9 7 ;2 9 9 ;0 3 1],[2 2])
        ans  =
        26.  -10.
        4.    4. 
 */
function y = fftn(A, SIZE)
    funcprot(0);
    // Get the number of input arguments
    rhs = argn(2);
    // Check if the number of input arguments is valid
    if rhs < 1 | rhs > 2 then
        error("Wrong number of input arguments.");
    end
    // Perform action based on the number of input arguments
    switch rhs
    case 1 // If only A is provided
        y = fft(A);
    case 2 // If both A and SIZE are provided
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
        y = fft(A);
    end
endfunction

