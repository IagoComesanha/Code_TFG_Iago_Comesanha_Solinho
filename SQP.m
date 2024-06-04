function xii = SQP(xi0, Fi, Gi, Hi, lbounds, ubounds)
% Función para a resolución dun NLP mediante Secuential Quadratic
% Programming. Constrúese a estrutura problem e chámase a fmincon.
%
% DATOS DE ENTRADA: 
% xi0: iterante inicial.
% Fi: función obxectivo.
% Gi: Gi(xi) = 0.
% Hi: Hi(xi) <= 0.
% lbounds: límites inferiores.
% ubounds: límites superiores.
%
% DATOS DE SAÍDA:
% xii: solución do NLP.

problem.objective = Fi;
problem.x0 = xi0;
problem.Aineq = []; problem.bineq = [];
problem.Aeq = []; problem.beq = [];
problem.lb = lbounds; problem.ub = ubounds;
problem.nonlcon = @nonlinear;
problem.solver = 'fmincon';
problem.options = optimoptions('fmincon', 'Algorithm', 'sqp', ...
                    'MaxIterations', 50, 'Display', 'off');
xii = fmincon(problem);

function [c ceq] = nonlinear(x)
c = Hi(x);
ceq = Gi(x);
end
end

