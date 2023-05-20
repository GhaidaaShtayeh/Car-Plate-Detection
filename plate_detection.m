close all;
clear all;

% Read the input image
im = imread('Number Plate Images/img1.png');
figure;
imshow(im);
title('Input Image');

% Convert the image to grayscale
imgray = rgb2gray(im);
figure;
imshow(imgray);
title('Grayscale Image');

% Apply a Gaussian filter to smooth out the image
imgray = imgaussfilt(imgray, 1);
figure;
imshow(imgray);
title('Smoothed Image');

% Apply a median filter to remove salt and pepper noise
imgray = medfilt2(imgray, [3 3]);
figure;
imshow(imgray);
title('Median Filtered Image');

% Binarize the grayscale image
imbin = imbinarize(imgray);
figure;
imshow(imbin);
title('Binarized Image');

% Apply edge detection using the Prewitt operator
edges = edge(imgray, 'prewitt');
figure;
imshow(edges);
title('Edge Detection');

% Dilation of the edges
se = strel('disk', 3);  % Adjust the size of the structuring element as needed
dilatedEdges = imdilate(edges, se);
figure;
imshow(dilatedEdges);
title('Dilated Edges');

% Below steps are to find the location of the number plate
% Compute region properties of the edges image
Iprops = regionprops(dilatedEdges, 'BoundingBox', 'Area');
area = Iprops.Area;
count = numel(Iprops);
maxArea = area;
boundingBox = Iprops.BoundingBox;
for i = 1:count
   % Find the region with the maximum area
   if maxArea < Iprops(i).Area
       maxArea = Iprops(i).Area;
       boundingBox = Iprops(i).BoundingBox;
   end
end

% Crop the number plate area from the binarized image
croppedPlate = imcrop(imbin, boundingBox);
figure;
imshow(croppedPlate);
title('Cropped Number Plate Area');

% Remove small objects based on their area
processedPlate = bwareaopen(~croppedPlate, 500);
figure;
imshow(processedPlate);
title('Processed Number Plate Area');

% Get the width and height of the cropped image
[h, w] = size(processedPlate);

% Read the letters from the cropped image
Iprops = regionprops(processedPlate, 'BoundingBox', 'Area', 'Image');
count = numel(Iprops);
licensePlate = ''; % Initialize the variable for the license plate string.

for i = 1:count
   ow = length(Iprops(i).Image(1, :));
   oh = length(Iprops(i).Image(:, 1));
   if ow < (w / 2) && oh > (h / 3)
       % Read the letter corresponding to the binary image
       letter = Letter_detection(Iprops(i).Image);
       % Ignore "##" characters
       if ~strcmp(letter, '##')
           % Append the letter to the licensePlate variable
           licensePlate = [licensePlate letter];
       end
   end
end

% Print the final license plate number
fprintf('licensePlate = %s\n', licensePlate);

% Search for the license plate number in the text file
search_number_plate(licensePlate, 'numbers_plates.txt');
