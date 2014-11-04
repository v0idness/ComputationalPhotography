function filtered = demosaicMedian(img_rgb)
%DEMOSAICMEDIAN applies median filtering in order to remove color fringing artifacts
%originating from bilinear interpolation in demosaicing Bayer pattern images.
%   Input
%   - img_rgb: an RGB image with artifacts after Bayer demosaicing
%   Output
%   - filtered: input image with color fringing artifacts removed

disp('<<< demosaicMedian was called');

% transformation to YUV
rgb2yuv = [0.299 0.587 0.144; -0.14713 -0.28886 0.436; 0.615 -0.51499 -0.10001];
img_yuv = sth2sth(img_rgb, rgb2yuv);

% median filter with 5 x 5 neighborhood on U and V
img_yuv(:,:,2) = medfilt2(img_yuv(:,:,2),5,'symmetric');
img_yuv(:,:,3) = medfilt2(img_yuv(:,:,3),5,'symmetric');

% create RUV, GUV, BUV images
img_ruv = img_yuv;
img_guv = img_yuv;
img_buv = img_yuv;
img_ruv(:,:,1) = img_rgb(:,:,1);
img_guv(:,:,1) = img_rgb(:,:,2);
img_buv(:,:,1) = img_rgb(:,:,3);

% transformation matrices back to RGB
rgb2ruv = [1 0 0; -0.14713 -0.28886 0.436; 0.615 -0.51499 -0.10001];
grb2guv = [1 0 0; -0.28886 -0.14713 0.436; -0.51499 0.615 -0.10001];
brg2buv = [1 0 0; 0.436 -0.14713 -0.28886; -0.10001 0.615 -0.51499];

filteredR = sth2sth(img_ruv, inv(rgb2ruv));
filteredG = sth2sth(img_guv, inv(grb2guv));
filteredB = sth2sth(img_buv, inv(brg2buv));

% rearrange so the layers of GUV-> and BUV are in the correct RGB order
filteredG(:,:, [1 2 3]) = filteredG(:,:, [2 1 3]);
filteredB(:,:, [1 2 3]) = filteredB(:,:, [3 1 2]);

% generate masks for red, green and blue pixels
rMask = zeros(size(img_rgb, 1),size(img_rgb, 2));
gMask = zeros(size(img_rgb, 1),size(img_rgb, 2));
bMask = zeros(size(img_rgb, 1),size(img_rgb, 2));

rMask(1:2:end,1:2:end) = 1;
gMask(1:2:end,2:2:end) = 1; gMask(2:2:end,1:2:end) = 1;
bMask(2:2:end,2:2:end) = 1;

% apply masks in order to keep only those pixels from each of the images that had
% the correct values
filteredR = rMask .* filteredR;
filteredG = gMask .* filteredG;
filteredB = bMask .* filteredB;

filtered = filteredR + filteredG + filteredB;

end