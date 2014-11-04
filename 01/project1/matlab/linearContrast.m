function [out plotx] = linearContrast(img, toMin, toMax)
%LINEARCONTRAST scales an image by mapping the input range [toMin,toMax] to [0,1]
%   Input
%   - img: an RGB image
%   - toMin: range lower value
%   - toMax: range upper value
%   Output
%   - out: image with contrast corrected according to the given values
%   - plotx: 1D vector of x coordinates for plotting the transformation (map to [0,1])

rgb2yuv = [0.299 0.587 0.144; -0.14713 -0.28886 0.436; 0.615 -0.51499 -0.10001];
img_yuv = sth2sth(img, rgb2yuv);

% normalize the YUV values within the range [toMin,toMax]
img_yuv2 = img_yuv;
img_yuv2(:,:,1) = (img_yuv(:,:,1)-toMin) ./(toMax-toMin);


out = sth2sth(img_yuv2, inv(rgb2yuv));
plotx = [0 toMin toMax 1];

end