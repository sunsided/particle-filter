function p = move(p, heading, distance, translationNoiseVariance, rotationNoiseVariance, worldSize)
    % Bewegt einen Punkt (in Form eines States) oder eine Liste von
    % Punkten (in Form von States)
    for mi=1:size(p,1)

        h = mod(heading + p(mi, 3) + sqrt(rotationNoiseVariance)*randn(), 2*pi);
        
        d = distance + sqrt(translationNoiseVariance)*randn();
        x = mod(p(mi, 1) + cos(h)*d, worldSize);
        y = mod(p(mi, 2) + sin(h)*d, worldSize);

        p(mi,:) = [x,y,h];
    end
end