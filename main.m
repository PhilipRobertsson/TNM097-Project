% Add folders and subfolders to path
addpath("functions\") % Functions
addpath("images\processed\") % Processed Images

% Image loading
filterspec = {'*.jpg;*.tif;*.png;*.gif','All Image Files'};
[file,path] = uigetfile(filterspec);
imgInput = imread(fullfile(path,file));

imshow(imgInput);

imgCell = splitIntoSegments(imgInput);

avgRGBTest = findAvgRGB(imgCell(1,1))

