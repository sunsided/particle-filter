function w = senseDistanceAndCalculateLikelihood(p, Z, landmarks, measurementNoiseVariance)
    % Ermittelt die Distanz zu den Landmarken und berechnet die
    % Wahrscheinlichkeit der Korrektheit des Zustandsvektors

    N = size(p,1);
    w = zeros(N,1);
    for i=1:N      
        w(i) = measurementProbability(p(i,:), Z, landmarks, measurementNoiseVariance);
    end
end