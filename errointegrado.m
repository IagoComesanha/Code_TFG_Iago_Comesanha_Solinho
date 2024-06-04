function etaerro = errointegrado(th, errointegraNdo)
% Función que obtén o erro absoluto integrado por intervalos.
%
% DATOS DE ENTRADA:
% th: nodos da malla.
% errointegraNdo: celda con variab.ndif filas e 1 columna que
% contén a función de erro por compoñentes.
%
% DATOS DE SAÍDA:
% etaerro: matriz con length(th)-1 filas e size(errointegraNdo,1) 
% columnas. En (k,i) contén o erro integrado do intervalo k-ésimo 
% para a compoñente i-esima.

% Número de nodos da malla.
nv = length(th); 
% Número de variables de estado diferenciais.
ndif = size(errointegraNdo, 1);
% Creación da matriz de erro integrado
etaerro = zeros(nv-1, ndif);
for k = 1:(nv-1)
    for i = 1:ndif
        etaerro(k,i) = integral(errointegraNdo{i,1}, th(k), ...
                        th(k+1), 'RelTol', 1e-10, 'AbsTol', 1e-15);
    end
end
end