function [xh, zh, uh, ph] = xi2discr(variab, nv, xi)
% Función que pasa do vector xi ás variables distinguidas xh, zh,
% uh, ph.
%
% DATOS DE ENTRADA:
% variab: estrutura co nº de variables do problema.
% nv: nº de nodos da malla.
% xi: vector de variables.
%
% DATOS DE SAÍDA:
% xh: matriz (variab.ndif x nv) onde o elemento (i,j) representa 
% a variable diferencial i-ésima no nodo j-ésimo.
% zh: matriz (variab.nalx x nv) onde o elemento (i,j) representa 
% a variable alxébrica i-ésima no nodo j-ésimo.
% uh: matriz (variab.ncon x nv) onde o elemento (i,j) representa 
% a variable de control i-ésima no nodo j-ésimo.
% ph: vector (variab.npar x 1) de parámetros.

% Variables continuas do problema.
nvar = variab.ndif + variab.nalx + variab.ncon;
% Número de parámetros.
i0 = variab.npar;

% Matriz intermedia, coas variables por filas, nodos por columnas.
prexi = zeros(nvar,nv);
for i = 1:nv
    in = i0 + (i-1)*nvar + 1; 
    fin = i0 + i*nvar;
    prexi(:,i) = xi(in:fin);
end

% Variables nos nodos
in = 1; fin = variab.ndif;
xh = prexi(in:fin, :);

in = in + variab.ndif; fin = fin + variab.nalx;
zh = prexi(in:fin, :);

in = in + variab.nalx; fin = fin + variab.ncon;
uh = prexi(in:fin, :);

ph = xi(1:i0);
end