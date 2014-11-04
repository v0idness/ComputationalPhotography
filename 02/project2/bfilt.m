function out=bfilt(im,sigma_s,sigma_r)
%BFILT performs bilateral filtering on a given image. The bilateral filter
%is an edge-preserving blur filter.
%   Input
%   - im: the image to be blurred (greyscale m x n x 1)
%   - sigma_s: spatial standard deviation parameter
%   - sigma_r: range standard deviation parameter
%   Output:
%   - out: the input image with the filter applied (i.e. blurred)


disp('<<< bfilt was called');

out = zeros(size(im));
w = ceil(1.5*sigma_s);
N_x = 2*w+1;

% distances are shift invariant
t1 = repmat([-w:w], 2*w+1, 1);
t2 = repmat([-w:w]', 1, 2*w+1);

% 2D Gaussian filter h(t1,t2) for distance weight
h = exp(-((t1.^2+t2.^2)/(2*sigma_s^2)));

% for the height of the image (all rows)
for i=1:size(im, 1)
    % top and bottom neighboorhod boundaries
    top = max(i-w, 1);
    % around edges, remove part of the Gaussian filter h
    h_top = 1+top-(i-w);
    
    bottom = min(i+w, size(im, 1));
    h_bottom = N_x-((i+w)-bottom);
    
    % for the width of the image (all pixels on each row)
    for j=1:size(im, 2)
        % left and right neighborhood boundaries
        left = max(j-w,1);
        h_left = 1+left-(j-w);
        right = min(j+w, size(im, 2));
        h_right = N_x-((j+w)-right);
        
        % neighborhood region intensities
        N = im(top:bottom, left:right);
        x = im(i,j);
        
        % 1D Gaussian filter for range weight
        d = exp(-(((N-x).^2)/(2*sigma_r^2)));
        
        % normalization term
        k = h(h_top:h_bottom, h_left:h_right).*d;
        
        % output for all pixels in N
        J = sum(k(:).*N(:))/sum(k(:));
        
        out(i,j) = J;
    end
    
end

end