function [VF, converged] = solve_rachford_rice(z, K)
% SOLVE_RACHFORD_RICE Solves the Rachford-Rice equation for Vapor Fraction.
%
%   VF = solve_rachford_rice(z, K)
%
%   Inputs:
%       z: Feed Composition (mole fractions, vector)
%       K: Equilibrium K-values (vector)
%
%   Output:
%       VF: Vapor Fraction (molar ratio V/F)
%       converged: Boolean flag for convergence

    % Constants
    tol = 1e-9;
    max_iter = 100;

    % Pre-calculate K-1
    K_minus_1 = K - 1;

    % 1. Check for single phase liquid (Bubble Point limit)
    % f(0) = sum(z_i * (K_i - 1))
    f0 = sum(z .* K_minus_1);
    if f0 <= 0
        VF = 0;
        converged = true;
        return;
    end

    % 2. Check for single phase vapor (Dew Point limit)
    % f(1) = sum(z_i * (K_i - 1) / K_i)
    f1 = sum(z .* K_minus_1 ./ K);
    if f1 >= 0
        VF = 1;
        converged = true;
        return;
    end

    % 3. Two-phase region: Solve using Newton-Raphson
    % Function: f(VF) = sum( z_i * (K_i - 1) / (1 + VF * (K_i - 1)) ) = 0
    % Derivative: f'(VF) = - sum( z_i * (K_i - 1)^2 / (1 + VF * (K_i - 1))^2 )

    VF = 0.5; % Initial guess
    converged = false;

    for i = 1:max_iter
        % Calculate denominator for each component
        denom = 1 + VF .* K_minus_1;

        % Calculate function value
        f_val = sum(z .* K_minus_1 ./ denom);

        % Calculate derivative value
        df_val = -sum(z .* (K_minus_1.^2) ./ (denom.^2));

        % Check convergence
        if abs(f_val) < tol
            converged = true;
            return;
        end

        % Newton step
        delta_VF = f_val / df_val;
        VF_next = VF - delta_VF;

        % Damping / Bound handling
        % If the step jumps out of [0, 1], bring it back.
        if VF_next <= 0
            VF_next = VF / 2; % Retract towards 0
        elseif VF_next >= 1
            VF_next = (1 + VF) / 2; % Retract towards 1
        end

        % Update VF
        if abs(VF_next - VF) < tol
             VF = VF_next;
             converged = true;
             return;
        end
        VF = VF_next;
    end

    if ~converged
        warning('Rachford-Rice solver did not converge. Result may be inaccurate.');
    end

end
