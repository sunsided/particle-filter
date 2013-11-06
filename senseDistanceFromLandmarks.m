function d = senseDistanceFromLandmarks(state, landmarks, measurementNoiseVariance)
    % Berechnet die Entfernung eines Punktes (im State (x,y,heading)) 
    % von den gegebenen Landmarken, 
    % z.B. distanceFromLandmarks(landmarks, [0, 0, pi])

    point = state(1:2);
    v = ones(length(landmarks), 1) * point;

    % Absolute Distanzen berechnen
    d2 = (landmarks - v);
    d = sqrt(d2(:,1).^2 + d2(:,2).^2) + sqrt(measurementNoiseVariance)*randn();
end