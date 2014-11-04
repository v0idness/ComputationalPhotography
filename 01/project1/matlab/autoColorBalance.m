function img_out = autoColorBalance(img_in)
%AUTOCOLORBALANCE corrects the color of the given image according to the grey world
%assumption in order to conform with color constancy.
%   Input
%   - img_in: an RGB image
%   Output
%   - img_out: image color balanced to average values

disp('<<< autoColorBalance was called');

%averages
avgR = mean(mean(img_in(:,:,1)));
avgG = mean(mean(img_in(:,:,2)));
avgB = mean(mean(img_in(:,:,3)));

greyValue = (avgR+avgG+avgB)/3;

%scaling factors given one fixed channel (green)
scaleR = greyValue./avgR;
scaleG = greyValue./avgG;
scaleB = greyValue./avgB;

%normalize color channels with green channel fixed
scaleR = scaleR./scaleG;
scaleB = scaleB./scaleG;

img_out = img_in;
img_out(:,:,1) = img_out(:,:,1).*scaleR;
img_out(:,:,3) = img_out(:,:,3).*scaleB;

end