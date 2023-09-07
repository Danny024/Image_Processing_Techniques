% Code Written by Daniel Anietie Eneh
% Student ID : H00421147
% B31SE-Image Processing Assignment 1

clear; close all; clc;

% Converts the image to double precision
im = im2double(imread('images\8.bmp'));

% Get the size of the image
[rows, cols, channels] = size(im);

% Split the image into its R, G, and B channels
image_r = im(:,:,1);
image_g = im(:,:,2);
image_b = im(:,:,3);

% Set parameters for filter
k = 100;
N = 50;
eps = 0.1;

% Initialize T and U matrices
T = zeros(rows, cols);
U = T;

% Function to find the maximum value of each pixel among the R, G, and B channels
for x = 1: rows;
    for y = 1 : cols;
        val_L(1)=image_r(x,y);
        val_L(2) = image_g(x,y);
        val_L(3) = image_b(x,y);
        T(x,y) = max(val_L); % equation 5
    end
end

% Perform Filtering
for n = 1:N
    for x = 2 : rows-1
        for y = 2:cols-1
            w_sum = 0;
            sigma = 0;
            for i=-1 : 1
                for j = -1:1
                    wij = exp(-k*abs(T(x,y)- T(x+i,y+j)));
                    I = wij*T(x+i,y+j);
                    sigma = sigma + I;
                    w_sum = w_sum + wij;
                end
            end

            U(x,y) = sigma./w_sum;
        end
    end
end

% Compute the enhanced version of the R, G, and B channels
for x = 1 : rows;
    for y = 1 : cols;
        % Equation 6 for different r, g, b channels
        E_r (x,y) = image_r (x,y)/(U(x,y)+eps); 
        E_g (x,y) = image_g (x,y)/(U(x,y)+eps);
        E_b(x,y) = image_b(x,y)/(U(x,y)+eps);
    end
end

% Concatenate the enhanced R, G, and B channels to form the final enhanced image
E = cat(3,E_r,E_g,E_b);
subplot(1,2,1),imshow(im),title('Original Image');
subplot(1,2,2),imshow(E),title(sprintf('Enhanced image at N Iter = %d, K = %d', N, k));



