% Code Written by Daniel Anietie Eneh


close all; clear all; clc;

im = im2double(imread('images\trui.tif'));
% im = im2double(imread('images\newborn.tif'));

[rows, cols] = size(im);
I_0 = im; % original image
I_n = zeros(rows, cols); % initialize filtered image

%The values of N and k can be adjusted for experimental analysis as seen in
%the report
N = 50; % number of iterations
k = 100; % positive constant



for n = 1 : N % iterations loop

  for x = 2 : rows - 1 % for each inner pixel row
    for y = 2 : cols - 1 % for each inner pixel column
        w_sum = 0;
        sigma = 0;
      for i = -1 : 1  
        for j = -1 : 1
            wij = exp(-k * abs(I_0(x, y)-I_0(x+i, y+j))); % calculate weight (wij) equation 3
            I = wij * I_0(x+i, y+j); % multiply weight by image pixel
            sigma = sigma + I; %sum convoluted property
            w_sum = w_sum + wij; %sum weights
        end 
      end

      I_n(x,y) = sigma/w_sum; % divide sigma by weight sum to get new value of pixels equation (2)
      
    end
  end

  I_0 = I_n;
  I_n = zeros(rows, cols);

end
subplot(1,2,1),imshow(im),title('Original Image');
subplot(1,2,2),imshow(I_0),title(sprintf('N Iterations : %d, K : %d', N, k));
