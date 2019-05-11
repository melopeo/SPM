function y = gen_arnoldi_for_power_of_a_matrix_times_a_vector(Y, max_iter, v, p, tol)
% y = gen_arnoldi_for_power_of_a_matrix_times_a_vector(Y, max_iter, v, p, tol)
%
% Compute an M-orthogonal basis of the generalized Krylov subspace
% K_k(P, Q, v) = {v, P \ (Q v), ..., (P \ Q)^k v)}
% well as the generalized Arnoldi decomposition of P and Q.
% The optional argument symm can be either 0 (use Arnoldi
% algorithm) or 1 (use Lanczos-like recursion).
% 
% This is a modified version of the original shared by Massimiliano Fasi:
% - Weighted geometric mean of large-scale matrices: numerical analysis and algorithms 
% - http://amslaurea.unibo.it/8274/
% 
% Computing the weighted geometric mean of two large-scale matrices and its inverse times a vector
% - http://eprints.ma.man.ac.uk/2474/

n        = size(Y, 1);
n_reorth = 2;
itol     = 1e-15;

if norm(v) == 0
    y = 0;
    return
end

M        = eye(n);
X        = eye(n);
delta    = 1;
symm     = 1;

% Choose between Arnoldi and Lanczos
if (symm == 1)
    k_max = 4;
else
    k_max = n;
end

k1       = max_iter + 1;
V        = zeros(n, k1);
H        = zeros(k1, max_iter);
D        = zeros(n, max_iter);

% First column of V
V(:, 1) = v/sqrt(v'*M*v);

for j = 1:max_iter
    j1 = j + 1;
    it = 0;
    t  = 0;
    V(:, j1) = Y*V(:, j);
    i_min    = max (1, j - k_max);
    while (it < n_reorth)
        it = it + 1;
        for i = i_min:j
            t        = V(:, i)'*M*V(:, j1);
            H(i, j)  = H(i, j) + t;
            V(:, j1) = V(:, j1) - t * V(:, i);
        end
    t = sqrt (V(:, j1)'*M*V(:, j1));
    end
    H(j1, j) = t;

    % Normalize
    if (t > itol)
        V(:, j1) = V(:, j1)/t;
    end
   
    fH      = power_of_a_matrix(H(1:j, 1:j), p);
    D(:, j) = V(:, 1:j)*(fH(:,1)*sqrt(v'*M*v));

    y = D(:, j);
    % Estimate the residual during last step and return current y
    if (j >= delta + 1)
        dt = norm(D(:, j) - D(:, j - delta))/norm(D(:, j - delta));
        if (abs (dt/(1 - dt)) <= tol)
            y = D(:, j);
            return
        end
    end
end