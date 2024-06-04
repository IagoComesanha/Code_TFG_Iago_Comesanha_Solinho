function thi = engadir(I, th)
% Función que constrúe a nova malla a partir da anterior e do nº
% de puntos que hai que engadir por intervalo. Engádense os 
% puntos de xeito uniforme.
%
% DATOS DE ENTRADA:
% I: puntos engadidos en cada intervalo.
% th: malla actual.
%
% DATOS DE SAÍDA:
% thi: nova malla.

% Número de elementos da malla previa.
n = length(I);

thi = [];
for i=1:n
    if I(i)==0
        % Escríbese só o punto t_i.
        thi = [thi th(i)];
    end
    if I(i)>=1
        % Divídese equitativamente.
        z = linspace(th(i), th(i+1), I(i)+2);
        % Non se engade o punto t_i+1.
        thi = [thi z(1:end-1)];
    end
end
% Engádese t_f.
thi = [thi th(end)];
end