% Código para obter as representacións gráficas do traballo.

% Problema de freada dun bloque.
thnew =[];
for i = 1:length(th)-1
    v = linspace(th(i),th(i+1),4);
    thnew = [thnew v(1:end-1)];
end
thnew = [thnew th(end)];
subplot(1,2,1)
yy = spline(th,uh,thnew);
plot(thnew,yy)
ylim([1,2])
xlabel('t'); ylabel('u(t)'); 
title('Forza exercida polo operario');
hold on
plot(th,uh,'o','MarkerEdgeColor',[0 0.4470 0.7410], ...
            'MarkerFaceColor',[0 0.4470 0.7410],'MarkerSize',2)
hold off
subplot(1,2,2)
yy = spline(th,xh,thnew);
plot(thnew,yy)
plot(th,xh)
xlabel('t'); ylabel('x(t)'); 
title('Velocidade do bloque co tempo');
hold on
plot(th,xh,'o','MarkerEdgeColor',[0 0.4470 0.7410], ...
            'MarkerFaceColor',[0 0.4470 0.7410],'MarkerSize',2)
hold off

% Problema do reactor descontinuo.
thnew =[];
for i = 1:length(th)-1
    v = linspace(th(i),th(i+1),4);
    thnew = [thnew v(1:end-1)];
end
thnew = [thnew th(end)];
yy = spline(th,uh,thnew);
plot(thnew,yy)
ylim([0,5.5])
xlabel('t');ylabel('u(t)');
title('Perfil de temperaturas na reacción');
hold on
plot(th,uh,'o','MarkerEdgeColor',[0 0.4470 0.7410], ...
        'MarkerFaceColor',[0 0.4470 0.7410],'MarkerSize',2)
hold off

subplot(1,2,1)
yy = spline(th,xh(1,:),thnew);
plot(thnew,yy)
xlabel('t'); ylabel('x_1(t)'); title('Cantidade de reactivo A');
ylim([0,1])
hold on
plot(th,xh(1,:),'o','MarkerEdgeColor',[0 0.4470 0.7410], ...
        'MarkerFaceColor',[0 0.4470 0.7410],'MarkerSize',2)
hold off
subplot(1,2,2)
yy = spline(th,xh(2,:),thnew);
plot(thnew,yy)
xlabel('t'); ylabel('x_2(t)'); title('Cantidade de produto B')
ylim([0 1])
hold on
plot(th,xh(2,:),'o','MarkerEdgeColor',[0 0.4470 0.7410], ...
             'MarkerFaceColor',[0 0.4470 0.7410],'MarkerSize',2)
hold off

% Problema do carro con péndulo.
thnew =[];
for i = 1:length(th)-1
    v = linspace(th(i),th(i+1),4);
    thnew = [thnew v(1:end-1)];
end
thnew = [thnew th(end)];
subplot(1,2,1)
yy = spline(th,xh(1,:),thnew);
plot(thnew,yy)
xlabel('t'); ylabel('x_1(t)'); title('Movemento do carro');
ylim([0,1.5])
hold on
plot(th,xh(1,:),'o','MarkerEdgeColor',[0 0.4470 0.7410], ...
        'MarkerFaceColor',[0 0.4470 0.7410],'MarkerSize',2)
hold off
subplot(1,2,2)
yy = spline(th, xh(2,:), thnew);
plot(thnew,yy)
xlabel('t'); ylabel('x_2(t)'); 
title('Ángulo do péndulo durante o movemento')
ylim([-2,4])
hold on
plot(th,xh(2,:),'o','MarkerEdgeColor',[0 0.4470 0.7410], ...
          'MarkerFaceColor',[0 0.4470 0.7410],'MarkerSize',2)
hold off

subplot(1,1,1)
yy = spline(th,uh,thnew);
plot(thnew,yy)
ylim([-20,10])
xlabel('t'); ylabel('u(t)'); title('Forza aplicada ao carro');
hold on
plot(th,uh,'o','MarkerEdgeColor',[0 0.4470 0.7410], ...
    'MarkerFaceColor',[0 0.4470 0.7410],'MarkerSize',2)
hold off

% Problema de Rayleigh
thnew =[];
for i = 1:length(th)-1
    v = linspace(th(i),th(i+1),4);
    thnew = [thnew v(1:end-1)];
end
thnew = [thnew th(end)];
yy = spline(th,uh,thnew);
plot(thnew,yy)
ylim([-2,8])
xlabel('t'); ylabel('u(t)'); title('Problema de Rayleigh');
hold on
plot(th,uh,'o','MarkerEdgeColor',[0 0.4470 0.7410], ...
        'MarkerFaceColor',[0 0.4470 0.7410],'MarkerSize',2)
hold off