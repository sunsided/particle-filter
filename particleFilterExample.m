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
estimated = mean(p);

% Initialer Plot
fig = figure();
subplot(1,2,1);
plot_s = plot(robot(1), robot(2), 'r+'); hold on;
plot_p = plot(p(:,1), p(:,2), 'b+');
plot(landmarks(:,1), landmarks(:,2), 'mo');
legend('Echte Position', 'Partikel', 'Landmarken');
axis([0 worldSize 0 worldSize]);
xlabel('x'); ylabel('y');
axis square;
 
subplot(1,2,2);
plot_s2 = plot(robot(1), robot(2), 'r+'); hold on;
plot_e = plot(estimated(1), estimated(2), 'b+');
plot(landmarks(:,1), landmarks(:,2), 'mo');
legend('Echte Position', 'Approximierte Position', 'Landmarken');
axis([0 worldSize 0 worldSize]);
xlabel('x'); ylabel('y');
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

    % Messungen erzeugen
    Z = senseDistanceFromLandmarks(robot, landmarks, measurementNoiseVariance);
    
    % Partikel bewegen: Partikel vollziehen Bewegung des Systems nach.
    % Diese Bewegung wird unter Annahme eines AWGN-Fehlers modelliert.
    p = move(p, heading, distance, translationNoiseVariance, rotationNoiseVariance, worldSize);
    
    % Partikel bewerten: Wie wahrscheinlich ist die Korrektheit jedes Partikel bei gegebener Messung
    w = measurementProbabilities(p, Z, landmarks, measurementNoiseVariance);
    
    % Messungen resamplen (ziehen mit Zurücklegen mit Wahrscheinlichkeit w):
    % Partikel mit geringerer Wahrscheinlichkeit werden seltener gezogen, wodurch sie gegenüber
    % Partikeln mit hoher Wahrscheinlichkeit auf Dauer aussterben.
    p = resampleParticles(p, w);
    
    % Sch�tzung beziehen
    estimated = mean(p);
    
    % plot 2
    figure(fig);
    set(plot_s2, 'XData', [get(plot_s2, 'XData') robot(1)]);
    set(plot_s2, 'YData', [get(plot_s2, 'YData') robot(2)]);
    set(plot_e, 'XData', [get(plot_e, 'XData') estimated(1)]);
    set(plot_e, 'YData', [get(plot_e, 'YData') estimated(2)]);
end