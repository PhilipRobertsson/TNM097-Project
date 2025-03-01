function [avgRGB] = findAvgRGB(cellInput)

% Convert the cell to a normal image matrix
imgSquare = cell2mat(cellInput);

% Variables to store rgb values
totR = 0;
totG = 0;
totB = 0;

% Sum r, g, and b values of all pixels
for k = 1 : length(imgSquare)
    for i = 1 : length(imgSquare)
        totR = totR + double(imgSquare(i,k,1));
        totG = totG + double(imgSquare(i,k,2));
        totB = totB + double(imgSquare(i,k,3));
    end
end

% Find avreage
avgR = floor(totR/(length(imgSquare)*length(imgSquare)));
avgG = floor(totG/(length(imgSquare)*length(imgSquare)));
avgB = floor(totB/(length(imgSquare)*length(imgSquare)));


avgRGB = [avgR, avgG, avgB];