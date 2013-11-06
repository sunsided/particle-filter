clear; home; close all;

% Fehlervarianz
translationNoiseVariance = 0.05;
rotationNoiseVariance = 0.05;
measurementNoiseVariance = 5;

% Landmarken für die Messung
landmarks = [20, 20; 
            80, 20; 
            20, 80; 
            80, 80];

% Weltgröße
worldSize = 100; % quadratisch

% Anzahl der Partikel
N = 100;

% Initialer State
robot = [rand(1)*worldSize, rand(1)*worldSize, rand(1)*2*pi];

% Initiale Partikel erzeugen
p = createRandomStates(worldSize, N);

% Initialer Plot
fig = figure;
plot_p = plot(p(:,1), p(:,2), '.'); hold on;
plot_s = plot(robot(1), robot(2), 'r+');
plot(landmarks(:,1), landmarks(:,2), 'mo');
axis([0 worldSize 0 worldSize]);
axis square;
 
for i=1:100
    % plotten
    figure(fig);
    set(plot_p, 'XData', p(:,1));
    set(plot_p, 'YData', p(:,2));
    set(plot_s, 'XData', [get(plot_s, 'XData') robot(1)]);
    set(plot_s, 'YData', [get(plot_s, 'YData') robot(2)]);
    
    % Bewegung definieren
    heading = 0.1;
    distance = 0.5 + abs(sqrt(0.5)*randn());
    
    % System bewegen
    robot = move(robot, heading, distance, translationNoiseVariance, rotationNoiseVariance, worldSize);
    Z = senseDistanceFromLandmarks(robot, landmarks, measurementNoiseVariance);
    
    % Partikel bewegen
    p = move(p, heading, distance, translationNoiseVariance, rotationNoiseVariance, worldSize);
    
    % Messungen erzeugen
    w = measurementProbabilities(p, Z, landmarks, measurementNoiseVariance);
    
    % Messungen resamplen (ziehen mit Zurücklegen mit Wahrscheinlichkeit w)
    p = resampleParticles(p, w);
end