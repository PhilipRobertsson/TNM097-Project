function [imgCell] = splitIntoSegments(imgInput)
%Used to split input image into qudaratic segments

% Divide image into smaller segments
segmentSizeR = floor(size(imgInput,1) * (10/100)); % R, rows
segmentSizeC = floor(size(imgInput,1) * (10/100)); % C, columns
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

end

