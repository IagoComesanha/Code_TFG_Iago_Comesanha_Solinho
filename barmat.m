function v = barmat(funcion, x, nodo)
% Función para construir o argumento da función \bar{f}^{k+1}: 
% devolve un vector do tipo de variable avaliado no nodo.
%
% DATOS DE ENTRADA:
% funcion: celda con cada función a avaliar, por ex barx.
% x: argumento de entrada de funcion.
% nodo: nodo da malla no que se pretende avaliar.
%
% DATOS DE SAÍDA:
% v: vector coa avaliación correspondente.

% Número de variables que se pasan como argumento.
n = size(funcion,1);
% Asignación.
v = zeros(n,1);
for i = 1:n
   v(i) = funcion{i,nodo}(x);
end

        


end