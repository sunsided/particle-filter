function p = createRandomStates(worldSize, N)
    % Erzeugt N gleichverteilte Schätzungen für Zustandsvektor
    % [x,y,Richtung]
    x = rand(N, 1) * worldSize;
    y = rand(N, 1) * worldSize;
    heading = rand(N, 1) * 2*pi;
    p = [x, y, heading];
end