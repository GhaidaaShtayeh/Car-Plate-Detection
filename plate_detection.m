close all;
clear all;

% Read the input image
im = imread('Number Plate Images/image2.png');

% Convert the image to grayscale
imgray = rgb2gray(im);

% Apply a Gaussian filter to smooth out the image
imgray = imgaussfilt(imgray, 1);

% Apply a median filter to remove salt and pepper noise
imgray = medfilt2(imgray, [3 3]);

% Binarize the grayscale image
imbin = imbinarize(imgray);

% Apply edge detection using the Prewitt operator
im = edge(imgray, 'prewitt');

% Below steps are to find the location of the number plate
% Compute region properties of the edges image
Iprops = regionprops(im, 'BoundingBox', 'Area');
area = Iprops.Area;
count = numel(Iprops);
maxa = area;
boundingBox = Iprops.BoundingBox;
for i = 1:count
   % Find the region with the maximum area
   if maxa < Iprops(i).Area
       maxa = Iprops(i).Area;
       boundingBox = Iprops(i).BoundingBox;
   end
end

% Crop the number plate area from the binarized image
im = imcrop(imbin, boundingBox);

% Remove small objects based on their area
im = bwareaopen(~im, 500);

% Get the width and height of the cropped image
[h, w] = size(im);

% Display the cropped number plate area
imshow(im);

% Read the letters from the cropped image
Iprops = regionprops(im, 'BoundingBox', 'Area', 'Image');
count = numel(Iprops);
noPlate = ''; % Initialize the variable for the number plate string.

for i = 1:count
   ow = length(Iprops(i).Image(1, :));
   oh = length(Iprops(i).Image(:, 1));
   if ow < (w / 2) && oh > (h / 3)
       % Read the letter corresponding to the binary image
       letter = Letter_detection(Iprops(i).Image);
       % Ignore "##" characters
       if ~strcmp(letter, '##')
           % Append the letter to the noPlate variable
           noPlate = [noPlate letter];
       end
   end
end

% Print the final license plate number
fprintf('noPlate = %s\n', noPlate);
search_number_plate(noPlate, 'numbers_plates.txt');
