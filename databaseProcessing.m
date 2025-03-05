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

totLength = length(theFilesJPEG) + length(theFilesJPG) + length(theFilesPNG);
theFiles = struct("name",[],"folder",[],"date",[],"bytes",[],"isdir",[],"datenum",[]);
structrow = 0;

for k = 1 : totLength

    if k <= length(theFilesPNG)
        structrow = structrow + 1;
        theFiles(structrow).name = theFilesPNG(k,1).name;
        theFiles(structrow).folder = theFilesPNG(k,1).folder;
        theFiles(structrow).date = theFilesPNG(k,1).date;
        theFiles(structrow).bytes = theFilesPNG(k,1).bytes;
        theFiles(structrow).isdir = theFilesPNG(k,1).isdir;
        theFiles(structrow).datenum = theFilesPNG(k,1).datenum;
    end

    if k <= length(theFilesJPEG)
        structrow = structrow + 1;
        theFiles(structrow).name = theFilesJPEG(k,1).name;
        theFiles(structrow).folder = theFilesJPEG(k,1).folder;
        theFiles(structrow).date = theFilesJPEG(k,1).date;
        theFiles(structrow).bytes = theFilesJPEG(k,1).bytes;
        theFiles(structrow).isdir = theFilesJPEG(k,1).isdir;
        theFiles(structrow).datenum = theFilesJPEG(k,1).datenum;
    end

    if k <= length(theFilesJPG)
        structrow = structrow + 1;
        theFiles(structrow).name = theFilesJPG(k,1).name;
        theFiles(structrow).folder = theFilesJPG(k,1).folder;
        theFiles(structrow).date = theFilesJPG(k,1).date;
        theFiles(structrow).bytes = theFilesJPG(k,1).bytes;
        theFiles(structrow).isdir = theFilesJPG(k,1).isdir;
        theFiles(structrow).datenum = theFilesJPG(k,1).datenum;
    end
end

%croppedImages = {};
scaledImages = {};

for k = 1 : length(theFiles)
    baseFileName = theFiles(k).name;
    fullFileName = fullfile(theFiles(k).folder, baseFileName);
    IMG = imread(append(filePathRaw,baseFileName));
    
    % Used to find rgb images not in true colour
    %if(imfinfo(append(filePathRaw,baseFileName)).BitDepth < 24)
    %    imfinfo(append(filePathRaw,baseFileName))
    %end

    imgHeight = size(IMG,1);
    imgWidth = size(IMG,2);
    
    if(imgHeight > imgWidth)
        IMGres=imresize(IMG,[imgWidth imgWidth],'bicubic');
    elseif(imgHeight < imgWidth)
        IMGres=imresize(IMG,[imgHeight imgHeight],'bicubic');
    else
        IMGres = IMG;
    end
    
    % Grayscale image
    if(size(IMGres,3) ~= 3)
        IMGres = cat(3,IMGres,IMGres,IMGres);
    end

    IMGres = imresize(IMGres, [64 64], 'bicubic');

    fullFileName = fullfile(filePathProc, baseFileName);
    imwrite(IMGres, fullFileName);
    scaledImages = [scaledImages, IMGres];
end

%montage(scaledImages, "Size", [10 20]);

[databaseAvgRGBs, databaseAvgLabs] = findAvgRGBDatabase(); % Get avrage rgb for database images

databaseAvgRGBsVec = zeros(3,totLength);
databaseAvgLabsVec = zeros(4,totLength);

for k = 1:totLength
    databaseAvgRGBsVec(:,k) = [databaseAvgRGBs{k,1}(1); databaseAvgRGBs{k,1}(2); databaseAvgRGBs{k,1}(3)] ./256;
    databaseAvgLabsVec(:,k) = [databaseAvgLabs{k,1}(1); databaseAvgLabs{k,1}(2); databaseAvgLabs{k,1}(3); k];
end

databaseAvgRGBsVec = sortrows(databaseAvgRGBsVec.',1).';
databaseAvgLabsVec = sortrows(databaseAvgLabsVec.',1).';

databaseAvgRamp = zeros(100,totLength,3);
rampHeight = ones(100,totLength);
databaseAvgRamp(:,:,1) = rampHeight .* databaseAvgLabsVec(1,:);
databaseAvgRamp(:,:,2) = rampHeight .*databaseAvgLabsVec(2,:);
databaseAvgRamp(:, :,3) =rampHeight .* databaseAvgLabsVec(3,:);

imshow(lab2rgb(databaseAvgRamp));

%hold on
%plot(1:1:totLength, databaseAvgRGBsVec(1,:), "red");

%databaseAvgRGBsVec = sortrows(databaseAvgRGBsVec.',2).';

%plot(1:1:totLength, databaseAvgRGBsVec(2,:), "green");

%databaseAvgRGBsVec = sortrows(databaseAvgRGBsVec.',3).';

%plot(1:1:totLength, databaseAvgRGBsVec(3,:), "blue");
%hold off
