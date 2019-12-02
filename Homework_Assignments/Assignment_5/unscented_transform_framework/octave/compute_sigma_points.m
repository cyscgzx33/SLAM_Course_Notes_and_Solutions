function [sigma_points, w_m, w_c] = compute_sigma_points(mu, sigma, lambda, alpha, beta)
% This function samples (2n + 1) sigma points from the distribution given by mu and sigma
% according to the unscented transform, where n is the dimensionality of mu.
% Each column of sigma_points should represent one sigma point
% i.e. sigma_points has a dimensionality of (n x 2n + 1).
% The corresponding weights w_m and w_c of the points are computed using lambda, alpha, and beta:
% w_m = [w_m_0, ..., w_m_2n], w_c = [w_c_0, ..., w_c_2n], each of size (1 x 2n + 1)
% w_m & w_c are later used to recover the mean and covariance respectively.

n = length(mu);
sigma_points = zeros(n, 2 * n  + 1);

% TODO(done): compute all sigma points
sigma_points(:, 1) = mu;
% comstruct a helper matrix for calculating sigma points
helper_matrix = sqrtm( (n + lambda) * sigma );

for i = 1 : n
    sigma_points(:, 1 + i)     =  mu + helper_matrix(:, i);
    sigma_points(:, 1 + i + n) =  mu - helper_matrix(:, i + n);
endfor

% TODO(done): compute weight vectors w_m and w_c
w_m = zeros(n, 2 * n + 1);
w_c = zeros(n, 2 * n + 1);
w_m(1) = lambda / (n + lambda);
w_c(1) = w_m(1) + (1 - alpha^2 + beta);

for i = 1 : (2*n)
    w_m(i + 1) = 1 / ( 2 * (n + lambda) );
    w_c(i + 1) = 1 / ( 2 * (n + lambda) );
endfor

end