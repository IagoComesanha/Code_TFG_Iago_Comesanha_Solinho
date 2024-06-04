function [th, nv, I, xh, zh, uh, discret, ref, thetaerro,thprev] = refinamento1( ...
    i, ref, discret, etaerro, thetaerro, I, errointegraNdo, th, ...
    nv, erroestimado, q, estratexia, variab, ppxh, ppzh, ppuh, ...
    thprev, tol)
% Función para refinar a malla coa que se está a traballar e 
% actualizar as variables no caso de que se inclúa o paso 3 do 
% algoritmo de refinamento (é dicir, decídese se mudar a 
% discretización).
%
% DATOS DE ENTRADA:
% i: iteración do algoritmo.
% ref: nº de refinamentos realizados da malla até o momento.
% discret: tipo de discretización empregada para os esquemas
% Runge-Kutta, trapecios [1], Hermite-Simpson [2].
% etaerro: erro integrado estimado na malla actual.
% thetaerro: erro integrado estimado na malla previa.
% I: vector co nº de puntos engadidos á malla antiga.
% errointegraNdo: celda con f{end,1} (ou variab.ndif) filas e 
% 1 columna que contén a función de erro por compoñentes.
% th: malla actual.
% erroestimado: vector de \eps_k, que son os erros estimados na
% solución actual e que se pretenden diminuir.
% q: orde do método empregado para discretizar.
% estratexia: 0 calcula os puntos de xeito intuitivo mentres que
% 1 calcula resolvendo un problema de programación enteira.
% variab: estrutura co nº de variables do problema orixinal.
% ppxh: celda de variab.ndif filas e 1 columna que na fila 
% i-ésima contén o spline que interpola os datos da variable 
% diferencial i-ésima.
% ppzh: celda de variab.nalx filas e 1 columna que na fila 
% i-ésima contén o spline que interpola os datos da variable 
% alxébrica i-ésima.
% ppuh: celda de variab.ncon filas e 1 columna que na fila
% i-ésima contén o spline que interpola os datos da variable de 
% control i-ésima.
% thprev: nodos da malla previa.
% tol: tolerancia do erro.
%
% DATOS DE SAÍDA: (actualización)
% th: malla temporal, con nv elementos.
% nv: nº de puntos da malla.
% I: vector co nº de puntos engadidos a cada intervalo da 
% malla previa.
% xh: matriz (variab.ndif x nv) onde o elemento (i,j) representa
% a variable diferencial i-ésima no nodo j-ésimo.
% zh: matriz (variab.nalx x nv) onde o elemento (i,j) representa 
% a variable alxébrica i-ésima no nodo j-ésimo.
% uh: matriz (variab.ncon x nv) onde o elemento (i,j) representa 
% a variable de control i-ésima no nodo j-ésimo.
% discret: método de discretización que se vai empregar a partir
% de agora na construción dos esquemas Runge-Kutta.
% ref: nº de refinamentos realizados da malla até o momento.
% thetaerro: erro integrado estimado na malla previa.
% thprev: nodos da malla previa.

% Elección da nova orde
if discret == 1
    discretnew = cambiodeorde(i, erroestimado, discret);
elseif discret == 2
    discretnew = 2;
end
% Actualización da orde: orde correcta teórica coa que hai que 
% traballar.
if discretnew == 2
    q = 4;
end

% Se non se decidiu cambiar de método de discretización, 
% continúase co algoritmo de refinamento.
if discretnew == discret
    % ESTIMACIÓN DA REDUCIÓN DA ORDE
    if ref >= 1
        % Xa se conta con información dunha primeira malla 
        % (hai dous erros).
        r = reducion(etaerro, thetaerro, q, I, ...
                            errointegraNdo, thprev);
    else
        % r para o primeiro refinamento.
        r = zeros(nv-1, 1);
    end

    % CONSTRUCIÓN DA NOVA MALLA
    [thi, I] = novamalla(th, erroestimado, r, q, estratexia, tol);

    % ACTUALIZACIÓN VARIABLES
    % Almacenaxe malla previa.
    thprev = th;
    % Nova malla.
    th = thi; nv = length(thi);
    % Aumentou o nº de refinamentos realizados.
    ref = ref + 1;
    % Almacenaxe erro da malla previa.
    thetaerro = etaerro;
end

% Actualización das variables mediante avaliación dos splines.
[xh, zh, uh] = actualizacion(th, ppxh, ppzh, ppuh, variab);
% Actualízase a discretización.
discret = discretnew;
end