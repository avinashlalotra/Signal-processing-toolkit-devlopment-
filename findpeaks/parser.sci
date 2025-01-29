function [ dSided, minH, minD, minW, maxW ] = parser ( varargin )
    // Default values
    dSided = %f ; 
    minH = %eps ;
    minD = 1 ;
    minW = 1 ;
    maxW = %inf ;
    idx = 1 ;
    while idx <= length(varargin)  
        select lower(varargin(idx)) 
        case 'doublesided' 
            dSided = %t ;
            idx = idx + 1 ;
        case 'minpeakheight' 
            if idx+1 > length(varargin) || ~( isscalar(varargin(idx+1)) && varargin(idx+1) >=0 ) then 
                error('findpeaks: MinPeakHeight must be a postive scalar') ;
            end
            minH = varargin(idx+1) ;
            idx = idx + 2 ;
        case 'minpeakdistance' 
            if idx+1 > length(varargin) || ~( isscalar(varargin(idx+1)) && varargin(idx+1) >=0 ) then 
                error('findpeaks: MinPeakDistance must be a postive scalar') ;
            end
            minD = varargin(idx+1) ;
            idx = idx + 2 ;
        case 'minpeakwidth' 
            if idx+1 > length(varargin) || ~( isscalar(varargin(idx+1)) && varargin(idx+1) >=0 ) then 
                error('findpeaks: MinPeakWidth must be a postive scalar') ;
            end
            minW = varargin(idx+1) ;
            idx = idx + 2 ;    
        case 'maxpeakwidth' 
            if idx+1 > length(varargin) || ~( isscalar(varargin(idx+1)) && varargin(idx+1) >=0 ) then 
                error('findpeaks: MaxPeakWidth must be a postive scalar') ;
            end
            maxW = varargin(idx+1) ;
            idx = idx + 2 ;    
        else 
            warning("findpeaks: Ignoring unknown option ") ;
            idx = idx + 1 ;
        end
         
    end
endfunction

function y = lower (y)
    if type(y) == 10 then 
        y = convstr(y, 'l') ;
    else
        y = y ;
    end

endfunction

// Test case 1: Default values when no arguments are passed
function test_default_values()
    [dSided, minH, minD, minW, maxW] = parser();
    assert_checkequal(dSided ,%f);
    assert_checkequal(minH ,%eps);
    assert_checkequal(minD , 1);
    assert_checkequal(minW , 1);
    assert_checkequal(maxW , %inf);
endfunction

// Test case 2: Test with known valid input
function test_valid_input()
    [dSided, minH, minD, minW, maxW] = parser('minpeakheight', 0.1, 'minpeakdistance', 2, 'minpeakwidth', 3, 'maxpeakwidth', 5);
    
    assert_checkequal(dSided ,%f);
    assert_checkequal(minH , 0.1);
    assert_checkequal(minD , 2);
    assert_checkequal(minW , 3);
    assert_checkequal(maxW , 5);
endfunction

// Test case 3: Test with 'doublesided' flag
function test_doublesided_flag()
    [dSided, minH, minD, minW, maxW] = parser('doublesided', 'minpeakheight', 0.1);
    
    assert_checkequal(dSided ,%t);
    assert_checkequal(minH , 0.1);
    assert_checkequal(minD , 1);  // default value for minD
    assert_checkequal(minW , 1);  // default value for minW
    assert_checkequal(maxW , %inf);  // default value for maxW
endfunction

// Test case 4: Test invalid input (negative values)
function test_invalid_input_negative_values()
    try 
        [dSided, minH, minD, minW, maxW] = parser('minpeakheight', -0.1);
    catch
        disp(lasterror());
    end
endfunction

// Test case 5: Test invalid input (missing values for required arguments)
function test_missing_argument_value()
    try
        [dSided, minH, minD, minW, maxW] = parser('minpeakheight');
    catch
        disp(lasterror());
    end
endfunction

// Test case 6: Test with an unknown argument
function test_unknown_argument()
    [dSided, minH, minD, minW, maxW] = parser('unknownarg', 5);
    
    assert_checkequal(dSided ,%f);
    assert_checkequal(minH ,%eps);
    assert_checkequal(minD , 1);
    assert_checkequal(minW , 1);
    assert_checkequal(maxW , %inf);
endfunction

// Run all tests
test_default_values();
test_valid_input();
test_doublesided_flag();
test_invalid_input_negative_values();
test_missing_argument_value();
test_unknown_argument();
disp("All tests completed successfully.");
