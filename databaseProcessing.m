clear;
% Add folders and subfolders to path
addpath("functions\") % Functions
addpath("images\raw\") % Raw Images
addpath("images\processed\") % Processed images
addpath("images\processedFirstDownscale\") % Processed images after first downscale
addpath("images\processedSecondDownscale\") % Processed images after second downscale

% Define variables for file paths
filePathRaw = 'images\raw\';
filePathProc = 'images\processed\';

% Define variables for the different file formats existent 
filePatternPNG = fullfile(filePathRaw, '*.png');
filePatternJPG = fullfile(filePathRaw, '*.jpg');
filePatternJPEG = fullfile(filePathRaw, '*.jpeg');

% Define variables for the different file directories
theFilesPNG = dir(filePatternPNG);
theFilesJPG = dir(filePatternJPG);
theFilesJPEG = dir(filePatternJPEG);

% Total amount of files in the database
totLength = length(theFilesJPEG) + length(theFilesJPG) + length(theFilesPNG);
theFiles = struct("name",[],"folder",[],"date",[],"bytes",[],"isdir",[],"datenum",[]);

% Used to define where to insert images from the directories
structrow = 0;

% Loop through the images in the database
for k = 1 : totLength

    % Make sure k is smaller than the amount of PNG images
    if k <= length(theFilesPNG)
        structrow = structrow + 1;
        theFiles(structrow).name = theFilesPNG(k,1).name;
        theFiles(structrow).folder = theFilesPNG(k,1).folder;
        theFiles(structrow).date = theFilesPNG(k,1).date;
        theFiles(structrow).bytes = theFilesPNG(k,1).bytes;
        theFiles(structrow).isdir = theFilesPNG(k,1).isdir;
        theFiles(structrow).datenum = theFilesPNG(k,1).datenum;
    end
    
    % Make sure k is smaller than the amount of JPEG images
    if k <= length(theFilesJPEG)
        structrow = structrow + 1;
        theFiles(structrow).name = theFilesJPEG(k,1).name;
        theFiles(structrow).folder = theFilesJPEG(k,1).folder;
        theFiles(structrow).date = theFilesJPEG(k,1).date;
        theFiles(structrow).bytes = theFilesJPEG(k,1).bytes;
        theFiles(structrow).isdir = theFilesJPEG(k,1).isdir;
        theFiles(structrow).datenum = theFilesJPEG(k,1).datenum;
    end

    % Make sure k is smaller than the amount of JPG images
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

% Initalize empty processeded database
database1Images = {};

% Process and save all database images to newly created database
for k = 1 : length(theFiles)
    baseFileName = theFiles(k).name;
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
    
    % Grayscale image
    if(size(IMGres,3) ~= 3)
        IMGres = cat(3,IMGres,IMGres,IMGres);
    end

    IMGres = imresize(IMGres, [64 64], 'bicubic');

    fullFileName = fullfile(filePathProc, baseFileName);
    imwrite(IMGres, fullFileName);
    database1Images = [database1Images, IMGres];
end

% Show processed database images
%montage(database1Images, "Size", [10 20]);

% Optimize the database based on colour differences
[databaseAvgRGBs, databaseAvgLabs] = findAvgDatabaseColours(filePathProc); % Get avrage rgb for database images
[databaseRemove, databaseKeep] = removeSimilar(databaseAvgLabs, 6.17);

% File path for downscaled database
filePathProc2 = 'images\processedFirstDownscale\';

% Initalize database for first downscale
database2Images = {};

% Loop through and save images to folder according to the file names in databaseKeep
for  k = 1 : size(databaseKeep,1)
    baseFileName = databaseKeep{k,2};
    IMG = imread(append(filePathProc,baseFileName));

    fullFileName = fullfile(filePathProc2, baseFileName);
    imwrite(IMG, fullFileName);
    database2Images = [database2Images, IMG];
end

% Show processed database images
%montage(database2Images);

[databaseSecondRemove, databaseSecondKeep] = removeSimilar(databaseKeep, 11.44);

% File path for more downscaled database
filePathProc3 = 'images\processedSecondDownscale\';

% Initalize database for second downscale
database3Images = {};

% Loop through and save images to folder according to the file names in databaseSecondKeep
for  k = 1 : size(databaseSecondKeep,1)
    baseFileName = databaseSecondKeep{k,2};
    IMG = imread(append(filePathProc2,baseFileName));

    fullFileName = fullfile(filePathProc3, baseFileName);
    imwrite(IMG, fullFileName);
    database3Images = [database3Images, IMG];
end

% Show processed database images
%montage(database3Images, "Size", [6 9]);


% Code to visualise the colour spaces of the different databases
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

