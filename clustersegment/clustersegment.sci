/*2024 
Author: Abinash Singh <abinashsinghlalotra@gmail.com>
*/
/*
Description:

            clusteridx = clustersegment (unos) ¶
            Calculate boundary indexes of clusters of 1’s.

            The function calculates the initial index and end index of the sequences of 1’s in the rows of unos. The clusters are sought in the rows of the array unos.

            The result is returned in a cell array of size 1-by-Np, where Np is the number of rows in unos. Each element of the cell has two rows. The first row is the initial index of a sequence of 1’s and the second row is the end index of that sequence.

            If Np == 1 the output is a matrix with two rows.

            The function works by finding the indexes of jumps between consecutive values in the rows of unos.
*/
function contRange = __clustersegment__(xhi)
    //This function only supports vector inputs
    // Find discontinuities
    bool_discon = diff (xhi, 1, 2);
    [Np Na]     = size (xhi);
    contRange   = cell (1, Np);
  
    for i = 1:Np
      idxUp  = find (bool_discon(i,:) > 0) + 1;
      idxDwn = find (bool_discon(i,:) < 0);
      tLen   = max(size(idxUp)) + max(size(idxDwn));
  
      if xhi(i,1) == 1
        // first event was down
        contRange{i}(1)          = 1;
        contRange{i}(2:2:tLen+1) = idxDwn;
        contRange{i}(3:2:tLen+1) = idxUp;
      else
        // first event was up
        contRange{i}(1:2:tLen) = idxUp;
        contRange{i}(2:2:tLen) = idxDwn;
      end
  
      if xhi(i,$) == 1
        // last event was up
        contRange{i}($+1) = Na;
      end
  
      tLen = max(size(contRange{i}) );
      if tLen ~= 0
        contRange{i} = matrix (contRange{i}, 2, tLen / 2);
      end
  
    end
  
    if Np == 1
      contRange = cell2mat (contRange);
    end
  
endfunction
//handling the matrix input 
function contRange = clustersegment (xhi)
   contRange   = cell (1, size(xhi,1));
   for i = 1 : size(xhi,1)
       contRange{i} =__clustersegment__(xhi(i,:))
   end
endfunction
