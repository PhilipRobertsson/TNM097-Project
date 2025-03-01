% Add folders and subfolders to path
addpath("functions\") % Functions
addpath("images\processed\") % Processed Images

% Image loading
filterspec = {'*.jpg;*.tif;*.png;*.gif','All Image Files'};
[file,path] = uigetfile(filterspec);
imgInput = imread(fullfile(path,file));

imshow(imgInput);

% Divide image into smaller segments
segmentSizeR = 250; % R, rows
segmentSizeC = 250; % C, columns
[rows, columns, channels] = size(imgInput);

% Number of segments for rows
wholeSegmentRows = floor(rows / segmentSizeR);
% Row size for every segment, remaining row size for edge segment
SegmentVectorR = [segmentSizeR * ones(1, wholeSegmentRows), rem(rows, segmentSizeR)];

% Number of segments for columns
wholeSegmentCols = floor(columns / segmentSizeC);
% Column size for every segment, remaining column size for edge segment
SegmentVectorC = [segmentSizeC * ones(1, wholeSegmentCols), rem(columns, segmentSizeC)];

% Split image into cells based on previous calculations
if channels > 1
    % Colour.
    imgCell = mat2cell(imgInput, SegmentVectorR, SegmentVectorC, channels);
else
    % Grayscale
    imgCell = mat2cell(imgInput, SegmentVectorR, SegmentVectorC);
end

% Index for subplot
plotIndex = 1;
% Number of subplots needed, rows, columns
[numPlotsR, numPlotsC] = size(imgCell);
for r = 1 : numPlotsR
    for c = 1 : numPlotsC
        % Subplot used to draw image split up in segments
        subplot(numPlotsR, numPlotsC, plotIndex);
        % Draw specified cell
        imshow(imgCell{r,c}); 
        % Increment the subplot to the next location.
        plotIndex = plotIndex + 1;
    end
end

