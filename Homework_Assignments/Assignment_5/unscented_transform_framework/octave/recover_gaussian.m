function [mu, sigma] = recover_gaussian(sigma_points, w_m, w_c)
% This function computes the recovered Gaussian distribution (mu and sigma)
% given the sigma points w/ size (n x 2n + 1) and their weights w_m and w_c:
% w_m = [w_m_0, ..., w_m_2n], w_c = [w_c_0, ..., w_c_2n].
% The weight vectors are each (1 x 2n + 1) in size,
% where n is the dimensionality of the distribution.

% Try to vectorize your operations as much as possible
n = size(sigma_points, 1);

% TODO(done): compute mu
mu = zeros(n, 1);
for i = 1 : (2 * n + 1)
    mu = mu + w_m(i) * sigma_points(:, i);
endfor

% TODO(done): compute sigma
sigma = zeros(n, n);
for i = 1 : (2 * n + 1)
    sigma = sigma + w_c(i) * (sigma_points(:, i) - mu) * (sigma_points(:, i) - mu)';
endfor

end