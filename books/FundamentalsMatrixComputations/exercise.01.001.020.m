A11 = [1;2];
A21 = [[3,2];[1,1]];
A12 = [-1];
A22 = [0,1];
A = [[A11,A21];[A12,A22]]

X11 = [1];
X21 = [0,1];
X12 = [2;-1];
X22 = [[1,1];[2,0]];
X = [[X11,X21];[X12,X22]]

A*X
[
    [A11*X11+A21*X12,A11*X21+A21*X22];
    [A12*X11+A22*X12,A12*X21+A22*X22]
]