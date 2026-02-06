function [names, Tc, Pc, omega] = get_ng_properties()
% GET_NG_PROPERTIES Returns properties for standard Natural Gas components.
%
%   Output:
%       names: Cell array of component names
%       Tc: Vector of critical temperatures (Kelvin)
%       Pc: Vector of critical pressures (Bar)
%       omega: Vector of acentric factors
%
%   Components included:
%       1. Methane (C1)
%       2. Ethane (C2)
%       3. Propane (C3)
%       4. i-Butane (iC4)
%       5. n-Butane (nC4)
%       6. i-Pentane (iC5)
%       7. n-Pentane (nC5)
%       8. n-Hexane (C6)
%       9. Nitrogen (N2)
%       10. Carbon Dioxide (CO2)

    names = {'Methane (C1)'; 'Ethane (C2)'; 'Propane (C3)'; ...
             'i-Butane (iC4)'; 'n-Butane (nC4)'; ...
             'i-Pentane (iC5)'; 'n-Pentane (nC5)'; ...
             'n-Hexane (C6)'; 'Nitrogen (N2)'; 'Carbon Dioxide (CO2)'};

    % Critical Temperature in Kelvin
    Tc = [190.56; 305.32; 369.83; ...
          408.14; 425.12; ...
          460.39; 469.7; ...
          507.6; 126.2; 304.13];

    % Critical Pressure in Bar
    Pc = [45.99; 48.72; 42.48; ...
          36.48; 37.96; ...
          33.81; 33.70; ...
          30.25; 33.98; 73.77];

    % Acentric Factor (omega)
    omega = [0.0115; 0.0995; 0.1523; ...
             0.1852; 0.2002; ...
             0.2275; 0.2515; ...
             0.3013; 0.0377; 0.2239];
end
