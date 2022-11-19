function [] = plot_phi(xmin, xmax, ymin, ymax, phi, intervals, c, x, graph_title, k, i, j)
%     figure
    x1_ = linspace(xmin, xmax, 100);
    x2_ = linspace(ymin, ymax, 100);
    [x1,x2] = meshgrid(x1_,x2_);

    subplot(i,j,k)
    if isempty(intervals)
        contour(x1, x2, phi(x1,x2));
    else
        contour(x1, x2, phi(x1,x2), intervals);
    end
    hold on;
    plot(x1_, c(x1_), 'r-', 'LineWidth', 2);  
    hold on;  
    for k = 1:length(x)
        plot(x(1,k), x(2,k),'o', 'LineWidth', 2, 'MarkerSize', 10)
        if k<length(x)
            desenha_flecha(x(:,k)', x(:,k+1)', 'k');
        end
    end
    title(graph_title)
    xlabel('$x_{1}$', 'Interpreter', 'latex')
    ylabel('$x_{2}$', 'Interpreter', 'latex')
end
% 
% function [] = plot_phi(xmin, xmax, ymin, ymax, phi, intervals, c, x, graph_title)
%     figure
%     x1_ = linspace(xmin, xmax, 100);
%     x2_ = linspace(ymin, ymax, 100);
%     [x1,x2] = meshgrid(x1_,x2_);
% 
% %     subplot(3,3,k)
%     if isempty(intervals)
%         contour(x1, x2, phi(x1,x2));
%     else
%         contour(x1, x2, phi(x1,x2), intervals);
%     end
%     hold on;
%     plot(x1_, c(x1_), 'r-', 'LineWidth', 2);  
%     hold on;  
%     for k = 1:length(x)
%         plot(x(1,k), x(2,k),'o', 'LineWidth', 2, 'MarkerSize', 10)
%         if k<length(x)
%             desenha_flecha(x(:,k)', x(:,k+1)', 'k');
%         end
%     end
%     title(graph_title)
%     xlabel('$x_{1}$', 'Interpreter', 'latex')
%     ylabel('$x_{2}$', 'Interpreter', 'latex')
% end