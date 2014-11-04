% Computational Photography Project 2
% Turned in by Laura Rettig - laura.rettig@unifr.ch

%% Exercise 2.1

img = im2double(imread('imgs/ottawa.jpg'));
% bilateral filter on Y channel of color image
rgb2yuv = [0.299 0.587 0.144; -0.14713 -0.28886 0.436; 0.615 -0.51499 -0.10001];
img_yuv = sth2sth(img, rgb2yuv);
img_yuv(:,:,1) = bfilt(img_yuv(:,:,1), 2, 0.12);
out = sth2sth(img_yuv, inv(rgb2yuv));
figure(1);
subplot(1,2,1);
imshow(img);
title('Before');
subplot(1,2,2);
imshow(out);
title('Denoising with the bilateral filter (2, 0.12)');

%% Exercise 2.2

img = rgb2gray(im2double(imread('imgs/ducks_murten.jpg')));
img = img(375:535, 300:590, :);
figure(2);
subplot(3,3,1);
imshow(bfilt(img,2,0.1));
title('sigma_s = 2; sigma_r = 0.1');
subplot(3,3,2);
imshow(bfilt(img,2,0.25));
title('sigma_s = 2; sigma_r = 0.25');
subplot(3,3,3);
imshow(bfilt(img,2,10));
title('sigma_s = 2; sigma_r = 10');
subplot(3,3,4);
imshow(bfilt(img,6,0.1));
title('sigma_s = 6; sigma_r = 0.1');
subplot(3,3,5);
imshow(bfilt(img,6,0.25));
title('sigma_s = 6; sigma_r = 0.25');
subplot(3,3,6);
imshow(bfilt(img,6,10));
title('sigma_s = 6; sigma_r = 10');
subplot(3,3,7);
imshow(bfilt(img,18,0.1));
title('sigma_s = 18; sigma_r = 0.1');
subplot(3,3,8);
imshow(bfilt(img,18,0.25));
title('sigma_s = 18; sigma_r = 0.25');
subplot(3,3,9);
imshow(bfilt(img,18,10));
title('sigma_s = 18; sigma_r = 10');

%% Exercise 2.3

img = hdrread('imgs/grandfey.hdr');
out = tonemapBilateral(img, 20); 
figure(3);
imshow(out);
title('HDR image after tone mapping with the bilateral filter');

%% Exercise 2.4

img = hdrread('imgs/grandfey.hdr');
out = tonemapGaussian(img, 20);
figure(4);
imshow(out);
title('Tone mapping with Gaussian filter');

%% Exercise 3.1

img = im2double(imread('imgs/lily.jpg'));
model = im2double(imread('imgs/winterstorm.png'));
out = autoToneAdj(img, model, 5);
figure(5);
imshow(out);
title('Tone adjustment using two-scale decomp and detail boosting');

%% Exercise 3.3

img = im2double(imread('imgs/nice.jpg'));
model = im2double(imread('imgs/fribourgbw.jpg'));
out = simpleToneAdj(img, model);
figure(6);
imshow(out);
title('Simple tone adjustment by matching the Y channel histograms');

%% Bonus: interesting model histograms

img = im2double(imread('imgs/bonus_stjean.jpg'));
model = im2double(imread('imgs/model_gradient.png'));
out = autoToneAdj(img, model, 0.5);
figure(7);
imshow(out);
title('Bonus: interesting model histograms.');
%% Bonus: channel-wise histogram equalization

img = im2double(imread('imgs/nice.jpg'));
model = im2double(imread('imgs/model_rgbcmy.png'));
out = toneAdjRGB(img, model);
figure(8);
imshow(out);
title('RGB channel-wise histogram equalization.');