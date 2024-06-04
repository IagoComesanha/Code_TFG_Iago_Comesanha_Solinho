function [xh, zh, uh] = actualizacion(th, ppxh, ppzh, ppuh, variab)
% Actualización das variables nos nodos da malla mediante a 
% avaliación dos splines nos novos puntos.
%
% DATOS DE ENTRADA:
% th: vector cos puntos da malla actual.
% ppxh: celda de variab.ndif filas e 1 columna que na fila 
% i-ésima contén o spline que interpola os datos da variable 
% diferencial i-ésima.
% ppzh: celda de variab.nalx filas e 1 columna que na fila 
% i-ésima contén o spline que interpola os datos da variable 
% alxébrica i-ésima.
% ppuh: celda de variab.ncon filas e 1 columna que na fila 
% i-ésima contén o spline que interpola os datos da variable de 
% control i-ésima.
% variab: estrutura co nº de variables do problema orixinal.
%
% DATOS DE SAÍDA:
% xh: matriz (variab.ndif x nv) onde o elemento (i,j) representa
% a variable diferencial i-ésima no nodo j-ésimo.
% zh: matriz (variab.nalx x nv) onde o elemento (i,j) representa 
% a variable alxébrica i-ésima no nodo j-ésimo.
% uh: matriz (variab.ncon x nv) onde o elemento (i,j) representa
% a variable de control i-ésima no nodo j-ésimo.

% Número de nodos da malla.
nv = length(th);

% Variables de estado diferenciais.
xh = zeros(variab.ndif, nv);
for i = 1:variab.ndif
    xh(i,:) = ppval(ppxh{i,1},th);
end

% Variables de estado alxébricas.
zh = zeros(variab.nalx, nv);
for i = 1:variab.nalx
    zh(i,:) = ppval(ppzh{i,1},th);
end

% Variables de control.
uh = zeros(variab.ncon, nv);
for i = 1:variab.ncon
    uh(i,:) = ppval(ppuh{i,1},th);
end
end