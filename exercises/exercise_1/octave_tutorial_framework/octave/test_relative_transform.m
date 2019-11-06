% define PI
PI = 3.1415926;

% create a point p1
p1 = [2, 1, PI / 6];
% decompose its translation part and rotation part
p1_t = [2, 1, 0];
p1_r = [0, 0, PI / 6];
% obtain the corresponding homogeneous transformation form
M1_t = v2t(p1_t)
M1_r = v2t(p1_r)
% obtain the inverse transformation, including translation and rotation parts
p1_t_inv = -p1_t
p1_r_inv = -p1_r
% obtain the corresponding homogeneous transformation form
M1_t_inv = v2t(p1_t_inv)
M1_r_inv = v2t(p1_r_inv)


% create a point p2
p2 = [1, 5, PI / 4];
% decompose its translation part and rotation part
p2_t = [1, 5, 0];
p2_r = [0, 0, PI / 4];
% obtain the corresponding homogeneous transformation form
M2_t = v2t(p2_t)
M2_r = v2t(p2_r)
% obtain the inverse transformation, including translation and rotation parts
p2_t_inv = -p2_t
p2_r_inv = -p2_r
% obtain the corresponding homogeneous transformation form
M2_t_inv = v2t(p2_t_inv)
M2_r_inv = v2t(p2_r_inv)

%% Test stage
% init a test vector at origin
v_test = [0;0;1]

% firstly, transform v_test by: M1 = M1_t * M1_r
M1 = M1_t * M1_r
v_1st_trans = M1 * v_test

% secondly, transform v_1st_trans by: M1_inv = M1_r_inv * M1_t_inv
M1_inv = M1_r_inv * M1_t_inv
v_2nd_trans = M1_inv * v_1st_trans

% thirdly, transform v_2nd_trans by : M2 = M2_t * M2_r
M2 = M2_t * M2_r
v_3rd_trans = M2 * v_2nd_trans

%% Relative information extraction
% finally, let extract the relative transformation from p1 to p2
% since final M = M2 * M1_inv * M1
% the relative homogeneous transformation matrix should be:
M_rel_p1_to_p2 = M2 * M1_inv
p_rel_p1_to_p2 = t2v(M_rel_p1_to_p2)

% ultimately, check if this validation is solid or not, i.e., if p2 == v_final 
v_final = t2v( M_rel_p1_to_p2 * v2t(p1) )
p2