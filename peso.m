function pesosw = peso(th, ppxh, ppxhder)
% Cálculo dos pesos w que se empregan para obter un erro relativo.
%
% DATOS DE ENTRADA: 
% th: nodos da malla.
% ppxh: celda de variab.ndif filas e 1 columna que na fila i-ésima 
% contén o spline que interpola os datos da variable diferencial 
% i-ésima.
% ppxhder: celda de variab.ndif filas e 1 columna que na fila 
% i-ésima contén o spline derivada de ppxh{i,1}.
%
% DATOS DE SAÍDA:
% pesosw: vector de pesos cuxa coordenada i-ésima é o máximo do 
% valor absoluto de x_i nos nodos da malla e da súa derivada. 

% Número de variables de estado diferenciais.
ndif = size(ppxh, 1);
% Vector de pesos.
pesosw = ones(ndif, 1);
for i = 1:ndif
    pesosw(i) = max( [abs( ppval(ppxh{i,1},th) ), ...
                        abs( ppval(ppxhder{i,1},th) )] );
end
end