function [pks ,idx, varargout] = findpeaks (data, varargin)

  if (nargin < 1)
    error("findpeaks:InsufficientInputArguments\nfindpeaks: DATA must be given");
  end

  if (~(isvector (data) && length (data) >= 3))
    error ("findpeaks:InvalidArgument\nfindpeaks: DATA must be a vector of at least 3 elements");
  end

  transpose = (size(data,1) == 1);

  if (transpose)
    data = data.';
  end

 
  __data__ = abs (detrend (data, 'c'));
 // --- Parse arguments --- //
[ dSided, minH, minD, minW, maxW ] = parser ( varargin(:) );

// checkpoint parser
disp("checkpoint parser started")
disp("dSided"); disp(dSided);
disp("minH"); disp(minH);
disp("minD"); disp(minD);
disp("minW"); disp(minW);
disp("maxW"); disp(maxW);
disp("checkpoint parser closed")
// checkpoint closed


  if (dSided) 
    temp = __data__
    __data__ = data 
    data = temp
    temp = [] // free temp
  elseif (min (data) < 0)
    error ("findpeaks:InvalidArgument\nData contains negative values. You may want to DoubleSided option");
  end
  // Rough estimates of first and second derivative
  df1 = diff (data, 1)
  df1=df1([1; [1:length(df1)].']);
  df2 = diff (data, 2)
  df2=df2([1; 1; [1:length(df2)].']);
   disp("df1");disp(size(df1))
  disp("df2");disp(size(df2))

  // check for changes of sign of 1st derivative and negativity of 2nd
  // derivative.
  // <= in 1st derivative includes the case of oversampled signals.
  idx = find (df1.*[df1(2:$); 0] <= 0 & [df2(2:$); 0] < 0);

  // Get peaks that are beyond given height
  tf  = data(idx) > minH;
  idx = idx(tf);

  // sort according to magnitude
  [_, tmp] = gsort (data(idx));
  idx_s    = idx(tmp);

  // Treat peaks separated less than minD as one
  D  = abs (bsminuseq (idx_s));
  disp("idx_s :") ;disp(idx_s)
  disp("D") ;disp(D)
  D  =  D +  diag(ones(1,size(D,1))*%nan);                // eliminate diagonal cpmparison
  
  
  
    // Checkpoint 1 ---------------
    disp("Checkpoint 1 started")
    disp("D");disp(D);
    disp("tf");disp(tf);
    disp("Checkpoint 1 closed")
    ///// checkpoint  1 closed 
    
    
    
  if (or(D(:) < minD)) //  FIXME : this branch is not tested
    disp("I am executing ") 
    i          = 1;
    peak       = cell ();
    node2visit = 1:size(D,1);
    visited    = [];
    idx_pruned = idx_s;

    // debug
//    h = plot(1:length(data),data,"-",idx_s,data(idx_s),'.r',idx_s,data(idx_s),'.g');
//    set(h(3),"visible","off");
  
    while (~isempty (node2visit))

      d = D(node2visit(1),:);

      visited       = [visited node2visit(1)];
      node2visit(1) = [];

      neighs  = setdiff (find (d < minD), visited);
      if ( ~isempty (neighs))
        // debug
//        set(h(3),"xdata",idx_s(neighs),"ydata",data(idx_s(neighs)),"visible","on")
//        pause(0.2)
//        set(h(3),"visible","off");

        idx_pruned = setdiff (idx_pruned, idx_s(neighs));

        visited    = [visited neighs];
        node2visit = setdiff (node2visit, visited);

        // debug
//        set(h(2),"xdata",idx_pruned,"ydata",data(idx_pruned))
//        pause
      end

    end
    idx = idx_pruned;
  end

  extra = struct ("parabol", [], "height", [], "baseline", [], "roots", []);

  // Estimate widths of peaks and filter for:
  // width smaller than given.
  // wrong concavity.
  // not high enough
  // data at peak is lower than parabola by 1%
  // position of extrema minus center is bigger equal than minD/2
  // debug
//    h = plot(1:length(data),data,"-",idx,data(idx),'.r',...
//          idx,data(idx),'og',idx,data(idx),'-m');
//    set(h(4),"linewidth",2)
//    set(h(3:4),"visible","off");
  
  idx_pruned   = idx;
  n            = length (idx);
  np           = length (data);
  struct_count = 0;


    // Checkpoint 2 ---------------
    disp("Checkpoint 2 started")
    disp("extra");disp(extra);
    disp("idx_pruned");disp(idx_pruned);
    disp("n");disp(n);
    disp("np");disp(np);
    disp("Checkpoint 2 closed")
    ///// checkpoint  2 closed 
    
    
  for i=1:n
    ind = (floor (max(idx(i)-minD/2,1)) : ...
           ceil (min(idx(i)+minD/2,np))).';
    pp      = zeros (1,3);
    // If current peak is not local maxima, then fit parabola to neighbor
    if or(data(idx(i)-1) == data(idx(i)))
      // sample on left same as peak
      xm    = 0;
      pp    = ones (1,3);
    elseif  or(data(ind) > data(idx(i)))
      pp = polyfit (ind, data(ind), 2);
      xm = -pp(2)^2 / (2*pp(1));   // position of extrema
      H  = polyval (pp, xm);      // value at extrema
    else // use it as vertex of parabola
      H     = data(idx(i));
      xm    = idx(i);
      pp    = zeros (1,3);
      pp(1) = pinv((ind-xm).^2 ) * (data(ind)-H);
      pp(2) = - 2 * pp(1) * xm;
      pp(3) = H + pp(1) * xm^2;
    end
    
     // Checkpoint 3.0 ---------------
    disp("Checkpoint 3.0 started")
    disp("pp");disp(pp);
    disp("xm");disp(xm);
    disp("ind");disp(ind);
 
    disp("Checkpoint 3.0 closed")
    ///// checkpoint  3.0 closed 
    
    // debug
//    x = linspace(ind(1)-1,ind(end)+1,10);
//    set(h(4),"xdata",x,"ydata",polyval(pp,x),"visible","on")
//    set(h(3),"xdata",ind,"ydata",data(ind),"visible","on")
//    pause(0.2)
//    set(h(3:4),"visible","off");

//    thrsh = min (data(ind([1 end])));
//    rz    = roots ([pp(1:2) pp(3)-thrsh]);
//    width = abs (diff (rz));
    width = sqrt (abs(1 / pp(1)));
    disp("width");disp(width)
    /// checkpoint bool
    disp("width > maxW "); disp( width > maxW );
    disp("width < minW "); disp( width < minW );
    disp("pp(1) > 0 "); disp( pp(1) > 0 );
    disp(" H < minH"); disp( H > minH );
    disp(" data(idx(i)) < 0.99*H"); disp(  data(idx(i)) < 0.99*H);
    disp("abs (idx(i) - xm) > minD/2)");disp(abs(idx(i)-xm) > minD/2)
    /// checkpoint bool 
    
    if ( (width > maxW || width < minW) || pp(1) > 0 || H < minH || data(idx(i)) < 0.99*H ||abs (idx(i) - xm) > minD/2) then
      idx_pruned = setdiff (idx_pruned, idx(i)); 
      disp("i am executing from width > maxW || ... || ....")
    elseif (nargout > 2) //  FIXME : this branch is not tested 
      struct_count=struct_count+1;
      extra.parabol(struct_count).x  = ind([1 $]);
      extra.parabol(struct_count).pp = pp;

      extra.roots(struct_count,1:2)= xm + [-width width]/2;
      extra.height(struct_count)   = H;
      extra.baseline(struct_count) = mean ([H minH]);
    end

    // debug
//      set(h(2),"xdata",idx_pruned,"ydata",data(idx_pruned))
//      pause(0.2)

end
   

  idx = idx_pruned;

  if (dSided)
    pks = __data__(idx);
  else
    pks = data(idx);
  end

  if (transpose)
    pks = pks.';
    idx = idx.';
  end

  if (nargout() > 2)
    varargout(1) = extra;
  end

endfunction
/*
demo
// passed
 t = 2*%pi*linspace(0,1,1024)';
 y = sin(3.14*t) + 0.5*cos(6.09*t) + 0.1*sin(10.11*t+1/6) + 0.1*sin(15.3*t+1/3);
 data1 = abs(y); // postive values 
 [pks idx] = findpeaks(data1);


 data2 = y; // Double-sided
 [pks2 idx2] = findpeaks(data2,"DoubleSided"); 
 [pks3 idx3] = findpeaks(data2,"DoubleSided","MinPeakHeight",0.5); 

 subplot(1,2,1)
 plot(t,data1,t(idx),data1(idx),'xm')
 axis tight
 subplot(1,2,2)
 plot(t,data2,t(idx2),data2(idx2),"xm",t(idx3),data2(idx3),"or")
 axis tight
 legend("Location","NorthOutside","Orientation","horizontal")
 //----------------------------------------------------------------------------

  Finding the peaks of smooth data is not a big deal!

demo
 t = 2*%pi*linspace(0,1,1024)';
 y = sin(3.14*t) + 0.5*cos(6.09*t) + 0.1*sin(10.11*t+1/6) + 0.1*sin(15.3*t+1/3);

 data = abs(y + 0.1*rand(length(y),1,'normal')); // Positive values + noise
 [pks idx] = findpeaks(data,"MinPeakHeight",1);

 dt = t(2)-t(1);
 [pks2 idx2] = findpeaks(data,"MinPeakHeight",1,"MinPeakDistance",round(0.5/dt));

 subplot(1,2,1)
 plot(t,data,t(idx),data(idx),'or')
 subplot(1,2,2)
 plot(t,data,t(idx2),data(idx2),'or')

 //----------------------------------------------------------------------------
 // Noisy data may need tuning of the parameters. In the 2nd example,
 // MinPeakDistance is used as a smoother of the peaks.

assert_checkequal (findpeaks ([1, 1, 1]),[])
assert_checkequal (findpeaks ([1; 1; 1]),[])


test
 // Test input vector is an oversampled sinusoid with clipped peaks
 x = min (3, cos (2*%pi*[0:8000] ./ 600) + 2.01);
 assert_checkequal (~isempty (findpeaks (x)),%t)


test
 x = [1 10 2 2 1 9 1];
 [pks, loc] = findpeaks(x);
 assert_checkequal (loc, [2 ; 6])
 assert_checkequal (pks, [10 9])

// Test input validation
error findpeaks ()
error findpeaks (1)
error findpeaks ([1, 2])

// Test Matlab compatibility
test assert_checkequal(findpeaks ([34 134 353 64 134 14 56 67 234 143 64 575 8657]),353 134 234])

test 
 // three parabolas, equal height and width
 a  = -2
 x0 = 3.3;
 y0 = 4.1;
 x  = linspace (0, 20, 300);
 y  = a .* (x - x0).^2 + y0;
 y(end+1,:) = 1.78; ## offset
 y = max (y); ##  maximum along colums
 [pks, loc, ex] = findpeaks (y, "MaxPeakWidth", 15);
 assert_checkequal(length(pks),1)
 assert_checkequal(pks, ex.height);
 assert_checkequal(loc(:), mean (ex.roots, 2));

*/
