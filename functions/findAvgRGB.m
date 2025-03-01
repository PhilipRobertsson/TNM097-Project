function [avgRGB] = findAvgRGB(cellInput)

% Convert the cell to a normal image matrix
imgSquare = cell2mat(cellInput);

% Variables to store rgb values
totR = 0;
totG = 0;
totB = 0;
totV = 0;

% Sum r, g, and b values of all pixels
for k = 1 : size(imgSquare,2)
    for i = 1 : size(imgSquare,1)
        if(size(imgSquare,3) > 1) %RGB image
            totR = totR + double(imgSquare(i,k,1));
            totG = totG + double(imgSquare(i,k,2));
            totB = totB + double(imgSquare(i,k,3));
        else    % Grayscale image
            totV = totV + double(imgSquare(i,k));
       end
    end
end

% Total size of image
imgSize = size(imgSquare,1) * size(imgSquare,2);

% If grayscale set RGB to same values
if(size(imgSquare,3) == 1)
    totR = totV;
    totG = totV;
    totB = totV;   
end

% Find avreage
avgR = floor(totR/(imgSize));
avgG = floor(totG/(imgSize));
avgB = floor(totB/(imgSize));


avgRGB = [avgR, avgG, avgB];