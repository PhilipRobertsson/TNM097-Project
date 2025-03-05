function [avgRGB,avgLab] = findAvgRGB(cellInput)

% Convert the cell to a normal image matrix
imgSquare = cell2mat(cellInput);
imgSquareLab = rgb2lab(im2double(imgSquare));

% Variables to store rgb values
if(size(imgSquare, 3) == 3)
    redChannel = imgSquare(:, :, 1);
    greenChannel = imgSquare(:, :, 2);
    blueChannel = imgSquare(:, :, 3);
else
    redChannel = imgSquare;
    greenChannel = imgSquare;
    blueChannel = imgSquare;
end

LChannel = imgSquareLab(:,:,1);
aChannel = imgSquareLab(:,:,2);
bChannel = imgSquareLab(:,:,3);

% Sum r, g, and b values of all pixels
%for k = 1 : size(imgSquare,2)
    %for i = 1 : size(imgSquare,1)
        %if(size(imgSquare,3) > 1) %RGB image
         %   totR = totR + double(imgSquare(i,k,1));
         %   totG = totG + double(imgSquare(i,k,2));
         %   totB = totB + double(imgSquare(i,k,3));

         %   totL = totL + imgSquareLab(i,k,1);
         %   tota = tota + imgSquareLab(i,k,2);
         %   totb = totb + imgSquareLab(i,k,3);
        %else    % Grayscale image
           % totV = totV + double(imgSquare(i,k));
       %end
    %end
%end

avgR = floor(mean(redChannel(:)));
avgG = floor(mean(greenChannel(:)));
avgB = floor(mean(blueChannel(:)));

avgL = floor(mean(LChannel(:)));
avga = floor(mean(aChannel(:)));
avgb = floor(mean(bChannel(:)));

% Total size of image
%imgSize = size(imgSquare,1) * size(imgSquare,2);

% If grayscale set RGB to same values
%if(size(imgSquare,3) == 1)
%    totR = totV;
%    totG = totV;
%    totB = totV; 

%    totL = totV;
%    tota = 0;
%    totb = 0;
%end

% Find avreage
%avgR = floor(totR/(imgSize));
%avgG = floor(totG/(imgSize));
%avgB = floor(totB/(imgSize));

%avgL = floor(totL/(imgSize));
%avga = floor(tota/(imgSize));
%avgb = floor(totb/(imgSize));


avgRGB = [avgR, avgG, avgB];
avgLab = [avgL, avga, avgb];