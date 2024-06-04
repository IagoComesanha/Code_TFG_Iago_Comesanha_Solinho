function r = reducion(etaerro, thetaerro, q, I, errointegraNdo, ...
    thprev)
% Función para o vector de r_k's onde cada r_k é a estimación da
% redución da orde sufrida no intervalo k-ésimo da malla actual.
% Tomarase como estimación k-ésima a media das estimacións no 
% intervalo k de cada compoñente dos estados.
%
% DATOS DE ENTRADA:
% etaerro: erro integrado estimado na malla actual.
% thetaerro: erro integrado estimado na malla previa.
% q: orde do método de discretización.
% I: vector co nº de puntos engadidos á malla antiga.
% errointegraNdo: celda con f{end,1} (ou variab.ndif) filas e 
% 1 columna que contén a función de erro por compoñentes.
% thprev: nodos da malla previa.
%
% DATOS DE SAÍDA:
% r: vector coa redución de orde por intervalos.

% Número de elementos da malla.
rtam = size(etaerro, 1);
% Número de variables de estado diferenciais.
comp = size(etaerro, 2);
% Inicialización vector r de reducións de orde.
r = zeros(rtam, 1);
% Número de elementos da malla previa.
inter = size(thetaerro, 1);
% Vectores auxiliares intermedios.
prerhat = zeros(inter, 1); 
prer = zeros(inter, 1);

for k = 1:inter
   % r_k
   % Argumento do logaritmo do denominador.
   denom = 1 + I(k);
   % Erro do elemento k para cada compoñente: vectores.
   etavec = zeros(comp, 1); 
   thetavec = zeros(comp, 1);
   for i = 1:comp
       etavec(i) = integral(errointegraNdo{i,1}, thprev(k), ...
                   thprev(k+1), 'RelTol', 1e-10, 'AbsTol', 1e-15);
       thetavec(i) = thetaerro(k,i);
   end
   % Vector de redución da orde nos elementos previos.
   prerhat(k) = mean(q + 1 - log(thetavec./etavec)/log(denom));
   prer(k) = max(0, min(round(prerhat(k)),q));
end

% Reparto da redución da orde polos elementos que proveñen do 
% mesmo previo.
j = 1;
for k = 1:inter
    % Puntos engadidos ao elemento k.
    numpuntos = I(k);
    if numpuntos == 0
        % Mantense un único intervalo.
        r(j) = prer(k);
        j = j+1;
    elseif numpuntos >= 1
        % Quedan numpuntos + 1 intervalos.
        r(j:(j+numpuntos)) = prer(k);
        j = j + numpuntos + 1;
    end
end
end