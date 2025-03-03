function [cellAvgRGB, cellAvgLab] = findAvgRGBDatabase()
%Creates cell of all avarage rgb values in the database
addpath("images\processed\");
filePathProc = 'images\processed\';

% Read all files in database
filePatternPNG = fullfile(filePathProc, '*.png');
filePatternJPG = fullfile(filePathProc, '*.jpg');
filePatternJPEG = fullfile(filePathProc, '*.jpeg');

theFilesPNG = dir(filePatternPNG);
theFilesJPG = dir(filePatternJPG);
theFilesJPEG = dir(filePatternJPEG);

totLength = length(theFilesJPEG) + length(theFilesJPG) + length(theFilesPNG);
theFiles = struct("name",[],"folder",[]);
structrow = 0;

for k = 1 : totLength

    if k <= length(theFilesPNG)
        structrow = structrow + 1;
        theFiles(structrow).name = theFilesPNG(k,1).name;
        theFiles(structrow).folder = theFilesPNG(k,1).folder;
    end

    if k <= length(theFilesJPEG)
        structrow = structrow + 1;
        theFiles(structrow).name = theFilesJPEG(k,1).name;
        theFiles(structrow).folder = theFilesJPEG(k,1).folder;
    end

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
    IMGLab = rgb2lab(IMG);

    if(size(IMG, 3) == 3)
        redChannel = IMG(:, :, 1);
        greenChannel = IMG(:, :, 2);
        blueChannel = IMG(:, :, 3);
    else
        redChannel = IMG;
        greenChannel = IMG;
        blueChannel = IMG;
    end

    LChannel = IMGLab(:,:,1);
    aChannel = IMGLab(:,:,2);
    bChannel = IMGLab(:,:,3);
    
    %totR = 0;
    %totG = 0;
    %totB = 0;
    %totV = 0;

    %totL = 0;
    %tota = 0;
    %totb = 0;
    
    % Total values
    %for r = 1 : size(IMG,2)
        %for c = 1 : size(IMG,1)
            %if(size(IMG,3) > 1) % RGB images
                %totR = totR + double(IMG(c,r,1));
                %totG = totG + double(IMG(c,r,2));
                %totB = totB + double(IMG(c,r,3));
                
                %totL = totL + IMGLab(c,r,1);
                %tota = tota + IMGLab(c,r,2);
                %totb = totb + IMGLab(c,r,3);
            %else % Grayscale images
                %totV = totV + double(IMG(c,r));
            %end
        %end
    %end
    
    % Total size of image
    %IMGSize = size(IMG,1)*size(IMG,2);

    % If grayscale set RGB to identical values
    %if(size(IMG,3) == 1)
        %totR = totV;
        %totG = totV;
        %totB = totV;

        %totL = totV;
        %tota = 0;
        %totb = 0;
    %end

    % Find avrage
    %avgR = floor(totR/(IMGSize));
    %avgG = floor(totG/(IMGSize));
    %avgB = floor(totB/(IMGSize));

    %avgL = floor(totL/(IMGSize));
    %avga = floor(tota/(IMGSize));
    %avgb = floor(totb/(IMGSize));

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

