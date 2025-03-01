% Add folders and subfolders to path
addpath("functions\") % Functions
addpath("images\processed\") % Processed Images

% Image loading
filterspec = {'*.jpg;*.tif;*.png;*.gif','All Image Files'};
[file,path] = uigetfile(filterspec);
imgInput = imread(fullfile(path,file));

imshow(imgInput);

% Divide image into smaller segments
segmentInWidth = 10;
[rows, columns, numberOfColorBands] = size(rgbImage)
segmentSize = floor(rows/10); % Height and width


