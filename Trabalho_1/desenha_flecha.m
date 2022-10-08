function [] = desenha_flecha(A,B,col)
    quiver(A(1), A(2), B(1)-A(1), B(2)-A(2), 'LineWidth', 2, 'Color', col);
end