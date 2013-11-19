function [x, y, z] = createEllipsoid(center, radii, rotation, variance, flat)

    if ~exist('flat', 'var')
        flat = 1;
    end

    if ~exist('center', 'var')
        center = [0 0 0];
    end
    
    if ~exist('radii', 'var')
        radii = [3 2 1];
    end
    
    if ~exist('rotation', 'var')
        rotation = [0 0 0];
    end
    
    if ~exist('variance', 'var')
        variance = [0 0 0];
    end
    
    % add affine transformations to path
    path(fullfile(fileparts(which(mfilename)), 'affine'), path)

    % perform affine transformations
    Rx = affine_rotation_x(rotation(1));
    Ry = affine_rotation_y(rotation(2));
    Rz = affine_rotation_z(rotation(3));
    Rzyx = Rx*Ry*Rz;

    % define ellipsoid parameters
    C = center;
    R = radii;

    % generate basic ellipsoid
    [x, y, z] = ellipsoid(C(1), C(2), C(3), R(1), R(2), R(3), 20);

    % rotate the ellipsoid
    for column=1:size(x, 1)
        for row=1:size(x, 2)
            % extract affine vector
            v = [x(column,row) y(column,row) z(column,row) 1];

            % attach affine transformation
            v = Rzyx*v';
            v = v(1:3);

            % add noise
            n = sqrt(variance).*randn(1,3);
            v = v+n';
            
            % re-insert transformed vector
            x(column,row) = v(1);
            y(column,row) = v(2);
            z(column,row) = v(3);
        end
    end

    % flatten array if requested
    if flat
        rows = size(x, 1);
        columns = size(x, 2);
        count = rows*columns;
        xout = zeros(count, 1);
        yout = zeros(count, 1);
        zout = zeros(count, 1);
        
        for column=1:size(x, 1)
            for row=1:size(x, 2)
                % extract affine vector
                xout(row + (column-1)*columns) = x(column, row);
                yout(row + (column-1)*columns) = y(column, row);
                zout(row + (column-1)*columns) = z(column, row);
            end
        end
        
        
        x = xout;
        y = yout;
        z = zout;
        
        if nargout == 0
            figure('Name', 'Ellipsoid');
            plot3(x, y, z, 'Color', [0.4 0.4 0.7]);
            axis equal;
            xlabel('x'); ylabel('y'); zlabel('z');
        end
    else
        if nargout == 0
            figure('Name', 'Ellipsoid');
            surfl(x, y, z);
            colormap gray;
            axis equal;
            xlabel('x'); ylabel('y'); zlabel('z');
        end
    end
end