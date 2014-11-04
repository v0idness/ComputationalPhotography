function [grey inverted] = spanishCastle( img )
%SPANISHCASTLE creates the greyscale and inverted image of the input
%   Input
%   - img: an RGB color image
%   Output
%   - grey: the greyscale image of the input image
%   - inverted: the inverted color image of the input



% replace the following example code with yours!
disp('<<< spanishCastle was called');

% Convert the RGB colors to YUV color space.
rgb2yuv = [0.299 0.587 0.144; -0.14713 -0.28886 0.436; 0.615 -0.51499 -0.10001];
img_yuv = sth2sth( img, rgb2yuv );

% Using the input Y channel to form the grey image.
grey = img_yuv(:,:,1);

% To obtain the inverted image, set the Y channel to 0.6 for all pixels,
% convert back to RGB, and invert the RGB colors by taking one minus the
% RGB values. The result is the inverted image.
img_yuv(:,:,1) = 0.6;

img_rgb = sth2sth(img_yuv, inv(rgb2yuv));

% inverting the RGB colors
inverted = 1-img_rgb;


end

