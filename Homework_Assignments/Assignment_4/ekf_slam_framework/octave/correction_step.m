% Updates the belief, i. e., mu and sigma after observing landmarks, according to the sensor model
function [mu, sigma, observedLandmarks] = correction_step(mu, sigma, z, observedLandmarks)

% The employed sensor model measures the range and bearing of a landmark
% mu: [ (2N + 3) x 1 ] vector representing the state mean.

% The first 3 components of mu correspond to the current estimate of the robot pose [x; y; theta]
% The current pose estimate of the landmark with id = j is: [ mu(2*j + 2); mu(2*j + 3) ]
% sigma: [ (2N + 3) x (2N + 3) ] is the covariance matrix
% z: struct array containing the landmark observations.

% Each observation z(i) has an id z(i).id, a range z(i).range, and a bearing z(i).bearing
% The vector observedLandmarks indicates which landmarks have been observed
% at some point by the robot.
% observedLandmarks(j) is false if the landmark with id = j has never been observed before.

% Number of measurements in this time step
m = size(z, 2);
N = (size(sigma, 1) - 3) / 2; % added by Ethan: 2 * N + 3 = size(sigma, 1) => N = (size(sigma, 1) - 3) / 2

% Z: vectorized form of all measurements made in this time step: [range_1; bearing_1; range_2; bearing_2; ...; range_m; bearing_m]
% ExpectedZ: vectorized form of all expected measurements in the same form.
% They are initialized here and should be filled out in the for loop below
Z = zeros(m * 2, 1);
expectedZ = zeros(m * 2, 1);

% Iterate over the measurements and compute the H matrix
% (stacked Jacobian blocks of the measurement function)
% H will be [ (2*m) x (2N + 3) ]
H = [];

for i = 1:m
	% Get the id of the landmark corresponding to the i-th observation
	landmarkId = z(i).id; % Note: equivalent to "j" in the slides 
	% If the landmark is obeserved for the first time:
	if( observedLandmarks(landmarkId) == false )
		% TODO(done): Initialize its pose in mu based on the measurement and the current robot pose:

		%% formula:
		% mu_{j, x} = mu_{t, x} + r^i * cos( phi^i + mu_{t, theta} )
		% mu_{j, x} = mu_{t, y} + r^i * sin( phi^i + mu_{t, theta} )
		mu(3 + 2 * landmarkId - 1) = mu(1) + z(i).range * cos( z(i).bearing + mu(3) ); 
		mu(3 + 2 * landmarkId)     = mu(2) + z(i).range * sin( z(i).bearing + mu(3) );

		% Indicate in the observedLandmarks vector that this landmark has been observed
		observedLandmarks(landmarkId) = true;
	endif

	% TODO(done): Add the landmark measurement to the Z vector
	Z(i * 2 - 1) = z(i).range;
	Z(i * 2)     = z(i).bearing;

	% TODO(done): Use the current estimate of the landmark pose
	% to compute the corresponding expected measurement in expectedZ:
	delta_x = mu(3 + 2 * landmarkId - 1) - mu(1);
	delta_y = mu(3 + 2 * landmarkId)     - mu(2);
	delta   = [delta_x; delta_y];

	% check the slides for formula:  Eq.(12) ~ Eq.(14) @ Page 43, Course 05: EKF
	expectedZ(i * 2 - 1) = sqrt( delta' * delta );			 % sqrt(q)
	expectedZ(i * 2)     = atan2(delta_y, delta_x) - mu(3);  

	% TODO(done): Compute the Jacobian Hi of the measurement function h for this observation
	Hi = zeros(2, 2 * N + 3);
	q = expectedZ(i * 2 - 1)^2;
	% check the equations + comments @ Page 44, Course 05: EKF
	Hi(1, 1)                   =  -sqrt(q) * delta_x;
	Hi(1, 2)                   =  -sqrt(q) * delta_y;
	Hi(1, 2 * landmarkId + 2)  =   sqrt(q) * delta_x;
	Hi(1, 2 * landmarkId + 3)  =   sqrt(q) * delta_y;
	Hi(2, 1)                   =   delta_y;
	Hi(2, 2)                   =  -delta_x;
	Hi(2, 3)                   =  -q;
	Hi(2, 2 * landmarkId + 2)  =  -delta_y;
	Hi(2, 2 * landmarkId + 3)  =   delta_x;
	% don't forget to divide q
	Hi = 1/q * Hi;

	% Augment H with the new Hi
	H = [H; Hi];	
endfor

% TODO(done): Construct the sensor noise matrix Q
% Q is a diagonal square matrix with diagonal elements equal to 0.01
Q = eye(2 * m) * 0.01;


% (Passed) Check the sizes of each matrix before calculation
% size(sigma)
% size(H)
% size(H')
% size(Q)

% TODO(done): Compute the Kalman gain
% Note: the sizes are: [(2N+3) x (2N+3)] * [(2N+3) x 2m] * { [2m x (2N+3)] * [(2N+3) x(2N+3)] * [(2N+3) x 2m] + [2m x 2m] }
% Size of K: [(2N+3) x 2m]
K = sigma * H' * inv(H * sigma * H' + Q);

% TODO(done): Compute the difference between the expected and recorded measurements.
% Remember to normalize the bearings after subtracting!
% (hint: use the normalize_all_bearings function available in tools)
z_diff = Z - expectedZ; % z - h(mu)
z_diff = normalize_all_bearings(z_diff);

% TODO(done): Finish the correction step by computing the new mu and sigma.
% Normalize theta in the robot pose.
mu = mu + K * z_diff;
sigma = (eye(2 * N + 3) - K * H) * sigma;

end