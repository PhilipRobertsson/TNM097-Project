% Add folders and subfolders to path
addpath("functions\") % Functions
addpath("images\processed\") % Processed Images
[databaseAvgRGBs, databaseAvgLabs] = findAvgRGBDatabase(); % Get avrage rgb for database images

% Image loading
filterspec = {'*.jpg;*.tif;*.png;*.gif','All Image Files'};
[file,path] = uigetfile(filterspec);
imgInput = imread(fullfile(path,file));

%imshow(imgInput);

imgCell = splitIntoSegments(imgInput);

%avgRGBTest = findAvgRGB(imgCell(1,1));

% Cell containing avrage RGB values for each cell in imgCell
avgRGBCell = cell(size(imgCell));
avgLabCell = cell(size(imgCell));


% Number of subplots needed, rows, columns
[numPlotsR, numPlotsC] = size(imgCell);
for r = 1 : numPlotsR
    for c = 1 : numPlotsC
        % Subplot used to draw image split up in segments
        %subplot(numPlotsR, numPlotsC, plotIndex);
        % Draw specified cell
        %imshow(imgCell{r,c});
        % Take avrage rgb
        [avgRGBCell{r,c}, avgLabCell{r,c}] = findAvgRGB(imgCell(r,c));
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
        %[~,indexToClosestMatch] = min(cellfun(@(x)min(abs(x-avgRGBCell{r,c})),databaseAvgRGBs(:,1)));
        %outputIMG{r,c} = im2double(imread(string(databaseAvgRGBs(indexToClosestMatch,2))));

        indexToClosestMatchLab = findSmallestDistE(avgLabCell{r,c},databaseAvgLabs);
        outputIMGLab{r,c} = im2double(imread(string(databaseAvgLabs(indexToClosestMatchLab,2))));
    end
end

%outputIMGmat = cell2mat(outputIMG);
outputIMGmatLab = cell2mat(outputIMGLab);
%imshow(outputIMGmat);
imshow(outputIMGmatLab);
%montage({imgInput, outputIMGmatLab});




