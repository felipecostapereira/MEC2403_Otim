function alpha_k = bissecao(f, x0, d, TOL, epsilon, alpha_L, alpha_H)    
    b = (alpha_H-alpha_L);
    while norm (b) > TOL
        alpha_M = (alpha_L+alpha_H)/2;

        f1 = f(x0 + (alpha_M - epsilon) * d);
        f2 = f(x0 + (alpha_M + epsilon) * d);

        %  Se ??1 > ??2 ? descartar a metade da esquerda, ou seja, fazer: ???? = ???? ; caso contr\'ario, fazer: ???? = ???? ;
        if f1 > f2
            alpha_L = alpha_M;
        else
            alpha_H = alpha_M;
        end
        b = (alpha_H-alpha_L);
    end
    alpha_k = (alpha_L+alpha_H)/2;
end

% function alpha_k = bissecao(f, x0, d, TOL, epsilon, alpha_L, alpha_H)    
%     b = (alpha_H-alpha_L); %tamanho do intervalo
% 
%     while norm (b) > TOL
%         alpha_M = (alpha_L+alpha_H)/2;
% %         fprintf('a_M=%0.4f a_L=%0.4f a_H=%0.4f ', alpha_M, alpha_L, alpha_H);
% 
%         f1 = f(x0 + (alpha_M - epsilon) * d);
%         f2 = f(x0 + (alpha_M + epsilon) * d);
% %         fprintf('f1=%0.10f,f2=%0.10f,b=%0.4f ', f1, f2, b);
% 
%         %  Se ??1 > ??2 ? descartar a metade da esquerda, ou seja, fazer: ???? = ???? ; caso contr\'ario, fazer: ???? = ???? ;
%         if f1 > f2
% %             fprintf('f1 > f2\n')
%             if alpha_M > 0
%                 alpha_L = alpha_M;
%             else
%                 alpha_H = alpha_M;
%             end          
%         else
% %             fprintf('f2 > f1\n')
%             if alpha_M > 0
%                 alpha_H = alpha_M;
%             else
%                 alpha_L = alpha_M;
%             end
%         end
%         b = (alpha_H-alpha_L);
% 
%     end
%     alpha_k = (alpha_L+alpha_H)/2;
% %     fprintf('a_k=%0.5f\n', alpha_k);
% end