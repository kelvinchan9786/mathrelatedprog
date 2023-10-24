clear
P = [1 0 0; 0.1 0.6 0.3 ; 0 0 1]

%check whether P is proper transition matrix
if sum(P, 2) == ones(length(P))
else
    error('P is not proper transition Markov chain')
end
absorption = []

%search where absorption state and transient state is
for u1 = 1:size(P, 1)
    for u2 = 1:size(P, 2)
        if P(u1, u2) == 1 & u1 == u2
            absorption = cat(1, absorption, [u1]);
        end
    end
end
absorption
state = repmat(1:size(P, 1), 1, 1);
transient = setdiff(state, absorption)

%find Q, R
Q = [];
R = [];
for u3 = 1:size(transient, 1)
    for u4 = 1:size(transient, 1)
        Q(u3, u4) = P(transient(u3), transient(u4));
    end
end

for u5 = 1:size(transient, 1)
    for u6 = 1:size(absorption, 1)
        R(u5, u6) = P(transient(u5), absorption(u6));
    end
end

%evaluate U
U = inv(eye(size(transient, 1), size(transient, 1)) - Q) * R

%clear variable
clear absorption ans state transient u1 u2 u3 u4 u5 u6