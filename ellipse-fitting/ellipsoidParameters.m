clc; clear all; home;

% Create a random position in [-10; 10]
center = round(20*rand(3, 1)-10);

% Create random semi-axis lengths in [1; 5]
radii = round(4*rand(3, 1)+1);

% Create random rotation angles in [-45 45]
rotation = round(90*rand(3, 1)-45) * pi/180;

% Set measurement variance
variance = [0.001 0.001 0.001];

% Create the ellipsoid
[x, y, z] = createEllipsoid(center, radii, rotation, variance, 1);