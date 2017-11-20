function [C,number] = howmanyunique(A)

% Function to determine the unique data sets, and how many times each occurs
% Input: matrix of data
% Output: unique rows of input matrix, and frequency

B = sortrows(A);
[C, ib, ~] = unique(B, 'rows');
number = diff([ib; size(B,1)+1]);