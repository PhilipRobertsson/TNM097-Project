function colourRamp = getColourRamp(vec, height)
%GETCOLOURRAMP generates a colour ramp of specified height from the input
%colour vector

rampHeight = ones(height,size(vec,2));

colourRamp = zeros(height,size(vec,2),3);

colourRamp(:,:,1) = rampHeight .* vec(1,:);
colourRamp(:,:,2) = rampHeight .*vec(2,:);
colourRamp(:, :,3) =rampHeight .* vec(3,:);
end

