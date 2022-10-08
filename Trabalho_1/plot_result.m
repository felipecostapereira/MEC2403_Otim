function [] = plot_result(xmin, xmax, ymin, ymax, x_, x2_, graph_title, func)
    n = length(x_);
    n2 = length(x2_);
    figure
    x1 = linspace(xmin, xmax, 100);
    x2 = linspace(ymin, ymax, 100);
    [x1,x2] = meshgrid(x1,x2);

    if func == 1
        fplot = x1.^2 - 3*x1.*x2 + 4*x2.^2 + x1 - x2;    
        contour(x1, x2, fplot, [0 2 8 15 30:20:120], 'ShowText','on');
    elseif func == 2
        fplot = (11-x1-x2).^2 + (1+x1+10*x2-x1.*x2).^2;
        contour(x1, x2, fplot, [50 122 200 1000 1625 5000 10000], 'ShowText','on')
    else
        fplot = 450*(sqrt((30+x1).^2+x2.^2)-30).^2+300*(sqrt((30-x1).^2+x2.^2)-30).^2-360*x2;
        contour(x1, x2, fplot, 'ShowText','on')    
    end
    title(graph_title)
    xlabel('$x_{1}$', 'Interpreter', 'latex')
    ylabel('$x_{2}$', 'Interpreter', 'latex')
    
    hold on
    for k = 1:n
        plot(x_(1,k), x_(2,k),'o', 'LineWidth', 2, 'MarkerSize', 10)
        if k<n
            desenha_flecha(x_(:,k)', x_(:,k+1)', 'k');
        end
    end

    if ~ isempty(x2_)
        for k = 1:n2
            plot(x2_(1,k), x2_(2,k),'o', 'LineWidth', 2, 'MarkerSize', 10)
            if k<n2
                desenha_flecha(x2_(:,k)', x2_(:,k+1)', 'r');
            end
        end      
    end
end