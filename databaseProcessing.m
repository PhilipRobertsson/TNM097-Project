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

    imgHeight = size(IMG,1);
    imgWidth = size(IMG,2);
    
    if(imgHeight > imgWidth)
        IMGres=imresize(IMG,[imgWidth imgWidth],'bicubic');
    elseif(imgHeight < imgWidth)
        IMGres=imresize(IMG,[imgHeight imgHeight],'bicubic');
    else
        IMGres = IMG;
    end
    
    if(size(IMGres,3) ~= 3)
        cmap = cmap2gray(jet(256));
        IMGres = ind2rgb(IMGres,cmap);
    end
    IMGres = imresize(IMGres, [64 64], 'bicubic');

    fullFileName = fullfile(filePathProc, baseFileName);
    imwrite(IMGres, fullFileName);
    scaledImages = [scaledImages, IMGres];
end

montage(scaledImages);
