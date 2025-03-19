function [cellAvgRGB, cellAvgLab] = findAvgDatabaseColours(databaseFilePath)
%Creates cell of all avarage colours in the database

addpath(databaseFilePath);
filePathProc = databaseFilePath;

% Define variables for the different file formats existent 
filePatternPNG = fullfile(filePathProc, '*.png');
filePatternJPG = fullfile(filePathProc, '*.jpg');
filePatternJPEG = fullfile(filePathProc, '*.jpeg');

% Define variables for the different file directories
theFilesPNG = dir(filePatternPNG);
theFilesJPG = dir(filePatternJPG);
theFilesJPEG = dir(filePatternJPEG);

% Total amount of files in the database
totLength = length(theFilesJPEG) + length(theFilesJPG) + length(theFilesPNG);
theFiles = struct("name",[],"folder",[]);

% Used to define where to insert images from the directories
structrow = 0;

% Loop through the images in the database
for k = 1 : totLength

    % Make sure k is smaller than the amount of PNG images
    if k <= length(theFilesPNG)
        structrow = structrow + 1;
        theFiles(structrow).name = theFilesPNG(k,1).name;
        theFiles(structrow).folder = theFilesPNG(k,1).folder;
    end
    
    % Make sure k is smaller than the amount of JPEG images
    if k <= length(theFilesJPEG)
        structrow = structrow + 1;
        theFiles(structrow).name = theFilesJPEG(k,1).name;
        theFiles(structrow).folder = theFilesJPEG(k,1).folder;
    end

    % Make sure k is smaller than the amount of JPG images
    if k <= length(theFilesJPG)
        structrow = structrow + 1;
        theFiles(structrow).name = theFilesJPG(k,1).name;
        theFiles(structrow).folder = theFilesJPG(k,1).folder;
    end

end

% Create cell to hold avrage rgb values and filenames
cellAvgRGB = cell(size(theFiles,1),2);
cellAvgLab = cell(size(theFiles,1),2);

% Go through all files
for k = 1 : length(theFiles)
    baseFileName = theFiles(k).name;
    mustBeTextScalar(baseFileName);
    IMG = imread(append(filePathProc,baseFileName));
    IMGLab = rgb2lab(im2double(IMG));

    % Full colour RGB image
    if(size(IMG, 3) == 3)
        redChannel = IMG(:, :, 1);
        greenChannel = IMG(:, :, 2);
        blueChannel = IMG(:, :, 3);
    else % Grayscale image
        redChannel = IMG;
        greenChannel = IMG;
        blueChannel = IMG;
    end

    % Lab image
    LChannel = IMGLab(:,:,1);
    aChannel = IMGLab(:,:,2);
    bChannel = IMGLab(:,:,3);
    

    % Find avrages for RGB and Lab images
    avgR = floor(mean(redChannel(:)));
    avgG = floor(mean(greenChannel(:)));
    avgB = floor(mean(blueChannel(:)));

    avgL = floor(mean(LChannel(:)));
    avga = floor(mean(aChannel(:)));
    avgb = floor(mean(bChannel(:)));

    avgRGB = [avgR, avgG, avgB];
    avgLab = [avgL, avga, avgb];
    
    % Assign values to cell
    cellAvgRGB{k,1} = avgRGB;
    cellAvgRGB{k,2} = baseFileName;

    cellAvgLab{k,1} = avgLab;
    cellAvgLab{k,2} = baseFileName;

end

end

