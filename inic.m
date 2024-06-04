function [xh, zh, uh, ph] = inic(variab, conx, conf, nv)
% Función de inicialización das variables do sistema avaliadas na 
% malla. Inicialízanse todas a vector de uns, e engádense ás 
% diferenciais as condicións iniciais, e as finais se as hai.
% (Ollo: ter coidado se as variables non poden tomar o valor 1, 
% asignar outros valores manualmente)
%
% DATOS DE ENTRADA:
% variab: estrutura co nº de variables do sistema.
% conx: celda coas condicións iniciais do problema.
% conf: celda coas condicións finais do problema.
% nv: nº de puntos da malla.
%
% DATOS DE SAÍDA:
% xh: matriz (variab.ndif x nv) onde o elemento (i,j) representa 
% a variable diferencial i-ésima no nodo j-ésimo.
% zh: matriz (variab.nalx x nv) onde o elemento (i,j) representa 
% a variable alxébrica i-ésima no nodo j-ésimo.
% uh: matriz (variab.ncon x nv) onde o elemento (i,j) representa 
% a variable de control i-ésima no nodo j-ésimo.
% ph: vector cos parámetros do sistema (valores inciais): de 
% lonxitude variab.npar.

% Variables de estado diferenciais.
xh = ones(variab.ndif, nv);
% Condicións iniciais.
for i = 1:conx{end,1}
    xh(i,1) = conx{i,1};
end
% Condicións finais.
for i = 1:conf{end,1}
    xh(i,nv) = conf{i,1};
end

% Variables de estado alxébricas.
zh = ones(variab.nalx, nv);

% Variables de control.
uh = ones(variab.ncon, nv);

% Parámetros.
ph = ones(variab.npar, 1);

end