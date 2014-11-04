function out=tonemapGaussian(im,output_range)
%TONEMAPGAUSSIAN performs tone mapping of and HDR image using a Gaussian
%filter. The image is decomposed into a base and a detail layer, tone
%mapping and compression applied in logarithmic space, then the image is
%reassambled.
%   Input
%   - img: m x n x 3 RGB image which is to be modified
%   - output_range: paramter for compression, recommended value between 10
%                   and 30
%   Output:
%   - out: a LDR (low dynamic range) version of the input HDR image

disp('<<< tonemapGaussian was called');

% dealing with NaN problems from neighboring log(0) pixels
im(im<0.00001)=0.00001;

out = zeros(size(im));

input_intensity = (1/61)*(im(:,:,1)*20 + im(:,:,2)*40 + im(:,:,3));

r = im(:,:,1)./input_intensity;
g = im(:,:,2)./input_intensity;
b = im(:,:,3)./input_intensity;

log_base = imfilter(log(input_intensity), fspecial('gaussian',21,8), 'symmetric');
log_detail = log(input_intensity)-log_base;

compressionfactor = log(output_range)/(max(max(log_base))-min(min(log_base)));

log_offset = -(max(max(log_base))) * compressionfactor;
log_output_intensity = log_base * compressionfactor+log_offset+log_detail;

out(:,:,1) = r.*exp(log_output_intensity);
out(:,:,2) = g.*exp(log_output_intensity);
out(:,:,3) = b.*exp(log_output_intensity);

end