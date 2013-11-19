% add affine transformations to path
path(fullfile(fileparts(which(mfilename)), 'affine'), path)

% perform affine transformations
Rx = affine_rotation_x(10 *pi/180);
Ry = affine_rotation_y(20 *pi/180);
Rz = affine_rotation_z(30 *pi/180);
Rzyx = Rx*Ry*Rz;

% define ellipsoid parameters
C = [0 0 0]; % center
R = [3 2 1]; % semi-axis lengths

% generate basic ellipsoid
[x, y, z] = ellipsoid(C(1), C(2), C(3), R(1), R(2), R(3), 20);

% rotate the ellipsoid
for row=1:size(x, 1)
   for column=1:size(x, 2)
       % extract affine vector
       v = [x(row,column) y(row,column) z(row,column) 1];
       
       % attach affine transformation
       v = Rzyx*v';
       
       % re-insert transformed vector
       x(row,column) = v(1);
       y(row,column) = v(2);
       z(row,column) = v(3);
   end
end

% plot the ellipsoid
surfl(x, y, z);
colormap copper;
axis equal;
hold on;
xlabel('x');
ylabel('y');
zlabel('z');

% helper plot
for i=1:size(x, 1)
   plot3(x(i,:), y(i,:), z(i,:), '-', 'Color', 'white'); hold on;
end
