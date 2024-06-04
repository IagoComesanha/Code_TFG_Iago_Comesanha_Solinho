% Traballo fin de grao Iago Comesaña Soliño 2024.
%
% Programa para resolver o problema de control óptimo mediante a 
% estratexia de collocation con esquemas Runge-Kutta e algoritmo de 
% refinamento da malla.

tic
clc
clear
close all

% ELECCIÓN DO PROBLEMA: ficheiro de datos.
% data0 % Problema de freada dun bloque.
data1 % Problema do reactor descontinuo.
% data2 % Problema de Rayleigh.
% data3 % Problema do carro con péndulo.

% MALLA INICIAL. 
% No caso do problema de Rayleigh (datos = 2), tómase un punto 
% extra: 0.1, por recomendación da referencia da que se obtivo o 
% problema.
if datos == 2 % Caso data2
     th = [t0 linspace(0.1, tf, nv-1)]; 
else
    th = linspace(t0, tf, nv);
end

% VALORES INICIAIS.
[xh, zh, uh, ph] = inic(variab, conx, conf, nv);

% Datos iniciais para os estados no exemplo do carro con péndulo,
% escollidos para obter resultados semellantes ao do artigo do 
% problema.
if datos == 3 % Caso data3
    xh(1,1:end) = 0.5*th; 
    xh(2,1:end) = 1.5*th; 
end

% Inicialización do contador de refinamentos.
ref=0;

% Bucle de resolución.
for i=1:maxit

    % TRANSFORMACIÓN EN NLP
    % Variables discretas -> vector de variables \xi.
    xih = discr2xi(variab, nv, xh, zh, uh, ph);
    % Funcións OCP -> Restricións NLP.
    [Fi, Gi, Hi, lbounds, ubounds] = discrfun2xifun(variab, nv, ...
        th, Phi, f, g, c, conx, conf, discret, lboundsp, ...
        lboundsu, uboundsp, uboundsu, lboundsx, uboundsx, ...
        lboundsz, uboundsz);

    % SOLUCIÓN DO NLP: SEQUENTIAL QUADRATIC PROGRAMMING.
    xii = SQP(xih, Fi, Gi, Hi, lbounds, ubounds);

    % INTERPOLACIÓN DE SOLUCIÓNS
    % \xi -> var.discretas
    [xh, zh, uh, ph] = xi2discr(variab, nv, xii);
    % SPLINES.
    % Mediante a función pp = spline(t,a) e ppval(pp, puntos).
    [ppxh, ppzh, ppuh, ppxhder] = aproxsol(th, xh, zh, uh);

    % ESTIMACIÓN DO ERRO
    [errointegraNdo, etaerro, pesosw, erroestimado] = estimacionerro( ...
        variab, th, ppxh, ppzh, ppuh, ph, f, ppxhder);
       
    % TEST DE CONVERXENCIA
    % Test de tolerancia.
    if max(erroestimado) < tol
        disp(['Iteración: ' num2str(i)])
        disp(['Tolerancia superada: ' num2str(tol)])
        disp(['Erro estimado máximo: ' num2str(max(erroestimado))])
        disp(['Valor da función obxectivo: ' num2str(Phi(xh, ...
                                                       zh,uh,ph))])
        break
    end
    % Test de tamaño da malla.
    if nv > maxnv
        disp(['Iteración: ' num2str(i)])
        disp(['Malla elevada, lonxitude: ' num2str(length(th))])
        disp(['Erro estimado máximo: ' num2str(max(erroestimado))])
        disp(['Valor da función obxectivo: ' num2str(Phi(xh, ...
                                                       zh,uh,ph))])
        break
    end
    
    % SELECCIÓN CAMBIO DE MÉTODO DE ORDE q OU NON 
    % E PROCESO DE REFINAMENTO DA MALLA.
    if paso3 == 0
        if ref == 0
            % Argumentos descoñecidos no primeiro proceso de 
            % refinamento.
            thetaerro = []; I=[]; thprev=[];
        end
        % Proceso de refinamento e actualización de variables.
        [th, nv, I, xh, zh, uh, ref, thetaerro, thprev] = refinamento0( ...
            ref, etaerro, thetaerro, I, errointegraNdo, th, nv, ...
            erroestimado, q, estratexia, variab, ppxh, ppzh, ...
            ppuh, thprev, tol);

    elseif paso3 == 1
        if ref == 0
            % Argumentos descoñecidos no primeiro proceso de 
            % refinamento.
            thetaerro = []; I=[]; thprev=[];
        end
        % Proceso de refinamento e actualización de variables.
        [th, nv, I, xh, zh, uh, discret, ref, thetaerro, thprev] = refinamento1( ...
            i, ref, discret, etaerro, thetaerro, I, ...
            errointegraNdo, th, nv, erroestimado, q, ...
            estratexia, variab, ppxh, ppzh, ppuh, thprev, tol);
    end
end
toc

