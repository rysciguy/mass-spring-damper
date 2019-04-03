clear all; close all;

master = Structure();

pix1 = Voxel('stiffness', 6);
master.incorporate(pix1);

pix2 = Voxel('origin',[1,0,0], 'stiffness', 2);
pix2.color = [1, 0, 0];
master.incorporate(pix2);

master.refresh();
master.plotStructure();

% for i = 1:length(master.points)
%     point = master.points(i);
%     for j = 1:length(point.links)
%         point.links(j).refresh();
%     end
% end
% 
% master.plotStructure();

pix2.getPoint([0.5, 0.5, 0]) == master.getPoint([0.5, 0.5, 0])
% pix2.getPoint([0.5, 0.5, 0]), master.getPoint([0.5, 0.5, 0]))

% p00 = master.getPoint([-0.5, -0.5, 0])
% p11 = master.getPoint([0.5, 0.5, 0])
% p21 = master.getPoint([1.5, 0.5, 0])

% Fix left edge
master.getPoint([-0.5, -0.5, 0]).DOF = zeros(1,3);
master.getPoint([-0.5, 0.5, 0]).DOF = zeros(1,3);