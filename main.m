% Add folders and subfolders to path
addpath("functions\") % Functions
addpath("functions\scielab\") % Scielab
addpath("images\processed\") % Database 1
addpath("images\processedFirstDownscale\") % Database 2
addpath("images\processedSecondDownscale\") % Database 3
databaseFilePath = "images\processed\";
[databaseAvgRGBs, databaseAvgLabs] = findAvgDatabaseColours(databaseFilePath); % Get avrage rgb for database images

% Image loading
filterspec = {'*.jpg;*.tif;*.png;*.gif','All Image Files'};
[file,path] = uigetfile(filterspec);
imgInput = imread(fullfile(path,file));

% Image based database optimization type
dbOptimizationType = "small"; % "small" for 10 colour samples with 50 database images close to those
                                                % "large" for 50 colour samples with 50 database images to match

if(dbOptimizationType == "small")
    colourSamples = 10;
    matchesPerSample = 5;
else
    colourSamples = 50;
    matchesPerSample = 1;
end

% Extract the dominant colours from the input image
colourMap = getDominantColours(imgInput, colourSamples);
colourMapLab = rgb2lab(colourMap);
colourMap = colourMap * 255; % Double representation to 0-255 rgb representation

% Image based database optimization
databaseImgOpt = imgBasedOpt(colourMapLab, databaseAvgLabs, matchesPerSample);

% Create cell containing "boxes" from the input image
imgCell = splitIntoSegments(imgInput);

% Cell containing avrage colour values for each cell in imgCell
avgRGBCell = cell(size(imgCell));
avgLabCell = cell(size(imgCell));


% Number of subplots needed, rows, columns
[numPlotsR, numPlotsC] = size(imgCell);
%plotIndex = 1;
for r = 1 : numPlotsR
    for c = 1 : numPlotsC
        % Subplot used to draw image split up in segments
        %subplot(numPlotsR, numPlotsC, plotIndex);
        % Draw specified cell
        %imshow(imgCell{r,c});
        % Take avrage rgb
        [avgRGBCell{r,c}, avgLabCell{r,c}] = findAvgColours(imgCell(r,c));
        % Increment the subplot to the next location.
        %plotIndex = plotIndex + 1;
    end
end

% Code to find image in database
%[~,indexToClosestMatch] = min(cellfun(@(x)min(abs(x-avgRGBCell{1,1})),databaseAvgRGBs(:,1)));
%closestMatch = im2double(imread(string(databaseAvgRGBs(indexToClosestMatch,2))));

outputIMG = cell(size(imgCell));
outputIMGLab = cell(size(imgCell));

[rows, cols] = size(outputIMG);


for r = 1 : rows
    for c = 1 : cols
        % RGB Image general database optimization / no optimization
        %[~,indexToClosestMatch] = min(cellfun(@(x)min(abs(x-avgRGBCell{r,c})),databaseAvgRGBs(:,1)));
        %outputIMG{r,c} = im2double(imread(string(databaseAvgRGBs(indexToClosestMatch,2))));

        % Lab Image general database optimization / no optimization
        %indexToClosestMatchLab = findSmallestDistE(avgLabCell{r,c},databaseAvgLabs);
        %outputIMGLab{r,c} = im2double(imread(string(databaseAvgLabs(indexToClosestMatchLab,2))));

        % Lab Image database optimization based on input image
        indexToClosestMatchLab = findSmallestDistE(avgLabCell{r,c},databaseImgOpt);
        outputIMGLab{r,c} = im2double(imread(string(databaseImgOpt(indexToClosestMatchLab,2))));
    end
end

%outputIMGmat = cell2mat(outputIMG);
outputIMGmatLab = cell2mat(outputIMGLab);
%imshow(outputIMGmat);
imshow(outputIMGmatLab);
%montage({outputIMGmat, outputIMGmatLab});

% Metrics for RGB image
%[mse, snr, snrHVS, meanDistE, maxDistE, meanDistEHVS, maxDistHVS, meanSCIELAB] = getQualityMetrics(imgInput, outputIMGmat);

%fprintf('\n The mean-squared error for the RGB reproduction is: %0.2f\n', mse);
%fprintf('\n The signal to noise ratio for the RGB reproduction is:  %0.2f\n', snr);
%fprintf('\n The signal to noise ratio for the RGB reproduction with HVS model is:  %0.2f\n', snrHVS);
%fprintf('\n The mean delta E value for the RGB reproduction is: %0.2f\n', meanDistE);
%fprintf('\n The max delta E value ratio for the RGB reproduction is:  %0.2f\n', maxDistE);
%fprintf('\n The mean delta E value for the RGB reproduction with HVS model is: %0.2f\n', meanDistEHVS);
%fprintf('\n The max delta E value ratio for the RGB reproduction with HVS model is:  %0.2f\n', maxDistHVS);
%fprintf('\n The mean  value S-CIELAB for the RGB reproduction is: %0.2f\n', meanSCIELAB);

%fprintf("\n");

% Metrics for Lab image
%[mse, snr, snrHVS, meanDistE, maxDistE,  meanDistEHVS, maxDistHVS, meanSCIELAB] = getQualityMetrics(imgInput, outputIMGmatLab);

%fprintf('\n The mean-squared error for the Lab reproduction is: %0.2f\n', mse);
%fprintf('\n The signal to noise ratio for the Lab reproduction is:  %0.2f\n', snr);
%fprintf('\n The signal to noise ratio for the Lab reproduction with HVS model is:  %0.2f\n', snrHVS);
%fprintf('\n The mean delta E value for the Lab reproduction is: %0.2f\n', meanDistE);
%fprintf('\n The max delta E value ratio for the Lab reproduction is:  %0.2f\n', maxDistE);
%fprintf('\n The mean delta E value for the Lab reproduction with HVS model is: %0.2f\n', meanDistEHVS);
%fprintf('\n The max delta E value ratio for the Lab reproduction with HVS model is:  %0.2f\n', maxDistHVS);
%fprintf('\n The mean  value S-CIELAB for the Lab reproduction is: %0.2f\n', meanSCIELAB);




