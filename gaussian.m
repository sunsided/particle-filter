function p = gaussian(mu, variance, x)
    % Berechnet die Wahrscheinlichkeit der Messung x bei einem
    % Mittelwert von mu und einer Varianz variance.
    % Der Mittwelwert entspricht der gemessenen Distanz und
    % die Varianz der Varianz des Messrauschens.
    
    %p = 1/sqrt(2*pi*variance^2) * exp(-0.5 * (x-mu)^2 / variance^2);
    p = exp(- ((mu - x)^2) / variance / 2.0) / sqrt(2.0 * pi * variance);
end