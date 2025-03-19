function [databaseOpt] = imgBasedOpt(cMap, dBase, matchesPerSample)
% Optimizes the database according to the colour map and amount of matches
% per sample

% Initalize output database, an index and a list of distances
databaseOpt = {};
dbIndex = 1;
distances = {};

c = size(cMap,1); % Number of dominant colours
d = size(dBase, 1); % Number of database entries


for k = 1:c
    % Current sample
    cMapC = cMap(k,:);
    
    % Calculate distance between sample colour and all database colours
    for l = 1:d
        dBaseC = dBase{l,1};
        dist = sqrt((dBaseC(1) - cMapC(1))^2 + (dBaseC(2) - cMapC(2))^2 + (dBaseC(3) - cMapC(3))^2);

        distances{l,1} = dist;
        distances(l,2) = dBase(l,1);
        distances(l,3) = dBase(l,2);
    end
    
    distances = sortrows(distances,1);
    
    for m = 1:matchesPerSample
        databaseOpt(dbIndex,1) = distances(m,2);
        databaseOpt(dbIndex,2) = distances(m,3);
        dbIndex = dbIndex + 1;
    end

    distances = {};
end

% Convert from cell to table, remove duplicate values, convert back to cell
databaseOpt = table2cell(unique(cell2table(databaseOpt)));

end

