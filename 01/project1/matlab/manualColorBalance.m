function img_out = manualColorBalance(img_in, x, y)
%MANUALCOLORBALANCE implements color balancing based on a given pixel which is
%supposed to be grey.
%   Input
%   - img_in: an RGB image
%   - x: x coordinate of a pixel that is supposed to be grey
%   - y: y coordinate of a pixel that is supposed to be grey
%   Output
%   - img_out: image color balanced to average values of the given pixel

disp('<<< manualColorBalance was called');

% the color values at the selected pixel
rValue = img_in(y, x, 1);
gValue = img_in(y, x, 2);
bValue = img_in(y, x, 3);

% should be grey: average of the color values at the given pixel
greyValue = (rValue + gValue + bValue)/3;

% scaling factors for the selected pixel to be greyValue
scaleR = greyValue./rValue;
scaleG = greyValue./gValue;
scaleB = greyValue./bValue;

% normalize scaling factor to scaleG=1
scaleR = scaleR./scaleG;
scaleB = scaleB./scaleG;

% apply scaling factor to entire image
img_out = img_in;
img_out(:,:,1) = img_out(:,:,1).*scaleR;
img_out(:,:,3) = img_out(:,:,3).*scaleB;

end