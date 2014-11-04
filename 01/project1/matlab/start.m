% Computational Photography Project 1
% Turned in by Laura Rettig - laura.rettig@unifr.ch
% written in Octave

%% Assignement 1

img = im2double(imread('imgs/1_lily.jpg'));

[grey inverted] = spanishCastle(img);

figure(1);
subplot(1,2,1);
imshow(grey);
title('Spanish Castle Illusion: greyscale image');
subplot(1,2,2);
imshow(inverted);
title('Spanish Castle Illusion: Inverted image');

%% Assignment 2.1

img = double(imread('imgs/foliage raw.tiff'))/4096;

out = demosaicBayer(img);

figure(2);
subplot(1, 2, 1);
imshow(img);
title('Raw greyscale Bayer pattern image');
subplot(1,2,2);
imshow(out);
title('Color image after Bayer demosaicing');

%% Assignment 2.2

img = double(imread('imgs/black and white raw.tif'))/255;

% linear interpolation
img_rgb = demosaicBayer(img);
% median filtering
filtered = demosaicMedian(img_rgb);

figure(3, 'color', [0.5 0.5 0.5]);
subplot(1,2,1);
imshow(img_rgb);
title('Color fringing after linear interpolation');
subplot(1,2,2);
imshow(filtered);
title('Median filtered image');



%% Assignment 2.3
img = im2double(imread('imgs/23_lufagreenhouse.jpg'));

% automatic color balance
out = autoColorBalance(img);

figure(4);
imshow(out);
title('Automatic color correction under grey world assumption');

% color balance with grey pixel selected
out = manualColorBalance(img, 252, 341);

figure(5);
imshow(out);
title('Color correction based on selected grey pixel');


%% Assignment 2.4
% linear transformation
img = im2double(imread('imgs/24_schwarzsee.jpg'));

[out plotx] = linearContrast(img, 0.2, 0.9);

figure(6);
subplot(1, 2, 1);
imshow(out);
title('Image with linear contrast correction');
subplot(1, 2, 2);
plot(plotx, [0 0 1 1]);
axis([0,1,0,1]);
xlabel('input intensity');
ylabel('output intensity');
pbaspect([1 1]);
title('Corresponding transformation');

%gamma transformation
img = im2double(imread('imgs/24_schwarzsee2.jpg'));

[out plotx ploty] = gammaTransformation(img, 0.67);

figure(7);
subplot(1,2,1);
imshow(out);
title('Transformed with gamma=0.67');
subplot(1,2,2);
plot(plotx,ploty);
axis([0,1,0,1]);
xlabel('input intensity');
ylabel('output intensity');
pbaspect([1 1]);
title('Corresponding transformation curve');

%% Bonus

% own image with 8 bit precision
img = double(imread('imgs/IMG_0871.tiff'))/255;

img = demosaicBayer(img);
img = demosaicMedian(img);
img = autoColorBalance(img);
[img _ _] = gammaTransformation(img, 0.67);
img = linearContrast(img, 0.2, 1);

figure(8);
imshow(img);
title('Improved RAW processing');

% unsuccessful transformations
%trans1 = [ 0.7474 -0.2301 -0.0567; -0.4056 1.1456 0.2975 ; -0.0222 0.0716 0.4181 ];
%img_conv = sth2sth(img, trans1);
%trans2 = [0.715146 0.284856 0.000000; 0.000000 1.000000 0.000000; 0.000000 0.041166 0.958839 ];
%img_conv2 = sth2sth(img_conv, trans2);