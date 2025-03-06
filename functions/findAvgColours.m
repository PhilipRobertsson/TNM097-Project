function [avgRGB,avgLab] = findAvgColours(cellInput)

% Convert the cell to a normal image matrix
imgSquare = cell2mat(cellInput);
imgSquareLab = rgb2lab(im2double(imgSquare));

% Full colour image
if(size(imgSquare, 3) == 3)
    redChannel = imgSquare(:, :, 1);
    greenChannel = imgSquare(:, :, 2);
    blueChannel = imgSquare(:, :, 3);
else % Grayscale image
    redChannel = imgSquare;
    greenChannel = imgSquare;
    blueChannel = imgSquare;
end

% Lab image
LChannel = imgSquareLab(:,:,1);
aChannel = imgSquareLab(:,:,2);
bChannel = imgSquareLab(:,:,3);

% Find avrages for RGB and Lab images
avgR = floor(mean(redChannel(:)));
avgG = floor(mean(greenChannel(:)));
avgB = floor(mean(blueChannel(:)));

avgL = floor(mean(LChannel(:)));
avga = floor(mean(aChannel(:)));
avgb = floor(mean(bChannel(:)));

avgRGB = [avgR, avgG, avgB];
avgLab = [avgL, avga, avgb];