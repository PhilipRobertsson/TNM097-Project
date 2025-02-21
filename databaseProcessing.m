clear;
% Add folders and subfolders to path
addpath("functions\") % Functions
addpath("images\raw\") % Raw Images
addpath("images\processed\") % Processed images

filePathRaw = 'images\raw\';
filePathProc = 'images\processed\';

filePatternPNG = fullfile(filePathRaw, '*.png');
filePatternJPG = fullfile(filePathRaw, '*.jpg');
filePatternJPEG = fullfile(filePathRaw, '*.jpeg');

theFilesPNG = dir(filePatternPNG);
theFilesJPG = dir(filePatternJPG);
theFilesJPEG = dir(filePatternJPEG);

theFiles = [theFilesPNG,theFilesJPG, theFilesJPEG];

croppedImages = {};
scaledImages = {};

for k = 1 : length(theFiles)
    baseFileName = theFiles(k).name;
    fullFileName = fullfile(theFiles(k).folder, baseFileName);
    IMG = imread(append(filePathRaw,baseFileName));

    
    imgHeight = size(IMG,1);
    imgWidth = size(IMG,2);
    
    if(imgHeight > imgWidth)
        IMGcrop = imcrop(IMG, [floor((imgWidth-imgHeight)/2) floor((imgWidth-imgHeight)/2) floor((imgWidth+imgHeight)/2) floor((imgWidth+imgHeight)/2)]);
        IMGres=imresize(IMG,[imgWidth imgWidth],'bicubic');
    elseif(imgHeight < imgWidth)
        IMGcrop = imcrop(IMG, [floor((imgHeight-imgWidth)/2) floor((imgHeight-imgWidth)/2) floor((imgHeight+imgWidth)/2) floor((imgHeight+imgWidth)/2)]);
        IMGres=imresize(IMG,[imgHeight imgHeight],'bicubic');
    end

    croppedImages = [croppedImages, IMGcrop];
    scaledImages = [scaledImages, IMGres];
end

figure;
montage(croppedImages, "size", [1 3]);
figure;
montage(scaledImages, "size", [1 3]);
