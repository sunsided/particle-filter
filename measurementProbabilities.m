function w = measurementProbabilities(p, Z, landmarks, measurementNoiseVariance)
    % Berechnet die Wahrscheinlichkeit der Korrektheit der Zustandsvektoren

    N = size(p,1);
    w = zeros(N,1);
    for i=1:N      
        w(i) = measurementProbability(p(i,:), Z, landmarks, measurementNoiseVariance);
    end
end