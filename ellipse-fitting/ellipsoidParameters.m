clc; clear all; home;

%% Prepare the ellipsoid
disp('Creating ellipsoid ...');

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

%% Prepare the particles
disp('Initialising particles ...');

% Ellipsoid equation:
% Ax^2 + By^2 + Cz^2 + Dxy + Exz + Fyz + L = 0;

% Number of particles
N = 100;

% Define initial search space
As = 50;
Bs = 50;
Cs = 50;
Ds = 50;
Es = 50;
Fs = 50;
Ls = 50;

scales = [As; Bs; Cs; Ds; Es; Fs; Ls];

% Create particles
particles = zeros(N, 7);
for n=1:N   
    parameters = 2*rand(7,1).*scales - scales;
    particles(n, :) = parameters;
end

% YIKES! That does not work. I was probably thinking of a genetic approach.