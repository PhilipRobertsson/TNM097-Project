function map = getDominantColours(imInput, numColours)
% Returns the number of dominant RGB colours in input image according to
% the amount of numCoulours

[~, map] = rgb2ind(imInput, numColours);

end

