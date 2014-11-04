function out=simpleToneAdj(img, model)
%SIMPLETONEADJ performs tone adjustment without the two-scale decomposition
%directly on the luminance layer of an image.
%   Input
%   - img: RGB image to be modified
%   - model: RGB image from which the histogram will be taken
%   Output:
%   - out: the img after applying tone adjustment

disp('<<< simpleToneAdj was called');

rgb2yuv = [0.299 0.587 0.144; -0.14713 -0.28886 0.436; 0.615 -0.51499 -0.10001];
img_yuv = sth2sth(img, rgb2yuv);
model_yuv = sth2sth(model, rgb2yuv);

% assemble the output image
out_yuv = zeros(size(img));
out_yuv(:,:,1) = histeq(img_yuv(:,:,1), imhist(model_yuv(:,:,1)));
out_yuv(:,:,2:3) = img_yuv(:,:,2:3);
out = sth2sth(out_yuv, inv(rgb2yuv));

end
