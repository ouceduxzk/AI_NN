function G = configuration_goodness(rbm_w, visible_state, hidden_state)
% <rbm_w> is a matrix of size <number of hidden units> by <number of visible units>
% <visible_state> is a binary matrix of size <number of visible units> by <number of configurations that we're handling in parallel>.
% <hidden_state> is a binary matrix of size <number of hidden units> by <number of configurations that we're handling in parallel>.
% This returns a scalar: the mean over cases of the goodness (negative energy) of the described configurations.

% in the lecture 12-1 , -∂E/∂Wij = si*sj; so -E = h * v' .* W; (scalar production with the weighs);
t = sum(sum(hidden_state*visible_state' .* rbm_w));
G = t/size(visible_state,2); % mean 


end
