# Cloth Simulation using Verlet Integration

This is a cloth simulation built using Verlet Integration in Processing (Java). The simulation models a grid of particles connected by springs, simulating a piece of cloth that responds to gravity, wind, and user interactions. The cloth can be manipulated by removing springs (via mouse interaction) and applying wind forces (via keyboard input).

## Features
- **Verlet Integration**: A physics-based approach for simulating cloth movement.
- **Gravity and Wind**: The cloth responds to gravity and wind forces.
- **User Interaction**: Click on springs to remove them from the simulation and press the "W" key to apply wind forces to the cloth.
- **Particle System**: A grid of particles connected by springs, simulating a cloth's flexibility and motion.

## Demo
![Cloth Simulation](demo.gif) 

## Installation & Usage
### Requirements
- [Processing](https://processing.org/) (Java Mode)

### Running the Simulation
1. Download or clone this repository:
   ```sh
   git clone https://github.com/prodev717/cloth-simulation.git
   ```
2. Open the `cloth_simulation.pde` file in Processing.
3. Click the **Run** button to start the simulation.

## Code Explanation
### Core Components
- **`Particle` Class**: Represents an individual particle in the simulation. Each particle has a position (`pos`), a previous position (`prepos`), and a state indicating whether it's locked. The class handles displaying, updating, and moving particles based on forces like gravity and damping.
- **`Spring` Class**: Represents a spring connecting two particles. The spring applies forces to maintain the distance between the particles, adjusting their positions if the spring is stretched or compressed.
- **`Verlet Integration`**: The particle positions are updated using Verlet Integration, a method that calculates the new position of each particle based on its previous position and applied forces (e.g., gravity, wind).
- **`setup()`**: Initializes the simulation environment, creates the grid of particles, and sets up the springs connecting adjacent particles. The first row of particles is locked, which means they do not move, simulating the top edge of the cloth.
- **`draw()`**: Continuously updates the simulation by updating the positions of particles and springs and then rendering them on the canvas. This is called on every frame, making the simulation interactive and animated.

### Key Functions
- **`update()`** (in `Particle`): Updates the position of each particle based on its velocity, damping, and forces like gravity and wind. The particle's velocity is derived from its previous and current position.
- **`display()`** (in `Particle`): Renders the particle as a small circle on the screen.
- **`update()`** (in `Spring`): Updates the position of the particles connected by the spring. It calculates the distance between the two particles and applies forces to maintain the spring length. This helps simulate the elasticity of the cloth.
- **`display()`** (in `Spring`): Renders the spring as a line between two connected particles.
- **`mousePressed()`**: When the mouse is clicked, this function removes springs that are close to the mouse position. It creates interactive behavior, allowing the user to tear the cloth in the simulation.
- **`keyPressed()`**: Applies wind forces to the cloth when the "W" key is pressed. This causes a random force to be applied to all unlocked particles in the cloth.
- **`keyReleased()`**: Stops applying wind forces and generates a new random wind direction when the "W" key is released.

## Customization
You can modify the following parameters to tweak the cloth simulation:
- **Particle Grid Size**: Change `row` and `column` values to adjust the number of particles in the grid. Increasing these values will make the simulation more detailed, but also computationally heavier.
  - Example:
    ```java
    int row = 30;   // Increase the number of rows
    int column = 30; // Increase the number of columns
    ```
- **Spring Length**: Adjust `len` to change the default length of the springs between particles. Smaller values create a tighter cloth simulation, while larger values make the cloth more loose.
  - Example:
    ```java
    int len = 30;  // Change spring length
    ```
- **Gravity**: Modify the gravity vector (`GRAVITY`) to change the gravitational force applied to the particles. For example, you can make gravity stronger or weaker by changing the y-value.
  - Example:
    ```java
    PVector GRAVITY = new PVector(0, 0.3); // Increase gravity
    ```
- **Wind Strength**: Wind is applied randomly to the particles when the "W" key is pressed. You can adjust the random wind range by changing the `random(-2, 2)` values inside the `keyPressed()` function.
  - Example:
    ```java
    WIND = new PVector(random(-5, 5), random(-5, 5)); // Increase wind range
    ```
- **Damping**: Modify `DAMPING` to control how much the movement of particles is slowed down over time. A value closer to 1.0 will result in slower decay of motion, while a value closer to 0 will make the cloth more rigid.
  - Example:
    ```java
    float DAMPING = 0.95;  // Reduce damping for slower motion
    ```
By adjusting these parameters, you can create different cloth behaviors, from light and airy fabrics to tight, rigid materials.


## License
This project is open-source under the [MIT License](LICENSE).
