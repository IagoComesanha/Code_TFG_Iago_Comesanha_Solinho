function [Fi, Gi, Hi,lbounds, ubounds] = TrapColl(variab, nv, ...
    th, Phi, f, g, c, conx, conf, lboundsp, lboundsu, uboundsp, ...
    uboundsu, lboundsx, uboundsx, lboundsz, uboundsz)
% Función para obter a función obxectivo e restricións do problema 
% NLP mediante un esquema de discretización de trapecios.
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
% lbounds, ubounds (celdas cos límites das distintas variables)
%
% DATOS DE SAÍDA: (Funcións Vectoriais)
% Fi: función obxectivo do NLP. 
% Gi: restricións de igualdade do NLP, Gi(xi) = 0.
% Hi: restricións do NLP do tipo Hi(xi) <= 0.
% lbounds: límites inferiores de xi.
% ubounds: límites superiores de xi.

% Número de variables continuas do sistema.
nvar = variab.ndif + variab.nalx + variab.ncon; 
% Parámetros
i0 = variab.npar;
indp = 1:i0;

% f(x(t_i)), g(x(t_i)), c(x(t_i))
fi = cell(f{end,1}, nv); gi = cell(g{end,1}, nv); 
ci = cell(c{end,1}, nv);
for i = 1:nv
    % Índices respectivos no vector xi para conseguir as
    % variables avaliadas en t_i-1.
    indx = (i0 + (i-1)*nvar + 1):(i0 + (i-1)*nvar + variab.ndif);
    indz = (i0+ (i-1)*nvar + variab.ndif + 1):(i0 + (i-1)*nvar +...
                                        variab.ndif + variab.nalx);
    indu = (i0 + (i-1)*nvar + variab.ndif + variab.nalx ...
                                                + 1):(i0 + i*nvar);
    % Funcións f nos nodos da malla.
    for j = 1:f{end,1}
        fi{j,i} = @(xi) f{j,1}(xi(indx), xi(indz), xi(indu), ...
                                                        xi(indp));
    end
    % Funcións g nos nodos da malla.
    for j = 1:g{end,1}
        gi{j,i} = @(xi) g{j,1}(xi(indx), xi(indz), xi(indu), ...
                                                        xi(indp));
    end
    % Funcións c nos nodos da malla.
    for j = 1:c{end,1}
        ci{j,i} = @(xi) c{j,1}(xi(indx), xi(indz), xi(indu), ...
                                                        xi(indp));
    end
end

% Lonxitude dos elementos da malla.
h = th(2:end) - th(1:end-1);

% Función obxectivo con argumento \xi.
Fi = @(xi) Phi(matrix(xi,variab,nv,1), matrix(xi,variab,nv,2), ...
                matrix(xi,variab,nv,3), xi(indp));

% FUNCIÓNS G(xi) = 0 e H(xi) <= 0.
% Restricións en celdas.
preG = cell(variab.ndif,nv);
for j = 1:variab.ndif
    % Condicións iniciais.
    preG{j,1} = @(xi) xi(i0 + j) - conx{j,1};
    % Esquema de tipo trapecios.
    for i = 2:nv
        % Índices i, i-1.
        ind1 = i0 + (i-1)*nvar + j; 
        ind = i0+ (i-2)*nvar + j;
        % Restrición correspondente.
        preG{j,i} = @(xi) xi(ind1) - xi(ind) - ...
                        h(i-1)*(fi{j,i-1}(xi) + fi{j,i}(xi))/2 ; 
    end
end
% Condicións finais.
preGf = cell(conf{end,1}, 1);
for j = 1:conf{end,1}
    preGf{j,1} = @(xi) xi(end-nvar+j) - conf{j,1};
end

% Función vectorial G e H.
Gi = @(x)[]; Hi = @(x)[];
for i =1:nv
    for j = 1:variab.ndif
        Gi = @(x) [Gi(x); preG{j,i}(x)];
    end
    for j = 1:g{end,1}
        Gi = @(x) [Gi(x); gi{j,i}(x)];
    end
    for j = 1:c{end,1}
        Hi = @(x) [Hi(x); ci{j,i}(x)];
    end
end
for j = 1:conf{end,1}
    Gi = @(xi) [Gi(xi); preGf{j,1}(xi)];
end

% LÍMITES DAS VARIABLES.
% Límites inferiores e superiores de parámetros.
lboundspvec = zeros(variab.npar,1);
uboundspvec = zeros(variab.npar,1);
for i = 1:variab.npar
    lboundspvec(i) = lboundsp{i,1};
    uboundspvec(i) = uboundsp{i,1};
end
% Límites inferiores e superiores de variables continuas.
lboundsvec = zeros(nvar,1);
uboundsvec = zeros(nvar,1);
for i = 1:variab.ndif
    lboundsvec(i) = lboundsx{i,1};
    uboundsvec(i) = uboundsx{i,1};
end
for i = 1:variab.nalx
    lboundsvec(variab.ndif + i) = lboundsz{i,1};
    uboundsvec(variab.ndif + i) = uboundsz{i,1};
end
for i = 1:variab.ncon
    lboundsvec(variab.ndif + variab.nalx + i) = lboundsu{i,1};
    uboundsvec(variab.ndif + variab.nalx + i) = uboundsu{i,1};
end
% Límites inferiores e superiores totais.
lbounds = zeros(i0 + nv*nvar,1);
ubounds = zeros(i0 + nv*nvar,1);
lbounds(indp) = lboundspvec;
ubounds(indp) = uboundspvec;
for i = 1:nv
       lbounds((i0 + (i-1)*nvar + 1): (i0 + i*nvar)) = lboundsvec;
       ubounds((i0 + (i-1)*nvar + 1): (i0 + i*nvar)) = uboundsvec;
end
end