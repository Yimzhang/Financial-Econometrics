% a) Generate X and Y
X = (1:50)';
e = normrnd(0,1,50,1);
Y = 1 + 2*X + e;

% Add a column of ones to X for the intercept term
X = [ones(50,1), X]; 

% Estimate the coefficients
beta = (X'*X)\(X'*Y); % estimate the coefficients

disp(['Estimates of coefficients: ', num2str(beta')]);

% c) Initialize the matrix B to store coefficients
B = zeros(100,2);
B(1,:) = beta';

% d) Run the simulation 100 times
for i = 2:100
    % Generate X and Y
    X = (1:50)';
    e = normrnd(0,1,50,1);
    Y = 1 + 2*X + e;

    % Add a column of ones to X for the intercept term
    X = [ones(50,1), X]; 

    % Estimate the coefficients
    beta = (X'*X)\(X'*Y); 

    % Store the coefficients in the matrix B
    B(i,:) = beta';
end

% e) Compute the mean and standard deviation of the coefficients across the rows of B
B_mean = mean(B);
B_std = std(B);

disp(['Mean of coefficients: ', num2str(B_mean)]);
disp(['Standard deviation of coefficients: ', num2str(B_std)]);

