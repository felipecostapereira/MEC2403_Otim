function [x_,time_elap] = osr (f, gf, H, x0, method, iter_max, a, TOL, TOL2)
    % 1. Univariante
    % 2. Powell
    % 3. Steepest Descent
    % 4. FlecherReeves
    % 5. NewtonRaphson
    % 6. BFGS

    k=0;
    conv=0; %flag convergencia
    tstart = tic;
    switch method
        case 1
        % 1. Univariante
            d = [1;0];
            x_ = x0;
            x = x0;
    
            while k < iter_max
                grad = gf(x);
                fprintf('gf=%e\n',norm(grad));
                if norm(grad) < TOL
                    fprintf('%d steps!\n', k);
                    conv=1;
                    break;
                end
                [alpha_L, alpha_H] = passo_constante(f, x, d, a);
                alpha_k = secao_aurea(f, x, d, TOL2, alpha_L, alpha_H);
%                 alpha_k = bissecao(f, x, d, TOL2, 1e-10, alpha_L, alpha_H);
                x = x + alpha_k*d;
                x_ = [x_,x];     
                d = circshift(d,1);
                k=k+1;
            end
    
            if conv == 0
                fprintf('err\n', k);
            end
    
        case 2
        % 2. Powell
            x_ = x0;
            x = x0;

            while k < iter_max
                j = 1;
                n = 2;
                y = [[1;0],[0;1]];
                while j <= n

                    [alpha_L, alpha_H] = passo_constante(f, x, y(:,1), a);
                    alpha_k = secao_aurea(f, x, y(:,1), TOL2, alpha_L, alpha_H);
                    k=k+1;
                    x = x + alpha_k*y(:,1);
                    x_ = [x_,x];    

                    [alpha_L, alpha_H] = passo_constante(f, x, y(:,2), a);
                    alpha_k = secao_aurea(f, x, y(:,2), TOL2, alpha_L, alpha_H);
                    k=k+1;
                    x = x + alpha_k*y(:,2);
                    x_ = [x_,x];

                    d = x-x0;           
                    [alpha_L, alpha_H] = passo_constante(f, x, d, a);
                    alpha_k = secao_aurea(f, x, d, TOL2, alpha_L, alpha_H);
                    k=k+1;
                    x0 = x + alpha_k*d;
                    x=x0;
                    x_ = [x_,x];
                
                    y(:,1) = y(:,2);
                    y(:,2) = d;
            
                    j = j+1;
                end
                norm(gf(x));
                if norm(gf(x)) < TOL
                    fprintf('%d steps!\n', k);
                    conv=1;
                    break;
                end
            end
    
            if conv == 0
                fprintf('Não convergiu após %d steps\n', k);
            end
 
        case 3
        % 3. Steepest Descent
            x_ = x0;
            x = x0;           
    
            while k < iter_max
                d = -gf(x);
                fprintf('gf=%e\n',norm(d));
%                 fprintf('f=%e\n',f(x));
                if norm(d) < TOL
                    fprintf('%d steps!\n', k);
                    conv=1;
                    break;
                end
                [alpha_L, alpha_H] = passo_constante(f, x, d, a);
                alpha_k = secao_aurea(f, x, d, TOL2, alpha_L, alpha_H);
%                 alpha_k = bissecao(f, x, d, TOL2, 1e-8, alpha_L, alpha_H);
                x = x + alpha_k*d;
                x_ = [x_,x];            
                                
                k=k+1;
            end
    
            if conv == 0
                fprintf('err\n');
            end

        case 4
        % 4. FletcherReeves
            x_ = x0;
            x = x0;
            d = -gf(x);
                        
            while k < iter_max                
%                 fprintf('gf=%e\n',norm(d));
                if norm(d) < TOL
                    fprintf('%d steps! ', k);
                    conv=1;
                    break;
                end
                [alpha_L, alpha_H] = passo_constante(f, x, d, a);
                alpha_k = secao_aurea(f, x, d, TOL2, alpha_L, alpha_H);
%                 alpha_k = bissecao(f, x, d, TOL2, 1e-8, alpha_L, alpha_H);
                xk = x;
                x = x + alpha_k*d;
                xk1 = x;
                x_ = [x_,x];

                b = (gf(xk1)' * gf(xk1)) / (gf(xk)' * gf(xk));
                d = -gf(xk1) + b * d;
               
                k=k+1;
            end
    
            if conv == 0
                fprintf('err\n');
            end
        
        case 5
        % 5. NewtonRaphson
            x_ = x0;
            x = x0;
            d = -inv(H(x0)) * gf(x0);

            while k < iter_max
                fprintf('gf=%e\n',norm(gf(x))); 
                if norm(gf(x)) < TOL
                    fprintf('%d steps!', k);
                    conv=1;
                    break;
                end
                [alpha_L, alpha_H] = passo_constante(f, x, d, a);
                alpha_k = secao_aurea(f, x, d, TOL2, alpha_L, alpha_H);
%                 alpha_k = bissecao(f, x, d, TOL2, 1e-8, alpha_L, alpha_H);
                x = x + alpha_k*d;
                x_ = [x_,x];

                d = -inv(H(x)) * gf(x);      
                k=k+1;
            end
    
            if conv == 0
                fprintf('Não convergiu após %d steps', k);
            end        
        case 6
        % 6. BFGS
            x_ = x0;
            x = x0;
            S = eye(2);
            d = -S * gf(x);               

            while k < iter_max
%                 fprintf('gf=%e\n',norm(gf(x)));                
                if norm(gf(x)) < TOL
                    fprintf('%d steps! ', k);
                    conv=1;
                    break;
                end
                [alpha_L, alpha_H] = passo_constante(f, x, d, a);
                alpha_k = secao_aurea(f, x, d, TOL2, alpha_L, alpha_H);
%                 alpha_k = bissecao(f, x, d, TOL2, 1e-8, alpha_L, alpha_H);
                xk = x;
                x = x + alpha_k*d;
                xk1 = x;
                x_ = [x_,x];            

                dxk = xk1 - xk;
                dgk = gf(xk1) - gf(xk);
           
                S = S + ((dxk'*dgk + dgk'*S*dgk)*dxk*(dxk'))/((dxk'*dgk)^2) - (S*dgk*dxk' + dxk*(S*dgk)')/(dxk'*dgk);
                d = -S * gf(x);

                k=k+1;
            end
    
            if conv == 0
                fprintf('err\n');
            end

        otherwise
    
    end
    time_elap = toc(tstart);

end