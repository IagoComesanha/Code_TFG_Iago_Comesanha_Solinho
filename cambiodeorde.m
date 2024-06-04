function discretnew = cambiodeorde(i, erroestimado, discret)
% Función cambio de orde, decide se incrementar a orde do método de
% discretización.
%
% DATOS DE ENTRADA:
% i: iteración do método.
% erroestimado: vector coas estimacións do erro por intervalos.
% discret: tipo de discretización, [1] trapecios, [2] Hermite.
%
% DATOS DE SAÍDA:
% discretnew: novo tipo de discretización.

% \bar{\eps}: media do erro estimado
barerro = mean(erroestimado);
if ( all(erroestimado <= 2*barerro))
    % Auméntase a orde.
    discretnew = 2;
    return
elseif ( i > 2)
    % Auméntase orde.
    discretnew = 2;
    return
else
discretnew = discret;
end
end