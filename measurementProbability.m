function prob = measurementProbability(p, measurement, landmarks, noiseVariance)
    % Berechnet die Wahrscheinlichkeitsgewichtungen für die Messungen.
    % Es muss genauso viele Messungen wie Landmarken geben.

    x = p(1);
    y = p(2);

    prob = 1;
    for li=1:size(landmarks,1)
        error = (x - landmarks(li,1))^2 + ...
                (y - landmarks(li,2))^2;
        distance = sqrt(error);
        %prob = prob * gaussian(distance, noiseVariance, measurement(li));
        prob = prob * normpdf(measurement(li), distance, sqrt(noiseVariance));
    end
end