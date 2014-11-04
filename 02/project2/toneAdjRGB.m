function out=toneAdjRGB(img, model)
%TONEADJRGB performs histogram equalization channel-wise on RGB images. 
%   Input
%   - img: m x n x 3 RGB image which is to be modified
%   - model: m x n x 3 RGB image from which the histograms are matched
%   Output:
%   - out: the input adjusted such that the histogram for each color 
%          channel matches that of the respective channel in the model

disp('<<< toneAdjRGB was called');

out = zeros(size(img));
out(:,:,1) = histeq(img(:,:,1),imhist(model(:,:,1)));
out(:,:,2) = histeq(img(:,:,2),imhist(model(:,:,2)));
out(:,:,3) = histeq(img(:,:,3),imhist(model(:,:,3)));

end
