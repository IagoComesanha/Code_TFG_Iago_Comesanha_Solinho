function A = matrix(xi, variab, nv, ind)
% Función para pasar como argumentos as matrices xh, zh ou uh no 
% canto do vector xi.
%
% DATOS DE ENTRADA:
% xi: vector coas variables, avaliación das funcións orixinais nos 
% nodos da malla.
% variab: estrutura coas dimensións do problema orixinal.
% nv: nº de nodos da malla.
% ind: 1 xh, 2 zh, 3 uh.
%
% DATOS DE SAÍDA:
% A: matriz a partir de xi segundo que variable se requira.

if ind == 1 % Variables x.
    [A, ~, ~, ~] = xi2discr(variab, nv, xi);
elseif ind == 2 % Variables z.
    [~, A, ~, ~] = xi2discr(variab, nv, xi);
elseif ind == 3 % Variables u.
    [~, ~, A, ~] = xi2discr(variab, nv, xi);
end
end