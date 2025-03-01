function [imgCell] = splitIntoSegments(imgInput)
%Used to split input image into qudaratic segments

% Divide image into smaller segments
segmentSizeR = floor(size(imgInput,1) * (8/100)); % R, rows
segmentSizeC = floor(size(imgInput,1) * (8/100)); % C, columns
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

end

