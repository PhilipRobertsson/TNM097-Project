function [imgCell] = splitIntoSegments(imgInput)
%Used to split input image into qudaratic segments

% Divide image into smaller segments

if size(imgInput,1) >= size(imgInput,2)
    segmentSize = floor(size(imgInput,1) * (5/300));
else
    segmentSize = floor(size(imgInput,2) * (5/300));
end

segmentSizeR = segmentSize; % R, rows
segmentSizeC = segmentSize; % C, columns
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

