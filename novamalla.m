function [thi, I] = novamalla(th, erroestimado, r, q, ...
    estratexia, tol)
% Cálculo dos novos puntos da malla.
% 
% DATOS DE ENTRADA:
% th: malla actual.
% erroestimado: vector de \eps_k, que son os erros estimados na 
% solución actual e que se pretenden diminuir.
% r: vector de r_k's coas reducións estimadas da orde en cada 
% intervalo.
% q: orde do método empregado para discretizar.
% estratexia: 0 calcula os puntos de xeito intuitivo mentres que 1 
% calcula resolvendo un problema de programación enteira.
% tol: tolerancia do erro.
%
% DATOS DE SAÍDA:
% thi: nova malla.
% I: puntos engadidos en cada intervalo.

% Número de elementos da malla actual.
nel = length(th)-1;

if estratexia == 1
    % ESTRATEXIA PROBLEMA DE PROGRAMACIÓN ENTEIRA.
    % Definición da función obxectivo.
    funk = @(x) erroestimado(1)*((1/(x(1)+1))^(q-r(1)+1));
    for k = 2:nel
       funk = @(x) [funk(x); ...
                    erroestimado(k)*((1/(x(k)+1))^(q-r(k)+1))];
    end
    fun = @(x) sum(funk(x));
    % fun = @(x) max(funk(x)); Con esta opción chega un momento no 
    % que non engade puntos mais todavía hai erro.

    % Chamada para ga. Función de Matlab que resolve o problema.
    % M = 6, M_1 = 5.
    I = probint(fun, nel, 6, 5);

elseif estratexia == 0
    % Cálculo con algoritmo heurístico.
    I = intuitivo(erroestimado, nel, q, r, tol);
end

% Construción dos novos puntos da malla a partir do número de 
% puntos que se engaden.
thi = engadir(I, th);
end