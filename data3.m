% Datos programa OCP_Refinamento.
% Problema do carro con péndulo.

% Intervalo temporal [t_0, t_f].
t0 = 0; tf = 2;

% Número de variables do sistema.
variab = struct('ndif', 5, 'nalx', 0, 'ncon', 1, 'npar', 0);

% Función obectivo, funcional a minimizar. Definida segundo a
% discretización (desvantaxe do código).
 Phi =  @(xh,zh,uh,ph) xh(5,end);

% Funcións do sistema de DAEs
% dx = f(x,z,u,p); x(t0)=x_0;
% 0 = g(x,z,u,p); 

% Función f, o último elemento é o tamaño.
f = {@(x,z,u,p) x(3); ...
     @(x,z,u,p) x(4); ...
     @(x,z,u,p) ( 0.15*sin(x(2)).*(x(4).^2) + ...
               u(1) + 0.3*9.81*cos(x(2)).*sin(x(2)) )./( 1 + ...
               0.3*(1-(cos(x(2)).^2)) ) ;
     @(x,z,u,p) -( 0.15*cos(x(2)).*sin(x(2)).*(x(4).^2) + ...
               u(1).*cos(x(2)) + 1.3*9.81*sin(x(2)) )./( 0.5 + ...
               0.15*(1-(cos(x(2)).^2)) );
     @(x,z,u,p) u(1).^2;
     5};

% Función g, o último elemento é o tamaño.
g = {0};

% Condicións inicias, x(t0)=x_0, o último elemento é o tamaño.
conx = { 0; 0; 0; 0; 0; 5};

% Condicións finais, x(tf)=x_f, o último elemento é o tamaño.
conf = {1; pi; 0; 0; 4};

% Funcións das restricións, o último elemento é o tamaño.
c = {0};

% Límites das variables, o último elemento é o tamaño.
uboundsx = {2; Inf; Inf; Inf; 800; 5}; uboundsz={0}; 
uboundsu = {20; 1}; uboundsp = {0};

lboundsx = {-2; -Inf; -Inf; -Inf; 0; 5}; lboundsz = {0}; 
lboundsu = {-20; 1}; lboundsp = {0};

% Número de puntos iniciais da malla n_col + 1 = nv (tense en 
% conta que Matlab comeza a contar en 1 e non en 0 como na 
% formulación teórica). Número de elementos da malla: 
% n_col = ncol.
ncol = 11; nv = 12;

% Tipo de discretización: trapecios [1], Hermite [2].
discret = 1;

% Orde teórica da discretización: trapecios [2], Hermite [4].
q = 2;

% Paso 3 do algoritmo: non [0], si [1].
paso3 = 0;

% Estratexia refinamento da malla: heurística [0], programación 
% enteira [1].
estratexia = 0;

% Tolerancia do erro.
tol = 1.e-4;

% Número máximo de iteracións.
maxit = 10;

% Número máximo de nodos.
maxnv = 8; 

% datos que se toman, data(datos).
datos = 3;