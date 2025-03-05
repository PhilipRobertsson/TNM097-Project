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

montage(scaledImages, "Size", [10 20]);

%[databaseAvgRGBs, ~] = findAvgRGBDatabase(); % Get avrage rgb for database images

%load xyz.mat

%d65 = [95.047, 100, 108.883];
%distances = zeros(totLength,2);

%databaseXYZs = zeros(totLength,3);
%for k = 1:totLength
    %databaseXYZs(k,:) = (databaseAvgRGBs{k,1});
    %distances(k,1) = sqrt((d65(1,1)-databaseXYZs(k,1)).^2 + (d65(1,2)-databaseXYZs(k,2)).^2 + (d65(1,2)-databaseXYZs(k,3)).^2);
    %distances(k,2) = k;
%end

%distances = sortrows(distances,"descend");
%databaseXYZs = databaseXYZs';

%databaseXYZs = [databaseXYZs(:,distances(1,2)), databaseXYZs(:,distances(2,2)), databaseXYZs(:,distances(3,2))];
%plotGamut(databaseXYZs, "red");

