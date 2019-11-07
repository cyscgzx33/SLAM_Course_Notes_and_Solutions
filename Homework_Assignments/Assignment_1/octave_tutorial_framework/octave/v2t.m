function [M] = v2t(p)
%  Transform robot pose vector p to homogeneous transformation matrix M
% p: robot pose vector;
%    p = (x, y, theta)^T   
% M: homogeneous transformation matrix t
%    M = ( [R,                      t];
%          [0,                      1] )
%      = ( [cos(theta), sin(theta), x];
%          [sin(theta), cos(theta), y];
%          [0,          0,          1] )

M = eye(3);

M(1, 1) = cos( p(3) );
M(1, 2) = -sin( p(3) );
M(1, 3) = p(1);
M(2, 1) = sin( p(3) );
M(2, 2) = cos( p(3) );
M(2, 3) = p(2);

end