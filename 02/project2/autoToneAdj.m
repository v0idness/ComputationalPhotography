function out=autoToneAdj(img, model, scale_detail)
%AUTOTONEADJ performs automatic tone adjustment of an image to match the
%overall "feeling" of a model image. For that it decomposes the image and
%the model into a base and a detail layer, matches the histogram of the
%image's base to that of the model, and then reassembles the image while 
%enhancing the details.
%   Input
%   - img: RGB image to be modified
%   - model: RGB image from which the histogram will be taken
%   - scale_detail: the factor by which the details shall be boosted
%   Output:
%   - out: the img after applying tone adjustment

disp('<<< autoToneAdj was called');

rgb2yuv = [0.299 0.587 0.144; -0.14713 -0.28886 0.436; 0.615 -0.51499 -0.10001];
img_yuv = sth2sth(img, rgb2yuv);
model_yuv = sth2sth(model, rgb2yuv);

img_base = bfilt(img_yuv(:,:,1), 2, 0.12);
model_base = bfilt(model_yuv(:,:,1), 2, 0.12);

img_detail = img_yuv(:,:,1)-img_base;
%model_detail = model_yuv(:,:,1)-model_base;

figure(10);
subplot(1,2,1);
imhist(img_base)
title('histogram of the image base');
subplot(1,2,2);
imhist(model_base)
title('histogram of the model base');

figure(11);
subplot(2,2,1);
imshow(img_base);
title('img large scale layer');
subplot(2,2,2);
imshow(img_detail .* scale_detail);
title('scaled img detail layer');
subplot(2,2,3);
imshow(model_base);
title('model large scale layer');

img_base_mod = histeq(img_base, imhist(model_base));

subplot(2,2,4);
imshow(img_base_mod);
title('histogram matched large scale img layer');

% assemble the output image
out_yuv = zeros(size(img));
out_yuv(:,:,1) = img_base_mod + (img_detail .* scale_detail);
out_yuv(:,:,2:3) = img_yuv(:,:,2:3);
out = sth2sth(out_yuv, inv(rgb2yuv));

end
