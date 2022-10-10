clc
close all
clear

x1=linspace(-3,3, 100);
x2=linspace(-3,3, 100);
[x1,x2] = meshgrid(x1,x2);
f = x1.^2 + x2.^2;


% alp = -1/3;
x=linspace(-3,3, 100);

figure
contour(x1, x2, f, [0.1 0:2:30], 'DisplayName', '')
hold on
plot(0, 2, 'o', 'LineWidth', 3, 'MarkerSize', 15, 'DisplayName', '')
hold on

alphas = [-0.5 -0.25 -0.2 -0.1];

for a = alphas
    y = a*x.^2+2;
    if a == -0.25
        plot (x, y,'color', 'k','LineWidth', 3, 'DisplayName', strcat('a=',num2str(a)));
    else
        plot (x, y, '--', 'LineWidth', 2, 'DisplayName', strcat('a=',num2str(a)));
    end
    hold on
end
legend();
xlabel('$x_{1}$', 'Interpreter', 'latex');
ylabel('$x_{2}$', 'Interpreter', 'latex');



