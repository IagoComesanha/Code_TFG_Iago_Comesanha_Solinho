function xi = discr2xi(variab, nv, xh, zh, uh, ph)
% Función para converter o conxunto de variables orixinais 
% avaliadas nos nodos temporais nun vector de variables \xi. 
% 
% DATOS DE ENTRADA:
% variab: estrutura co número de variables do problema.
% nv: número de nodos da malla considerada.
% xh: matriz (variab.ndif x nv) onde o elemento (i,j) representa 
% a variable diferencial i-ésima no nodo j-ésimo.
% zh: matriz (variab.nalx x nv) onde o elemento (i,j) representa 
% a variable alxébrica i-ésima no nodo j-ésimo.
% uh: matriz (variab.ncon x nv) onde o elemento (i,j) representa 
% a variable de control i-ésima no nodo j-ésimo.
% ph: vector de parámetros (variab.npar x 1).
%
% DATOS DE SAÍDA:
% xi: vector de variables do problema discretizado, ordeadas por 
% nodos e por tipo de variable, cos parámetros ao comezo. É dicir:  
% xi = (p x^0 z^0 u^0 x^1 z^1 u^1 ...).

% Número de variables continuas do problema.
nvar = variab.ndif + variab.nalx + variab.ncon;

% Creación da matriz intermedia conxunta.
prexi = [xh; zh; uh];

% Creación do vector para almacenar todas as variables.
lonxi = nv*nvar + variab.npar; 
xi = zeros(lonxi, 1); 

% Asignación dos parámetros.
i0 = variab.npar;
xi(1:i0) = ph;

for i = 1:nv
    % Índices inicial e final.
    in = i0 + (i-1)*nvar + 1; 
    fin = i0 + i*nvar;
    % Asignación columna da matriz de variables continuas.
    xi(in:fin) = prexi(:,i);
end
end