function resampled = resampleParticles(p, w)
    % Zieht mit zurücklegen N Elemente gewichtet mit ihrem Faktors w

    N = size(p, 1);
    
    maximumW = max(w);
    
    % Startindex zuf?llig ziehen
    index = randi(N,1);
    
    % Laufvariable im Verteilungskreis
    beta = 0;
    
    resampled = zeros(size(p));
    for i=1:N
        beta = beta + rand() * 2*maximumW; % (gleichverteilt)
        while beta > w(index)
            beta = beta - w(index);
            index = mod(index+1, N)+1;
        end
        resampled(i,:) = p(index,:);
    end
end