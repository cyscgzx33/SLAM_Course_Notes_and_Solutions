function [mu, sigma] = prediction_step(mu, sigma, u)
% Updates the belief concerning the robot pose according to the motion model,
% mu: 2N+3 x 1 vector representing the state mean
% sigma: 2N+3 x 2N+3 covariance matrix
% u: odometry reading (r1, t, r2)
% Use u.r1, u.t, and u.r2 to access the rotation and translation values

% define some tmp variables
mu_3_prior = mu(3);

% TODO(done): Compute the new mu based on the noise-free (odometry-based) motion model
% Remember to normalize theta after the update (hint: use the function normalize_angle available in tools)
mu(1) = mu(1) + u.t * cos( mu(3) + u.r1 );
mu(2) = mu(2) + u.t * sin( mu(3) + u.r1 );
mu(3) = mu(3) + u.r1 + u.r2;

% TODO(done): Compute the 3x3 Jacobian Gx of the motion model
G_partial_x = zeros(3, 3);
G_partial_x(1, 3) = -u.t * sin( mu_3_prior + u.r1 );
G_partial_x(2, 3) =  u.t * cos( mu_3_prior + u.r1 );

% TODO(done): Construct the full Jacobian G
G = zeros( size(sigma) );
G(1:3, 1:3) = eye(3) + G_partial_x;

% Motion noise
motionNoise = 0.1;
R3 = [ [motionNoise, 0,           0             ]; 
       [0,           motionNoise, 0             ]; 
       [0,           0,           motionNoise/10] ];
R = zeros(size(sigma,1));
R(1:3,1:3) = R3; % a good practice to specifically modify a small part within a large matrix 

% TODO(done): Compute the predicted sigma after incorporating the motion
sigma = G * sigma * G' + R;

end