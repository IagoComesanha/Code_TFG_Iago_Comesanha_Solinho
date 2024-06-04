function [errointegraNdo, etaerro, pesosw, erroestimado] = estimacionerro( ...
    variab, th, ppxh, ppzh, ppuh, ph, f, ppxhder)
% Función para calcular a estimación do erro do algoritmo de
% refinamento da malla.
%
% DATOS DE ENTRADA:
% variab: estrutura co nº de variables do problema.
% th: vector cos nodos da malla temporal.
% ppxh: celda de variab.ndif filas e 1 columna que na fila i-ésima 
% contén o spline que interpola os datos da variable diferencial 
% i-ésima.
% ppzh: celda de variab.nalx filas e 1 columna que na fila i-ésima 
% contén o spline que interpola os datos da variable alxébrica 
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

% Cálculo do integrando como función.
errointegraNdo = erroabs(variab, ppxh, ppzh, ppuh, ph, f, ppxhder);
    
% Cálculo da integral de dentro.
etaerro = errointegrado(th, errointegraNdo);

% Cálculo dos pesos w.
pesosw = peso(th, ppxh, ppxhder);

% Cálculo erro aproximado epsilon.
erroestimado = epsk(etaerro, pesosw);
end