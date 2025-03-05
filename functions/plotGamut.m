function plotGamut(DatabaseXYZs,plotColour)
%PLOTGAMUT Summary of this function goes here

% Used to draw "horse shoe" part of gamut
load xyz;

x=xyz(:,1)./(xyz(:,1)+xyz(:,2)+xyz(:,3));
y=xyz(:,2)./(xyz(:,1)+xyz(:,2)+xyz(:,3));

plot(x,y)
hold on

x=DatabaseXYZs(1,:)./sum(DatabaseXYZs);
y=DatabaseXYZs(2,:)./sum(DatabaseXYZs);

plot([x,x(1)],[y,y(1)],plotColour)

end

