function [alpha_L, alpha_H] = passo_constante(f, x0, d, a)
    % inicializaç\~ao
    alpha = 0;
    f_min = Inf;
    f_val = f(x0);
    alphas = [];
    
%     fprintf('call\n d=%d, %d \n', d(1), d(2))
%     fprintf('x=%d, %d \n', x0(1), x0(2))

    f1 = f(x0 - a*d);
    f2 = f(x0 + a*d);
    
%     fprintf('f1=%0.4f,f2=%0.4f  \n', f1, f2);


    % andar para +d ou -d (sentido)
    if f2 < f1
        a=a; % desce a dir (d+)
    else
        a=-a; % desce a esq (d-)
    end
    
    % looping
    while f_val <= f_min
        x = x0 + alpha * d;       
        
%         fprintf ('alpha=%0.4f, f=%0.8f \n', alpha, f(x));        
        f_val = f(x);

        if f_val < f_min
            f_min = f_val;
        end
        % salva alpha
        alphas = [alphas; alpha];
        % atualiza alpha
        alpha = alpha + a;
    end
    alpha_L = alphas(end-1);
    alpha_H = alphas(end);

%     fprintf ('AL= %0.4f, AH = %0.4f \n', alpha_L, alpha_H);
end