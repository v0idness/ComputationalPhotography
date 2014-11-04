function out = demosaicBayer(img)
%DEMOSAICBAYER applies Bayer demosaicing using bilinear interpolation on nearest neighbors.
%   Input
%   - img: 2D matrix, RAW Bayer pattern image
%   Output
%   - out: RGB color image

disp('<<< demosaicBayer was called');

% generate masks for red, green and blue pixels
rMask = zeros(size(img, 1),size(img, 2));
gMask = zeros(size(img, 1),size(img, 2));
bMask = zeros(size(img, 1),size(img, 2));

rMask(1:2:end,1:2:end) = 1;
gMask(1:2:end,2:2:end) = 1; gMask(2:2:end,1:2:end) = 1;
bMask(2:2:end,2:2:end) = 1;

% multiplication of image with masks to get only certain pixels
rImg = rMask .* img;
gImg = gMask .* img;
bImg = bMask .* img;

% convolution and normalization
K = ones(3);

rInterp = conv2(rImg, K, 'same');
rInterp = rInterp ./ conv2(rMask, K, 'same');

gInterp = conv2(gImg, K, 'same');
gInterp = gInterp ./ conv2(gMask, K, 'same');

bInterp = conv2(bImg, K, 'same');
bInterp = bInterp ./ conv2(bMask, K, 'same');

% multiply interpolated matrix with inverse of mask in order to not overwrite original data
rInterp = rInterp .* (1-rMask);
rImg = rImg + rInterp;

gInterp = gInterp .* (1-gMask);
gImg = gImg + gInterp;

bInterp = bInterp .* (1-bMask);
bImg = bImg + bInterp;

% combine color channels to RGB m x n x 3
out = cat(3, rImg, gImg, bImg);

end