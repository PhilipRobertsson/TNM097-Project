function [databaseRemoves, databaseRemains] = removeSimilar(databaseAvgLab,threshold)
% Removes images with avrage colours within the threshold from the database

databaseRemoves = {};
databaseRemains = {};

% Find similar colours
for k=1:size(databaseAvgLab,1)-1
    Lab1 = databaseAvgLab{k,1};

    for l=(k+1):size(databaseAvgLab,1)
        Lab2 = databaseAvgLab{l,1};
        dist = sqrt((Lab2(1) - Lab1(1))^2 + (Lab2(2) - Lab1(2))^2 + (Lab2(3) - Lab1(3))^2);

        if dist <= threshold
            databaseRemoves(k,1) = databaseAvgLab(k,1);
            databaseRemoves(k,2) = databaseAvgLab(k,2);
        end
    end
end

databaseRemoves =  reshape(databaseRemoves(~cellfun('isempty',databaseRemoves)), [], size(databaseRemoves,2));

% Find which values should be kept
for k=1:size(databaseAvgLab,1)
    text1 = databaseAvgLab{k,2};
    for l=1:size(databaseRemoves,1)
        text2 = databaseRemoves{l,2};
        if strcmp(text1,text2)
            break;
        end

        if l == size(databaseRemoves,1)
            databaseRemains(k,1) = databaseAvgLab(k,1);
            databaseRemains(k,2) = databaseAvgLab(k,2);
        end
    end
end

databaseRemains =  reshape(databaseRemains(~cellfun('isempty',databaseRemains)), [], size(databaseRemains,2));

end

