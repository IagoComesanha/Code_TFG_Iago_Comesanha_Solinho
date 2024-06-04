function erroestimado = epsk(etaerro, pesosw)
% Función que calcula definitavemente o erro estimado para 
% comprobar a validez da solución obtida.
%
% DATOS DE ENTRADA:
% etaerro: matriz con nv-1 filas e variab.ndif columnas. En {k,i} 
% contén o erro integrado do intervalo k-ésimo para a compoñente 
% i-esima.
% pesosw: vector de pesos cuxa coordenada i-ésima é o máximo do 
% valorabsoluto de x_i nos nodos da malla e da súa derivada 
%
% DATOS DE SAÍDA:
% erroestimado: vector que en cada compoñente contén o erro 
% estimado no intervalo k-ésimo, que é o máximo do erro relativo 
% por compoñentes no intervalo k-ésimo.

% Número de elementos da malla.
M = size(etaerro, 1); 
% Número de variables diferenciais.
n = size(etaerro, 2);
% Erro estimado útil.
erroestimado = zeros(M,1);
for k = 1:M
    cociente = zeros(n,1);
    for i = 1:n
        cociente(i) = etaerro(k,i)/(1 + pesosw(i));
    end
    erroestimado(k) = max(cociente);
end
end