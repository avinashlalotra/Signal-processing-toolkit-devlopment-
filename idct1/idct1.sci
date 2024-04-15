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
discussions or collaborations!*/
/* 
    Compute the inverse discrete cosine transform of input.
        Calling Sequence
            Y = idct1(X)
            Y = idct1(X, N)
        Parameters
            X: Matrix or integer
            N: If N is given, then X is padded or trimmed to length N before computing the transform.
        Description
            This function computes the inverse discrete cosine transform of input X.
            If N is given, then X is padded or trimmed to length N before computing the transform.
            If X is a matrix, compute the transform along the columns of the the matrix.
            The transform is faster if X is real-valued and even length.
        Examples
            idct1([1,3,6])
            ans = 
                5.1481604  - 4.3216292    0.9055197 
*/
function y = idct1(x,n)
    funcprot(0);
    rhs=argn(2);
    if (rhs<1 | rhs>2) then
        error("Wrong number of input arguments.");
    end
    nsdim=1;
    siz=size(x);
    len=length(siz);
    for i=1:len
        if siz(i) ~= 1 then
            nsdim=i
            break;
        end;
    end;
    select(rhs)
    case 1 then
        y=idct(x,nsdim);
    case 2 then
        siz(nsdim)=n;
        y=idct(resize_matrix(x,siz),nsdim)
    end;
endfunction
