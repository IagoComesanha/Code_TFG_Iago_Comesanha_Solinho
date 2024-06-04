function [Fi, Gi, Hi, lbounds, ubounds] = discrfun2xifun(variab,...
    nv, th, Phi, f, g, c, conx, conf, discret, lboundsp, ...
    lboundsu, uboundsp, uboundsu, lboundsx, uboundsx, ...
    lboundsz, uboundsz)
% Función que constrúe a función obxectivo e as restricións do 
% problema de programación non linear que hai que resolver en cada 
% iteración do proceso.
%
% DATOS DE ENTRADA:
% variab: estrutura co nº de variables do problema.
% nv: nº de puntos da malla.
% th: puntos da malla.
% Phi: función obxectivo do problema orixinal.
% f: celda coas funcións das restricións de tipo x' = f.
% g: celda coas funcións das restricións alxébricas 0 = g.
% c: celda coas restricións de inecuación do problema orixinal.
% conx: celda coas condicións iniciais do sistema x' = f.
% conf: celda coas condicións finais das variables de estado.
% discret: tipo de método de discretización (trapecios [1],
% Hermite [2]).
% lbounds, ubounds (celdas coas limitacións das distintas 
% variables)
%
% DATOS DE SAÍDA: (Funcións Vectoriais)
% Fi: función obxectivo do NLP. 
% Gi: restricións de igualdade do NLP, Gi(xi) = 0.
% Hi: restricións do NLP do tipo Hi(xi) <= 0.
% lbounds: límites inferiores de xi.
% ubounds: límites superiores de xi.

if discret == 1
    [Fi, Gi, Hi, lbounds, ubounds] = TrapColl(variab, nv, th, ...
        Phi, f, g, c, conx, conf, lboundsp, lboundsu, uboundsp, ...
        uboundsu, lboundsx, uboundsx, lboundsz, uboundsz);
elseif discret == 2
    [Fi, Gi, Hi, lbounds, ubounds] = HermiteColl(variab, nv, th,...
        Phi, f, g, c, conx, conf, lboundsp, lboundsu, uboundsp, ...
        uboundsu, lboundsx, uboundsx, lboundsz, uboundsz);
end
end