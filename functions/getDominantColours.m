function map = getDominantColours(imInput, numColours)
%getDominantColour Summary of this function goes here

[~, map] = rgb2ind(imInput, numColours);

%r=size(map,1);

%colors=[];
%co=0;
%ro=0;
%for n=1:r
%    if (co==10) 
%        co=0; 
%        ro=ro+1;
%    end
%    colors(ro*75+1:ro*75+75,co*75+1:co*75+75,1)=map(n,1);
%    colors(ro*75+1:ro*75+75,co*75+1:co*75+75,2)=map(n,2);
%    colors(ro*75+1:ro*75+75,co*75+1:co*75+75,3)=map(n,3);
%    co=co+1;
%end

%figure;
%imshow(colors);

end

