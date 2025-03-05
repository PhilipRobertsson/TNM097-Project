function [mse, snr, snrHVS, meanDeltaE, maxDeltaE, meanDeltaEHVS, maxDeltaEHVS, scielabMean] = getQualityMetrics(orgIMG,repIMG)
%GETQUALITYMETRICS Summary of this function goes here

% Initial processing and data extraction
[M, N, ~] = size(orgIMG);
repIMG = imresize(repIMG,[M N], 'bicubic');

orgIMG = im2double(orgIMG);
repIMG = im2double(repIMG);

error = orgIMG - repIMG;
mse = sum(sum(sum(error .* error)) / (M * N));

snr = 10*log10(sum(orgIMG(:).^2)/sum(error(:).^2));

orgIMGLab = rgb2lab(orgIMG);
repIMGLab = rgb2lab(repIMG);

deltaE= sqrt((repIMGLab(:,:,1) - orgIMGLab(:,:,1)).^2+(repIMGLab(:,:,2) - orgIMGLab(:,:,2)).^2+(repIMGLab(:,:,3) - orgIMGLab(:,:,3)).^2);

meanDeltaE = mean(deltaE(:));
maxDeltaE = max(deltaE(:));

f=MFTsp(15,0.0847,500);

orgIMGR=conv2(orgIMG(:,:,1),f,'same');
orgIMGG=conv2(orgIMG(:,:,2),f,'same');
orgIMGB=conv2(orgIMG(:,:,3),f,'same');

repIMGR=conv2(repIMG(:,:,1),f,'same');
repIMGG=conv2(repIMG(:,:,2),f,'same');
repIMGB=conv2(repIMG(:,:,3),f,'same');

errorR=conv2(error(:,:,1),f,'same');
errorG=conv2(error(:,:,2),f,'same');
errorB=conv2(error(:,:,3),f,'same');

orgIMGConv = zeros(size(orgIMG));
repIMGConv = zeros(size(orgIMG));
errorConv = zeros(size(orgIMG));

repIMGConv(:,:,1) = im2double((repIMGR>0).*repIMGR);
repIMGConv(:,:,2) = im2double((repIMGG>0).*repIMGG);
repIMGConv(:,:,3) = im2double((repIMGB>0).*repIMGB);

orgIMGConv(:,:,1) = im2double((orgIMGR>0).*orgIMGR);
orgIMGConv(:,:,2) = im2double((orgIMGG>0).*orgIMGG);
orgIMGConv(:,:,3) = im2double((orgIMGB>0).*orgIMGB);

errorConv(:,:,1) = im2double((errorR>0).*errorR);
errorConv(:,:,2) = im2double((errorG>0).*errorG);
errorConv(:,:,3) = im2double((errorB>0).*errorB);



snrHVS = 10*log10(sum(orgIMGConv(:).^2)/sum(errorConv(:).^2));

orgIMGConvLab = rgb2lab(orgIMGConv);
repIMGConvLab = rgb2lab(repIMGConv);


deltaEHVS = sqrt((repIMGConvLab(:,:,1) - orgIMGConvLab(:,:,1)).^2+(repIMGConvLab(:,:,2) - orgIMGConvLab(:,:,2)).^2+(repIMGConvLab(:,:,3) - orgIMGConvLab(:,:,3)).^2);

meanDeltaEHVS = mean(deltaEHVS(:));

maxDeltaEHVS = max(deltaEHVS(:));

orgIMGxyz = rgb2xyz(orgIMG);
repIMGxyz = rgb2xyz(repIMG);

ppi = 157.35;
d = 78.7401575;
samplePerDegree = ppi * d * tan(pi/180);
CIED65 =  [95.05, 100, 108.9];
format = 'xyz';

scielabRes = scielab(samplePerDegree,orgIMGxyz,repIMGxyz,CIED65,format);

scielabMean = mean(scielabRes(:));
end

