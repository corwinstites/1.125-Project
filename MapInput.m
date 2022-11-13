figure 
axesm bries
text(2.8,-1.8,'Briesemeister projection','HorizontalAlignment','right')
framem('FLineWidth',1)
load topo60c
geoshow(topo60c,topo60cR,'DisplayType','texturemap')
demcmap(topo60c)
brighten(0.7)
[lat, lon] = inputm;
close all
figure 
axesm bries
text(2.8,-1.8,'Briesemeister projection','HorizontalAlignment','right')
framem('FLineWidth',1)
load topo60c
geoshow(topo60c,topo60cR,'DisplayType','texturemap')
demcmap(topo60c)
brighten(0.7)
geoshow(lat, lon,...
        'DisplayType', 'point',...
        'Marker', 'o',...
        'MarkerEdgeColor', 'r',...
        'MarkerFaceColor', 'r',...
        'MarkerSize', 3)
text(-2.8,-1.8,'Selected Points')