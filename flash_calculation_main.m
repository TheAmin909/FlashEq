% Flash Calculation Program (No EOS, Wilson K-values)
% Solves for Vapor Fraction and Phase Compositions using Rachford-Rice equation.

clc;
clear;
close all;

% 1. Load Component Properties
[comp_names, Tc, Pc, omega] = get_ng_properties();
n_comp = length(comp_names);

fprintf('------------------------------------------------------------\n');
fprintf('           Flash Calculation Program (Wilson / Rachford-Rice)       \n');
fprintf('------------------------------------------------------------\n');

% 2. Get User Inputs
try
    T = input('Enter Temperature (Kelvin): ');
    if isempty(T), error('Temperature is required.'); end

    P = input('Enter Pressure (Bar): ');
    if isempty(P), error('Pressure is required.'); end

    fprintf('\nComponents:\n');
    for i = 1:n_comp
        fprintf('%d. %s\n', i, comp_names{i});
    end
    fprintf('\nEnter Feed Composition (z) as a vector of %d mole fractions.\n', n_comp);
    fprintf('Example: [0.7 0.1 0.05 0.03 0.02 0.01 0.01 0.01 0.05 0.02]\n');
    z = input('z = ');

    if length(z) ~= n_comp
        error('Input vector length must match number of components (%d).', n_comp);
    end

    % Ensure z is a column vector
    z = z(:);

    % Normalize composition if sum is not 1
    z_sum = sum(z);
    if abs(z_sum - 1.0) > 1e-4
        fprintf('Warning: Composition sum is %.4f. Normalizing to 1.0.\n', z_sum);
        z = z / z_sum;
    end

catch ME
    fprintf('Error in input: %s\n', ME.message);
    return;
end

% 3. Calculate K-values (Wilson Correlation)
K = calc_wilson_k(T, P, Tc, Pc, omega);

% 4. Solve Rachford-Rice for Vapor Fraction (V/F)
[VF, converged] = solve_rachford_rice(z, K);

if ~converged
    fprintf('\nWarning: Flash calculation did not converge!\n');
end

% 5. Calculate Phase Compositions
% x_i = z_i / (1 + VF * (K_i - 1))
% y_i = K_i * x_i

x = z ./ (1 + VF .* (K - 1));
y = K .* x;

% 6. Display Results
fprintf('\n------------------------------------------------------------\n');
fprintf('RESULTS\n');
fprintf('------------------------------------------------------------\n');
fprintf('Temperature: %.2f K\n', T);
fprintf('Pressure:    %.2f Bar\n', P);
fprintf('Vapor Fraction (V/F): %.6f\n', VF);
fprintf('------------------------------------------------------------\n');
fprintf('%-15s %-10s %-10s %-10s %-10s\n', 'Component', 'z (Feed)', 'K-value', 'x (Liq)', 'y (Vap)');
fprintf('------------------------------------------------------------\n');

for i = 1:n_comp
    fprintf('%-15s %-10.4f %-10.4f %-10.4f %-10.4f\n', ...
        comp_names{i}, z(i), K(i), x(i), y(i));
end
fprintf('------------------------------------------------------------\n');
fprintf('Sum:            %-10.4f %-10s %-10.4f %-10.4f\n', sum(z), '', sum(x), sum(y));
