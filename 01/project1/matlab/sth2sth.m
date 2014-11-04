function [ img_out ] = sth2sth( img_in, trans_matrix )
%RGB2YUV converts an image from one color space into the same image in some other 
%color space by applying the transformation matrix (e.g. RGB to YUV).
%   Input
%   - img_in: a m x n x 3 matrix (image with 3 channels)
%   - trans_matrix: a 3x3 transformation matrix
%   Output:
%   - img_out: the input image converted with the given transformation matrix



disp('<<< sth2sth was called');

% shift the m x n x 3 matrix to 3 x m x n
img_tmp = shiftdim(img_in, 2);

% reshape to bring all values for each color channel onto one row, dimensions 3 x m*n
img_tmp = reshape(img_tmp, 3, size(img_in, 1)*size(img_in, 2));

% transformation matrix RGB -> YUV
img_tmp = trans_matrix * img_tmp;

% reorganization
img_tmp = shiftdim(reshape(img_tmp, 3, size(img_in, 1), size(img_in, 2)), 1);

img_out = img_tmp;

end

