clear;
% Add folders and subfolders to path
addpath("functions\") % Functions
addpath("images\raw\") % Raw Images
addpath("images\processed\") % Processed images
addpath("images\processedFirstDownscale\") % Processed images after first downscale
addpath("images\processedSecondDownscale\") % Processed images after second downscale

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

database1Images = {};

for k = 1 : length(theFiles)
    baseFileName = theFiles(k).name;
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
    database1Images = [database1Images, IMGres];
end

%montage(database2Images, "Size", [10 20]);

[databaseAvgRGBs, databaseAvgLabs] = findAvgDatabaseColours(filePathProc); % Get avrage rgb for database images

[databaseRemove, databaseKeep] = removeSimilar(databaseAvgLabs, 6.17);

filePathProc2 = 'images\processedFirstDownscale\';

database2Images = {};

for  k = 1 : size(databaseKeep,1)
    baseFileName = databaseKeep{k,2};
    IMG = imread(append(filePathProc,baseFileName));

    fullFileName = fullfile(filePathProc2, baseFileName);
    imwrite(IMG, fullFileName);
    database2Images = [database2Images, IMG];
end

%montage(database2Images);

[databaseSecondRemove, databaseSecondKeep] = removeSimilar(databaseKeep, 11.44);

filePathProc3 = 'images\processedSecondDownscale\';

database3Images = {};

for  k = 1 : size(databaseSecondKeep,1)
    baseFileName = databaseSecondKeep{k,2};
    IMG = imread(append(filePathProc2,baseFileName));

    fullFileName = fullfile(filePathProc3, baseFileName);
    imwrite(IMG, fullFileName);
    database3Images = [database3Images, IMG];
end

%montage(database3Images, "Size", [6 9]);

%databaseInitialVec = sortrows(cell2vec(databaseAvgLabs).',1)';
%databaseFirstKeepVec = sortrows(cell2vec(databaseKeep).',1)';
%databaseSecondKeepVec = sortrows(cell2vec(databaseSecondKeep).',1)';

%databaseAvgRamp = getColourRamp(databaseInitialVec, 100);
%databaseFirstKeepRamp = getColourRamp(databaseFirstKeepVec, 100);
%databaseSecondKeepRamp = getColourRamp(databaseSecondKeepVec, 100);

%subplot(1, 3, 1);
%imshow(lab2rgb(databaseAvgRamp));
%title('Avrage Colours original database')

%subplot(1, 3, 2);
%imshow(lab2rgb(databaseFirstKeepRamp));
%title('Avrage Colours to keep from database')

%subplot(1, 3, 3);
%imshow(lab2rgb(databaseSecondKeepRamp));
%title('Avrage Colours to keep from first reduction')

