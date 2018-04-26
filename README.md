# phantom-control

Control of an animated PHANToM Premium 1.5 haptic robotic device. Although it is animated, it includes the full dynamical model of the device and hence it can be applied to the real one.

### GUI

![Alt Text](./Figures/Animation_1.0.PNG?raw=true)

### Results for some given trajectory

##### Reference and Actual Angles

![Alt Text](./Figures/Angles_1.0.PNG?raw=true)

##### Tracking Error

![Alt Text](./Figures/Error_1.0.PNG?raw=true)

##### Controller Force Outputs along Axes

![Alt Text](./Figures/Force_1.0.PNG?raw=true)

## How to Use

For the model to work, you need MATLAB 2015b,

Also the model settings should be set as follows:

* Solver:
Fixed Step, ode4, Step Size: 1e-5

* Data Import/Export:
Input should be ticked and it should be set to "ref" only.
Output Format should be set to "Dataset" and "Limit data points to last" should be unticked.

Other than these, please do not change anything for plain usage.

## How does it work

* To make the project work, just run control_GUI.m, it will open up a Graphical User Interface.

* The GUI will run the model with the initial parameters, you can animate and plot data right away.

* If you want to check for other configurations, just play with the parameters, hit "Simulate" first and then you can animate and plot with your configurations.

NOTE: Do not change the "time step size". The model only works with a step size of 1e-5.