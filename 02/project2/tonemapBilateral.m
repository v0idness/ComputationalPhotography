function out=tonemapBilateral(im, output_range)
%TONEMAPBILATERAL uses the bilateral filter to perform tone mapping of HDR
%images without "halo" effects.
%   Input
%   - im: HDR image
%   - output_range: parameter for compression, recommended value between 10
%                   and 30
%   Output:
%   - out: LDR RGB image after applying tone mapping

disp('<<< tonemapBilateral was called');

% dealing with NaN problems from neighboring log(0) pixels
im(im<0.00001)=0.00001;

out = zeros(size(im));

input_intensity = (1/61)*(im(:,:,1)*20 + im(:,:,2)*40 + im(:,:,3));

r = im(:,:,1)./input_intensity;
g = im(:,:,2)./input_intensity;
b = im(:,:,3)./input_intensity;

log_base = bfilt(log(input_intensity), 2, 0.12);
log_detail = log(input_intensity)-log_base;

compressionfactor = log(output_range)/(max(max(log_base))-min(min(log_base)));

log_offset = -(max(max(log_base))) * compressionfactor;
log_output_intensity = log_base * compressionfactor+log_offset+log_detail;

out(:,:,1) = r.*exp(log_output_intensity);
out(:,:,2) = g.*exp(log_output_intensity);
out(:,:,3) = b.*exp(log_output_intensity);

end