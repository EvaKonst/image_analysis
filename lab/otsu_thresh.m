function [T] = otsu_thresh(counts)

num = numel(counts);

%turn into a double column vector
counts = double( counts(:) );

counts = counts / sum(counts);
cum = cumsum(counts);
m = cumsum(counts .* (1:num)');
m_t = m(end);

sigma = (m_t * cum - m).^2 ./ (cum .* (1 - cum));

%find the location of sigma's maximum value and average the neighborhood
maxsig = max(sigma);

idx = mean(find(sigma == maxsig));
%threshold should be between 0 and 1
T = (idx - 1) / (num - 1);

end
