function [out plotx ploty] = gammaTransformation(img, gamma)
%GAMMATRANSFORMATION corrects the linear absorption of light by cameras by
%stretching or compressing the contrast
%   Input
%   - img: an RGB image
%   - gamma: a gamma value. <1: compression; >1: stretching
%   Output
%   - out: image after gamma transformation
%   - plotx: sorted 1D vector of the input Y channel values
%   - ploty: sorted 1D vector of the output Y channel values

rgb2yuv = [0.299 0.587 0.144; -0.14713 -0.28886 0.436; 0.615 -0.51499 -0.10001];
img_yuv = sth2sth(img, rgb2yuv);

% apply gamma correction: output = input^gamma
img_yuv_out = img_yuv;
img_yuv_out(:,:,1) = img_yuv(:,:,1).^gamma;

out = sth2sth(img_yuv_out, inv(rgb2yuv));

plotx = sort(reshape(img_yuv(:,:,1),1,size(img_yuv,1)*size(img_yuv,2)));
ploty = sort(reshape(img_yuv_out(:,:,1),1,size(img_yuv_out,1)*size(img_yuv_out,2)));


end