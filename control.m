clear all; close all; clc;

dt = 1e-5;
finish_time = 1;
start = [0; 0; 0];
target = [0.1; 0.1; 0.1];

ref = traj_gen(start, target, dt, finish_time);

data = sim('control_model.slx', 'FixedStep', num2str(dt), 'StartTime', '0', 'StopTime', num2str(finish_time));

figure;
ax1 = subplot(1,2,1);
ax2 = subplot(1,2,2);
animate(data, ax1, ax2);