function [alpha_L, alpha_H] = passo_constante(f, x0, d, a)
    alpha = 0;
    f_min = Inf;
    f_val = f(x0);
    alphas = [];    
    f1 = f(x0 - a*d);
    f2 = f(x0 + a*d);
    if f1 < f2
        a=-a; % desce a esq (d-)
    end
    while f_val <= f_min
        x = x0 + alpha * d;       
        f_val = f(x);
%         fprintf('f=%e----',f_val);
        if f_val < f_min
            f_min = f_val;
        end
        alphas = [alphas; alpha];
        alpha = alpha + a;
    end
    alpha_L = alphas(end-1);
    alpha_H = alphas(end);
    if a < 0
        alpha_H = alphas(end-1);
        alpha_L = alphas(end);
    end    
end

% 
% function [alpha_L, alpha_H] = passo_constante(f, x0, d, a)
%     % inicialização
%     alpha = 0;
%     f_min = Inf;
%     f_val = f(x0);
%     alphas = [];
%     
%     f1 = f(x0 - a*d);
%     f2 = f(x0 + a*d);
% 
%     % andar para +d ou -d (sentido)
%     if f1 < f2
%         a=-a; % desce a esq (d-)
%     end
%     
%     % looping
%     while f_val <= f_min
%         x = x0 + alpha * d;       
%         f_val = f(x);
% 
%         if f_val < f_min
%             f_min = f_val;
%         end
%         % salva alpha
%         alphas = [alphas; alpha];
%         % atualiza alpha
%         alpha = alpha + a;
%     end
%     alpha_L = alphas(end-1);
%     alpha_H = alphas(end);
% 
% %     fprintf ('AL= %0.4f, AH = %0.4f \n', alpha_L, alpha_H);
% end