% Code Written by Daniel Anietie Eneh
% Student ID : H00421147
% B31SE-Image Processing Assignment 1

clear; close all; clc;

im = im2double(imread('images\eye-hand.png'));
[m, n] = size(im);
filter = ones(m, n);
imf = fftshift(fft2(im));
mag = abs(imf);
phase = angle(imf);

% Show the image corrupted by periodic ripples and its frequency domain
figure, imshow([im, 0.1 * (1 + log(mag))]);
title('An image corrupted by periodic ripples and its frequency domain');
impixelinfo;

delete_radius = 20;
delete_points = {[150, 125], [400, 125], [360, 390], [100, 390]};

% Set the filter to zero for the points to delete
for i = 1:length(delete_points)
    delete_point = delete_points{i};
    filter(delete_point(1) - delete_radius : delete_point(1) + delete_radius, delete_point(2) - delete_radius : delete_point(2) + delete_radius) = 0;
end

filter_frequency_domain = fftshift(fft2(filter));
filter_mag = abs(filter_frequency_domain);
filter_phase = angle(filter_frequency_domain);

% Apply the filter to the frequency domain image
filtered_imf = imf .* filter;
filtered_image = ifft2(ifftshift(filtered_imf));

% Update the magnitude and phase of the filtered image
filtered_mag = abs(filtered_imf);
filtered_phase = angle(filtered_imf);

% Show the filtered image, its frequency domain, and the filter in its frequency domain
figure, imshow([filtered_image, 0.1 * (1 + log(filtered_mag))]);
title('Reconstructed image and its frequency domain');
impixelinfo;
figure, imshow(0.1 * (1 + log(filter_mag)));
title('Filter in its frequency domain');
impixelinfo;
