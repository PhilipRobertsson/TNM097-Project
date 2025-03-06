function [mse, snr, snrHVS, meanDeltaE, maxDeltaE, meanDeltaEHVS, maxDeltaEHVS, scielabMean] = getQualityMetrics(orgIMG,repIMG)
%GETQUALITYMETRICS Summary of this function goes here

% Initial processing and data extraction
[M, N, ~] = size(orgIMG);
repIMG = imresize(repIMG,[M N], 'bicubic');

% Make sure images are represented as doubles
orgIMG = im2double(orgIMG);
repIMG = im2double(repIMG);

% Difference between original and reproduced image
error = orgIMG - repIMG;

% Mean Squared Error
mse = sum(sum(sum(error .* error)) / (M * N));

% Signal to Noise Ratio between original and noise image
snr = 10*log10(sum(orgIMG(:).^2)/sum(error(:).^2));

% Create Lab representations of the original and reproduced image
orgIMGLab = rgb2lab(orgIMG);
repIMGLab = rgb2lab(repIMG);

% Calculate delta E distances between all pixels in both images
deltaE= sqrt((repIMGLab(:,:,1) - orgIMGLab(:,:,1)).^2+(repIMGLab(:,:,2) - orgIMGLab(:,:,2)).^2+(repIMGLab(:,:,3) - orgIMGLab(:,:,3)).^2);

% Extract the mean and max values from deltaE image
meanDeltaE = mean(deltaE(:));
maxDeltaE = max(deltaE(:));


% Create a filter which represents a dot-size of 0.0847 at the viewing
% distance 500mm
f=MFTsp(15,0.0847,500);

% Apply filter to each channel of the original image
orgIMGR=conv2(orgIMG(:,:,1),f,'same');
orgIMGG=conv2(orgIMG(:,:,2),f,'same');
orgIMGB=conv2(orgIMG(:,:,3),f,'same');

% Apply filter to each channel of the reproduced image
repIMGR=conv2(repIMG(:,:,1),f,'same');
repIMGG=conv2(repIMG(:,:,2),f,'same');
repIMGB=conv2(repIMG(:,:,3),f,'same');

% Apply filter to each channel of the error image
errorR=conv2(error(:,:,1),f,'same');
errorG=conv2(error(:,:,2),f,'same');
errorB=conv2(error(:,:,3),f,'same');

% Create new images from the filtered channels
orgIMGConv = zeros(size(orgIMG));
repIMGConv = zeros(size(orgIMG));
errorConv = zeros(size(orgIMG));

% Remove negative values from filtered original image
orgIMGConv(:,:,1) = im2double((orgIMGR>0).*orgIMGR);
orgIMGConv(:,:,2) = im2double((orgIMGG>0).*orgIMGG);
orgIMGConv(:,:,3) = im2double((orgIMGB>0).*orgIMGB);

% Remove negative values from filtered reproduced image
repIMGConv(:,:,1) = im2double((repIMGR>0).*repIMGR);
repIMGConv(:,:,2) = im2double((repIMGG>0).*repIMGG);
repIMGConv(:,:,3) = im2double((repIMGB>0).*repIMGB);

% Remove negative values from filtered error image
errorConv(:,:,1) = im2double((errorR>0).*errorR);
errorConv(:,:,2) = im2double((errorG>0).*errorG);
errorConv(:,:,3) = im2double((errorB>0).*errorB);


% Signal to Noise ratio between original and noise image with the eye model
% applied
snrHVS = 10*log10(sum(orgIMGConv(:).^2)/sum(errorConv(:).^2));

% Create Lab representations of filtered original and reproduced image
orgIMGConvLab = rgb2lab(orgIMGConv);
repIMGConvLab = rgb2lab(repIMGConv);

% Delta E distance between all pixels of botha images with the eye model
deltaEHVS = sqrt((repIMGConvLab(:,:,1) - orgIMGConvLab(:,:,1)).^2+(repIMGConvLab(:,:,2) - orgIMGConvLab(:,:,2)).^2+(repIMGConvLab(:,:,3) - orgIMGConvLab(:,:,3)).^2);

% Extract mean and max values from delta E image
meanDeltaEHVS = mean(deltaEHVS(:));
maxDeltaEHVS = max(deltaEHVS(:));

% Create XYZ representations of the original and reproduced image
orgIMGxyz = rgb2xyz(orgIMG);
repIMGxyz = rgb2xyz(repIMG);

% Calculate samples per degree, 78 inch or ~ 2 m viewing distance
ppi = 157.35;
d = 78.7401575;
samplePerDegree = ppi * d * tan(pi/180);
CIED65 =  [95.05, 100, 108.9];
format = 'xyz';

% Calculate CIELAB differences
scielabRes = scielab(samplePerDegree,orgIMGxyz,repIMGxyz,CIED65,format);

% Extract the mean value
scielabMean = mean(scielabRes(:));
end

