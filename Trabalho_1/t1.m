clear
clc
close all

% dados do item 01a, f, grad f, hess f e x0
fa = @(x) x(1)^2-3*x(1)*x(2)+4*x(2)^2+x(1)-x(2);
gfa = @(x) [2*x(1)-3*x(2)+1 ; -3*x(1)+8*x(2)-1];
Ha = @(x) [2 -3;-3 8];
x01 = [2;2];
x02 = [-1;-3];

% dados do item 01b, f, grad f, hess f e x0
param_a=10;
param_b=1;
fb = @(x) (1+param_a-param_b*x(1)-param_b*x(2))^2 + (param_b+x(1)+param_a*x(2)-param_b*x(1)*x(2))^2;
gfb = @(x) [2*x(1)*(x(2)^2-2*x(2)+2)-20*(x(2)^2-x(2)+1) ; 2*x(1)^2*(x(2)-1)+x(1)*(20-40*x(2))+202*x(2)-2];
% Hb = @(x) [2 + 2*(1-x(2))^2 , 2 + 2*(10-x(1))*(1-x(2)) - 2*(1+x(1)+10*x(2)-x(1)*x(2)) ; 2 + 2*(10-x(1))*(1-x(2)) - 2*(1-x(1)*x(2)+x(1)+10*x(2)), 2 + 2*(10-x(1))^2];
Hb = @(x) [2*(1-x(2))^2+2, ...
2*(10-x(1))*(1-x(2))-2*(x(1)*(-x(2))+x(1)+10*x(2)+1)+2; ...
2*(10-x(1))*(1-x(2))-2*(x(1)*(-x(2))+x(1)+10*x(2)+1)+2, ...
2*(10-x(1))^2+2];
xb01 = [10;2];
xb02 = [-2;-3];

% dados do item 2, f, grad f, hess f e x0
fc = @(x) 450*(sqrt((30+x(1))^2+x(2)^2)-30)^2 + 300*(sqrt((30-x(1))^2+x(2)^2)-30)^2 - 360*x(2);
gfc = @(x) [(900*(x(1)+30)*(sqrt((x(1)+30)^2+x(2)^2)-30))/sqrt((x(1)+30)^2+x(2)^2)-(600*(30-x(1))*(sqrt((x(1)-30)^2+x(2)^2)-30))/sqrt((x(1)-30)^2+x(2)^2); ...
60*(x(2)*(-450/sqrt(x(1)^2+60*x(1)+x(2)^2+900)-300/sqrt(x(1)^2-60*x(1)+x(2)^2+900)+25)-6)];
Hc = @(x) [-(600*(30-x(1))^2*(sqrt((30-x(1))^2+x(2)^2)-30))/((30-x(1))^2+x(2)^2)^(3/2)+(600*(30-x(1))^2)/((30-x(1))^2+x(2)^2)+(600*(sqrt((30-x(1))^2+x(2)^2)-30))/sqrt((30-x(1))^2+x(2)^2)+(900*(sqrt((x(1)+30)^2+x(2)^2)-30))/sqrt((x(1)+30)^2+x(2)^2)-(900*(x(1)+30)^2*(sqrt((x(1)+30)^2+x(2)^2)-30))/((x(1)+30)^2+x(2)^2)^(3/2)+(900*(x(1)+30)^2)/((x(1)+30)^2+x(2)^2), ...
(600*(30-x(1))*x(2)*(sqrt((30-x(1))^2+x(2)^2)-30))/((30-x(1))^2+x(2)^2)^(3/2)-(900*(x(1)+30)*x(2)*(sqrt((x(1)+30)^2+x(2)^2)-30))/((x(1)+30)^2+x(2)^2)^(3/2)-(600*(30-x(1))*x(2))/((30-x(1))^2+x(2)^2)+(900*(x(1)+30)*x(2))/((x(1)+30)^2+x(2)^2); ...
(600*(30-x(1))*x(2)*(sqrt((30-x(1))^2+x(2)^2)-30))/((30-x(1))^2+x(2)^2)^(3/2)-(900*(x(1)+30)*x(2)*(sqrt((x(1)+30)^2+x(2)^2)-30))/((x(1)+30)^2+x(2)^2)^(3/2)-(600*(30-x(1))*x(2))/((30-x(1))^2+x(2)^2)+(900*(x(1)+30)*x(2))/((x(1)+30)^2+x(2)^2), ...
-(600*x(2)^2*(sqrt((30-x(1))^2+x(2)^2)-30))/((30-x(1))^2+x(2)^2)^(3/2)-(900*x(2)^2*(sqrt((x(1)+30)^2+x(2)^2)-30))/((x(1)+30)^2+x(2)^2)^(3/2)+(600*x(2)^2)/((30-x(1))^2+x(2)^2)+(900*x(2)^2)/((x(1)+30)^2+x(2)^2)+(600*(sqrt((30-x(1))^2+x(2)^2)-30))/sqrt((30-x(1))^2+x(2)^2)+(900*(sqrt((x(1)+30)^2+x(2)^2)-30))/sqrt((x(1)+30)^2+x(2)^2)];
xc0 = [0.01;-0.1];

dx = 1; %plotting purposes, controla min e max dos eixos

% parametros dos algoritmos
iter_max = 100;
a = 0.002;
TOL = 1e-4; % parada do gradiente
TOL2 = 1e-7; % busca linear

methods = ["Univariante","Powell","Steepest Descent","Fletcher Reeves","Newton-Raphson","BFGS"];

% funcao do item a
fprintf('\n******************** ITEM 01A ************************\n');
for method = 1:6
    fprintf('---%s---\n', methods(method));

    fprintf('x0=[%2d,%2d]: ',x01(1), x01(2));
    [x_1,t] = osr (fa, gfa, Ha, x01, method, iter_max, a, TOL, TOL2);
    fprintf('(%.1fms), xmin=[%0.4f,%0.4f], f=%0.4f\n', t*1000, x_1(1,end), x_1(2,end), fa(x_1(:,end)));

    fprintf('x0=[%2d,%2d]: ',x02(1), x02(2));
    [x_2,t] = osr (fa, gfa, Ha, x02, method, iter_max, a, TOL, TOL2);
    fprintf('(%.1fms), xmin=[%0.4f,%0.4f], f=%0.4f\n', t*1000, x_2(1,end), x_2(2,end), fa(x_2(:,end)));

%     plot_result(min([x_1(1,:), x_2(1,:)])-dx,max([x_1(1,:), x_2(1,:)])+dx,min([x_1(2,:), x_2(2,:)])-dx,max([x_1(2,:), x_2(2,:)])+dx, x_1, x_2, methods(method), 1)
%     exportgraphics(gcf,strcat('./figures/img01A_m0',num2str(method),'.png'),'Resolution',500)    
end

% % funcao do item b
fprintf('\n******************** ITEM 01B ************************\n');
for method = 1:6
    fprintf('---%s---\n', methods(method));
    
    fprintf('x0=[%2d,%2d]: ',xb01(1), xb01(2));
    [x_1,t] = osr (fb, gfb, Hb, xb01, method, iter_max, a, TOL, TOL2);
    fprintf('(%.1fms), xmin=[%0.4f,%0.4f], f=%0.1f\n', t*1000, x_1(1,end), x_1(2,end), fb(x_1(:,end)));

    fprintf('x0=[%2d,%2d]: ',xb02(1), xb02(2));
    [x_2,t] = osr (fb, gfb, Hb, xb02, method, iter_max, a, TOL, TOL2);
    fprintf('(%.1fms), xmin=[%0.4f,%0.4f], f=%0.1f\n', t*1000, x_2(1,end), x_2(2,end), fb(x_2(:,end)));

%     plot_result(min([x_1(1,:), x_2(1,:)])-dx,max([x_1(1,:), x_2(1,:)])+dx,min([x_1(2,:), x_2(2,:)])-dx,max([x_1(2,:), x_2(2,:)])+dx, x_1, x_2, methods(method), 2)
%     exportgraphics(gcf,strcat('./figures/img01B_m0',num2str(method),'.png'),'Resolution',500)
end

% funcao do item 2
fprintf('\n******************** ITEM 02 ************************\n');
for method = 1:6
    fprintf('---%s---\n', methods(method));
    
    fprintf('x0=[%.2f,%.2f]: ',xc0(1), xc0(2));
    [x_1,t] = osr (fc, gfc, Hc, xc0, method, iter_max, 0.005, 5e-4, TOL2);
    fprintf('(%.1fms), xmin=[%0.3f,%0.3f], f=%0.1f\n', t*1000, x_1(1,end), x_1(2,end), fc(x_1(:,end)));
    
%     plot_result(min(x_1(1,:))-dx,max(x_1(1,:))+dx,min(x_1(2,:))-dx,max(x_1(2,:))+dx, x_1, [], methods(method), 3)
%     exportgraphics(gcf,strcat('./figures/img02_m0',num2str(method),'.png'),'Resolution',500)
end
