function K = calc_wilson_k(T, P, Tc, Pc, omega)
% CALC_WILSON_K Calculates K-values using the Wilson correlation.
%
%   K = calc_wilson_k(T, P, Tc, Pc, omega)
%
%   Inputs:
%       T: System Temperature (Kelvin)
%       P: System Pressure (Bar)
%       Tc: Critical Temperature of components (vector, Kelvin)
%       Pc: Critical Pressure of components (vector, Bar)
%       omega: Acentric Factor of components (vector)
%
%   Output:
%       K: Equilibrium K-values (vector)
%
%   Formula:
%       K_i = (P_ci / P) * exp(5.37 * (1 + omega_i) * (1 - T_ci / T))

    % Ensure inputs are column vectors for consistency if needed,
    % but simple element-wise operations should work if dimensions match.

    % Calculation
    % Note: P and Pc must be in the same units (Bar).
    %       T and Tc must be in absolute units (Kelvin).

    exponent_term = 5.37 .* (1 + omega) .* (1 - Tc ./ T);
    K = (Pc ./ P) .* exp(exponent_term);

end
