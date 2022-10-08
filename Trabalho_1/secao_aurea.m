function alpha_k = secao_aurea (f, x0, d, TOL, alpha_L, alpha_H)
    ra = (sqrt(5)-1)/2;

    b = norm(alpha_L-alpha_H); %tamanho do intervalo
    alpha_E = alpha_L + (1-ra)*b;
    alpha_D = alpha_L + ra*b;
    f1 = f(x0 + alpha_E * d);
    f2 = f(x0 + alpha_D * d);

    while b > TOL
        %  Se ??1 > ??2, descarta o intervalo: [????,????] Se ??2 > ??1, descarta o intervalo: [????, ????]
        if f1 > f2
            % fprintf('f1 > f2, descarta [L-E], desce pra dir\n')
            alpha_L = alpha_E;
            alpha_E = alpha_D;
            b = norm(alpha_L-alpha_H);
            alpha_D = alpha_L + ra*b;

            % avaliar menos vezes a funcao f
            f1 = f2;
            f2 = f(x0 + alpha_D * d);
        else
            % fprintf('f1 < f2, descarta [D-U], desce pra esq\n')
            alpha_H = alpha_D;
            alpha_D = alpha_E;
            b = norm(alpha_L-alpha_H);
            alpha_E = alpha_L + (1-ra)*b;

            % avaliar menos vezes a funcao f
            f2 = f1;
            f1 = f(x0 + alpha_E * d);

        end
    end
    alpha_k = (alpha_L+alpha_H)/2;
end