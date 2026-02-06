# Flash Calculation Program (Wilson / Rachford-Rice)

This MATLAB project performs a flash calculation to determine the Vapor Fraction (V/F) and phase compositions (liquid and vapor) of a natural gas mixture at a specified Temperature and Pressure.

It uses the **Wilson Correlation** to estimate equilibrium K-values and solves the **Rachford-Rice Equation** to find the vapor fraction.

## Files

- `flash_calculation_main.m`: The main script to run the program. It handles user input, orchestrates calculations, and displays results.
- `get_ng_properties.m`: Returns physical properties (Tc, Pc, Omega) for 10 common natural gas components (C1-C6, N2, CO2).
- `calc_wilson_k.m`: Calculates K-values using the Wilson correlation based on T, P, and component properties.
- `solve_rachford_rice.m`: Solves the Rachford-Rice equation numerically (using Newton-Raphson) to find the Vapor Fraction.

## Usage

1. Open MATLAB and navigate to the project directory.
2. Run the main script:
   ```matlab
   flash_calculation_main
   ```
3. Follow the prompts to enter:
   - **Temperature**: In Kelvin
   - **Pressure**: In Bar
   - **Feed Composition (z)**: A vector of mole fractions for the 10 components.

### Components Order
The feed composition vector `z` must correspond to the following order:
1. Methane (C1)
2. Ethane (C2)
3. Propane (C3)
4. i-Butane (iC4)
5. n-Butane (nC4)
6. i-Pentane (iC5)
7. n-Pentane (nC5)
8. n-Hexane (C6)
9. Nitrogen (N2)
10. Carbon Dioxide (CO2)

## Example

**Input:**
```
Temperature (Kelvin): 300
Pressure (Bar): 20
Feed Composition (z): [0.7 0.1 0.05 0.03 0.02 0.01 0.01 0.01 0.05 0.02]
```

**Output:**
The program will display the Vapor Fraction and the composition of the Liquid (x) and Vapor (y) phases.
