function I = intuitivo(erroestimado, nel, q ,r, tol)
% Función para decidir o nº de puntos que se van engadir no 
% proceso de  refinamento da malla de xeito intuitivo: vaise 
% engadindo ao intervalo que maior erro ten.
%
% DATOS DE ENTRADA:
% erroestimado: vector coas estimacións do erro por intervalos
% da malla.
% nel: nº de elementos/intervalos da malla.
% q: orde do método.
% r: redución da orde, vector por intervalos.
% tol: tolerancia do erro.
%
% DATOS DE SAÍDA:
% I: vector co nº de puntos que se engaden a cada intervalo.

% Inicialización vector de número de puntos.
I = zeros(nel,1);

% Erro futuro.
erroestimadonovo = erroestimado;

% Bucle: como moito 5 puntos en total.
for k=1:5
    % Erro máximo e índice correspondente.
    [erroa, ind] = max(erroestimadonovo);
    if I(ind) == 5 % Xa se engadiron 5 puntos a un intervalo.
        return
    elseif erroa <= tol % O erro máximo é pequeno.
        return
    else % Engadirase un punto ao elemento correspondente.
        I(ind) = I(ind) + 1;
    end
    % Estimación do erro futuro.
    erroestimadonovo(ind) = erroestimado(ind)*((1/(I(ind) ...
                                            +1))^(q-r(ind)+1));
end
end