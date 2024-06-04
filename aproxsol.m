function [ppxh, ppzh, ppuh, ppxhder] = aproxsol(th, xh, zh, uh)
% Función que constrúe celdas dunha columna para almacenar as
% aproximacións por splines correspondentes a cada variable do 
% sistema. A interpolación realízase a partir dos datos nos puntos 
% da malla mediante a función spline, que consegue unha estrutura 
% capaz de ser avaliada.
% Opción de mellora para traballo futuro: incorporar a información 
% das derivadas de x no seu spline como se indica no traballo.
% 
% DATOS DE ENTRADA:
% th: puntos da malla.
% xh: matriz (variab.ndif x nv) onde o elemento (i,j) representa 
% a variable diferencial i-ésima no nodo j-ésimo.
% zh: matriz (variab.nalx x nv) onde o elemento (i,j) representa 
% a variable alxébrica i-ésima no nodo j-ésimo.
% uh: matriz (variab.ncon x nv) onde o elemento (i,j) representa 
% a variable de control i-ésima no nodo j-ésimo.
%
% DATOS DE SAÍDA:
% ppxh: celda de variab.ndif filas e 1 columna que na fila i-ésima 
% contén o spline que interpola os datos da variable diferencial 
% i-ésima.
% ppzh: celda de variab.nalx filas e 1 columna que na fila i-ésima 
% contén o spline que interpola os datos da variable alxébrica
% i-ésima.
% ppuh: celda de variab.ncon filas e 1 columna que na fila i-ésima 
% contén o spline que interpola os datos da variable de control 
% i-ésima.
% ppxhder : celda de variab.ndif filas e 1 columna que na fila 
% i-ésima contén o spline derivada de ppxh{i,1}.

% Variables de estado diferenciais.
n = size(xh,1);
ppxh = cell(n,1);
for i = 1:n
    ppxh{i,1} = spline(th, xh(i,:));
end
% Cálculo da derivada de ppxh
ppxhder = cell(n,1);
for i = 1:n
    ppxhder{i,1} = fnder(ppxh{i,1},1);
end

% Variables de estado alxébricas.
n = size(zh,1);
ppzh = cell(n,1);
for i = 1:n
    ppzh{i,1} = spline(th, zh(i,:));
end

% Variables de control.
n = size(uh,1);
ppuh = cell(n,1);
for i = 1:n
    ppuh{i,1} = spline(th, uh(i,:));
end
end