function index = findSmallestDistE(segmentLab,databaseLabs)
% Finds the smallest Delta E distance between a segment avrage colour and the databse colours

index = 1;
smallestDist = inf;

for k = 1:size(databaseLabs,1)
    currentDBLab = databaseLabs{k,1};
    dist = sqrt( (currentDBLab(1) - segmentLab(1))^2 + (currentDBLab(2) - segmentLab(2))^2 + (currentDBLab(3) - segmentLab(3))^2 );
    if dist < smallestDist
        index = k;
        smallestDist = dist;
    end
end

end

