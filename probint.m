function I = probint(fun, nel, M, M1)
% Función para resolver o problema de programación enteira que 
% pretender atopar o nº de puntos que se engade a cada subintervalo
% co obxectivo de mellorar o erro estimado.
%
% DATOS DE ENTRADA:
% fun: función obxectivo (sum_k \eps_k).
% nel: nº de elementos da malla, nv - 1.
% M-1: nº máximo de puntos a engadir en total.
% M1: nº máximo de puntos a engadir nun intervalo.
%
% DATOS DE SAÍDA:
% I: vector co nº de puntos a engadir en cada intervalo.

% Restricións do problema.
A = ones(1, nel);
b = M-1;
Aeq = []; beq = []; 
% Límites.
lb = zeros(1, nel); 
ub = M1*ones(1, nel);

nonlcon=[]; 

% Número de variables enteiras.
intcon = 1:nel;

options = optimoptions('ga', 'Display', 'off', ...
                                    'FunctionTolerance', 1.e-30);

% Resolución.
I = ga(fun, nel, A, b, Aeq, beq, lb, ub, nonlcon, intcon, options);
end