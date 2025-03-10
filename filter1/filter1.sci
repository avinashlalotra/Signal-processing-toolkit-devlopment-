function [Y, SF] = filter1 (B, A, X, SI, DIM)
    //Apply a 1-D digital filter to the data X.
    //Calling Sequence
    //Y = filter1(B, A, X)
    //[Y, SF] = filter1(B, A, X, SI)
    //[Y, SF] = filter1(B, A, X, [], DIM)
    //[Y, SF] = filter1(B, A, X, SI, DIM)
    //Parameters
    //B: Matrix or Integer
    //A: Matrix or Integer
    //X: Matrix or Integer 
    //Description
    //'filter' returns the solution to the following linear, time-invariant difference equation:
    //
    //          N                   M
    //
    //         SUM a(k+1) y(n-k) = SUM b(k+1) x(n-k)    for 1<=n<=length(x)
    //
    //         k=0                 k=0
    //
    //where N=length(a)-1 and M=length(b)-1.  The result is calculated over the first non-singleton dimension of X or over DIM if supplied.
    //
    //An equivalent form of the equation is:
    //
    //                    N                   M
    //
    //          y(n) = - SUM c(k+1) y(n-k) + SUM d(k+1) x(n-k)  for 1<=n<=length(x)
    //
    //                   k=1                 k=0
    //
    //    where c = a/a(1) and d = b/a(1).
    //Examples
    //filter1([1,2,3], [3,4,5], [5,6,7])
    //ans = 
    //    1.6666667    3.1111111    4.4074074  
    
    if nargin < 3 || nargin > 5 then
        error("filter1 : Wrong number of input arguments")
    end
    if nargin < 4 then
        SI = [] ;
    end
    
    if nargin < 5 then
        DIM = find(size(X) > 1)(1);
        if isempty(DIM) then DIM = 1 end // in case of a scaler
    end
    

    ab_len = max(length(B),length(A));
    if ~isempty(SI) then 
        
        if (size(SI,1) ~= ab_len - 1) then
            error("filter: first dimension of SI must be of length max (length (a), length (b)) - 1");
        end

        
        if (size(X,1) ~= ab_len -1 ||  size(X,2) ~= size(SI,2)) then
                error("filter: dimensionality of SI and X must agree");
            end
        
    end
    
    Y = []
    SF = []
 
    // handle dim
    if DIM == 1 then 

        if isempty(SI) then SI = zeros(ab_len-1,size(X,2)) end
        
        for i=1:size(X,2)
            [Y(:,i) , SF(:,i) ] = filter(B,A,X(:,i),SI(:,i));
        end
        
    end
    if DIM == 2  then 

        if isempty(SI) then SI = zeros(ab_len-1,size(X,2)) end

        for i=1:size(X,1) 
            [Y(i,:) , SF(i,:) ] = filter(B,A,X(i,:),SI(i,:)');
         end
  end
endfunction
/*

test cASE 1
// dim functionality
[y,sf]=filter1([1 2 3],[4 5 6],[1:10],[],2) // passed 1d vector

[y,sf]=filter([0.3 4 3],[5 6],[1:10;11:20],[],2) // passed 2d matrix

[y,sf]=filter1([0.3 4 3],[5 6],[1:10;11:20],[],1) // passed 2d matrix

// sI 
x = [1 2 3;4 5 6] ; si =[1 2 ;3 4];
[y,sf]=filter([3 5 6],[5 6],x,si,2)

//dim=2
[y,sf]=filter([3 5 6],[5 6],[ 1 2 3 4;4 5 6 7],[1 2 ;5  8],2)

//dim=1
[y,sf]=filter([3 5 6],[5 6],[ 1 2 3 4;4 5 6 7],[1 2 3 4;5 6 7 8],1)
*/
