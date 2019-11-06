function [p] = v2t(M)
%  Transform homogeneous transformation matrix M robot pose vector p
% p: robot pose vector;
%    p = (x, y, theta)^T   
% M: homogeneous transformation matrix t
%    M = ( [R,                      t];
%          [0,                      1] )
%      = ( [cos(theta), sin(theta), x];
%          [sin(theta), cos(theta), y];
%          [0,          0,          1] )

p = zeros(3, 1)

p(1) = M(1, 3)
p(2) = M(2, 3)
p(3) = atan2( M(2, 1), M(1, 1) ) % theta = atan2( sin(theta), cos(theta) )

end