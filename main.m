% Add folders and subfolders to path
addpath("functions\") % Functions
addpath("images\processed\") % Processed Images
databaseAvgRGBs = findAvgRGBDatabase(); % Get avrage rgb for database images

% Image loading
filterspec = {'*.jpg;*.tif;*.png;*.gif','All Image Files'};
[file,path] = uigetfile(filterspec);
imgInput = imread(fullfile(path,file));

%imshow(imgInput);

imgCell = splitIntoSegments(imgInput);

%avgRGBTest = findAvgRGB(imgCell(1,1));

% Cell containing avrage RGB values for each cell in imgCell
avgRGBCell = cell(size(imgCell));



plotIndex = 1;
% Number of subplots needed, rows, columns
[numPlotsR, numPlotsC] = size(imgCell);
for r = 1 : numPlotsR
    for c = 1 : numPlotsC
        % Subplot used to draw image split up in segments
        %subplot(numPlotsR, numPlotsC, plotIndex);
        % Draw specified cell
        %imshow(imgCell{r,c});
        % Take avrage rgb
        avgRGBCell{r,c} = findAvgRGB(imgCell(r,c));
        % Increment the subplot to the next location.
        %plotIndex = plotIndex + 1;
    end
end

% Code to find image in database
[~,indexToClosestMatch] = min(cellfun(@(x)min(abs(x-avgRGBCell{3,4})),databaseAvgRGBs(:,1)));
closestMatch = im2double(imread(string(databaseAvgRGBs(indexToClosestMatch,2))));
