function errointegrando = erroabs(variab, ppxh, ppzh, ppuh, ph, ...
                                                        f, ppxhder)
% Cálculo da función de erro absoluto eps dentro da integral.
%
% DATOS DE ENTRADA:
% variab: estrutura co nº de variables do problema.
% ppxh: celda de variab.ndif filas e 1 columna que na fila i-ésima 
% contén o spline que interpola os datos da variable diferencial 
% i-ésima.
% ppzh: celda de variab.nalx filas e 1 columna que na fila i-ésima 
% contén ospline que interpola os datos da variable alxébrica 
% i-ésima.
% ppuh: celda de variab.ncon filas e 1 columna que na fila i-ésima 
% contén o spline que interpola os datos da variable de control 
% i-ésima.
% ph: vector de parámetros
% f: celda coas funcións das restricións x' = f.
% ppxhder: celda de variab.ndif filas e 1 columna que na fila 
% i-ésima contén o spline derivada de ppxh{i,1}.
%
% DATOS DE SAÍDA:
% errointegrando: celda con variab.ndif filas e 1 columna que
% contén a función de erro por compoñentes.

% Cálculo argumentos de fchapeu.
xchapeu = @(t) [];
for j = 1:variab.ndif
    xchapeu = @(t) [xchapeu(t) ppval(ppxh{j,1},t)];
end
zchapeu = @(t) [];
for j = 1:variab.nalx
    zchapeu = @(t) [zchapeu(t) ppval(ppzh{j,1},t)];
end
uchapeu = @(t) [];
for j = 1:variab.ncon
    uchapeu = @(t) [uchapeu(t) ppval(ppuh{j,1},t)];
end

% Definición da función de erro no integrando: |dx - f|.
errointegrando = cell(f{end,1},1);
for i =1:f{end,1}
    errointegrando{i,1} = @(t) abs( ppval(ppxhder{i,1},t) - ...
                     f{i,1}(xchapeu(t),zchapeu(t),uchapeu(t),ph) );
end
end