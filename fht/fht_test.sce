//Note:
//    All these test case and results are taken from octave to check the correctness of our function
//tc-N-ot : result of octave function where N=test case number
//tc: test case
//test case 1:  fht(A)
tc1 = [
    2   3   4;
    9   1   0;
   11  33  26
];
tc1ot = [
   22.0000   37.0000   30.0000;
   -9.7321  -41.7128  -31.5167;
   -6.2679   13.7128   13.5167
];
//test case 2
tc2 = [8 19 7 3];
//fht(tc2)
tc2ot = [37   17   -7  -15];
//test case 3
tc3 = [
    2   7   8;
    0   0   2;
    2   4   8;
    0   9   1
];
//fht(tc3,2) --octave
tc3ot = [
    2    7   10;
    2    7    6
];
//test case 4
tc4 = [9 7;2 0];
// // fht(tc4,10,2)--octave
tc4ot = [
   16.0000   18.7776   17.8205   13.4943    7.4514    2.0000   -0.7776    0.1795    4.5057   10.5486;
    2.0000    2.0000    2.0000    2.0000    2.0000    2.0000    2.0000    2.0000    2.0000    2.0000
];
// //test case 5 

tc5 = [
    1   8   9;
    7   6   5;
    2   7   5;
];
tc5(:,:,2) = [
   10  11  12;
    3   8   1;
    0   7   1
];
// //fht(tc5,[],3)
tc5ot = [
   11  19  21;
   10  14   6;
    2  14   6
];
tc5ot(:,:,2) = [
   -9  -3  -3;
    4  -2   4;
    2   0   4
];
