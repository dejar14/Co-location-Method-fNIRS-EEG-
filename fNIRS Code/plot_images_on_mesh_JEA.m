%% Function to plot on a gray brain
% Author: Jessica E. Anderson

function plot_images_on_mesh_JEA(mesh, image, color_bar_range, tstatthresh)
f=mesh.faces;
v=mesh.vertices;
figure

axes_order = [2,1,3];

h = trisurf(f, v(:,axes_order(1)), v(:,axes_order(2)), v(:,axes_order(3)), image,'facecolor','interp','edgealpha',0, 'visible','on'); 

set(h,'diffusestrength',.9,'specularstrength',.12,'ambientstrength',.2);
% caxis([-2 0])
caxis(color_bar_range)
myColorMap = jet(256);
% myColorMap(1:15,:) = 0.8;
if nargin < 4
    myColorMap(127:129,:) = 0.8;
else
    myColorMap((.5*256 + round((tstatthresh/color_bar_range(1))*0.5*256)):(0.5*256+round((tstatthresh/color_bar_range(2))*0.5*256)),:) = 0.8;
end
colormap(myColorMap);
colorbar
view(-90,0)
% camlight
camtarget([128.0, 132.0, 130.0])
% camlight
campos([-2238.8, 132.0, 130.0])
% camlight
% camup([-1.0, 0.0, 0.0])
% camlight
axis image
axis off
hold on

l = camlight;
set(l,'Position',[-2000 100 100]);

l2 = camlight;
set(l2,'Position',[50 -100 -100]);

camlight(0,0);

lighting phong;
light
end