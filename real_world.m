% A MATLAB script to control Rowans Systems & Control Floating Ball 
% Apparatus designed by Mario Leone, Karl Dyer and Michelle Frolio. 
% The current control system is a PID controller.
%
% Created by Kyle Naddeo, Mon Jan 3 11:19:49 EST 
% Modified by YOUR NAME AND DATE

%% Start fresh
close all; clc; clear device;

%% Connect to device
device = serialport("COM13", 19200) % open serial communication in the proper COM port

%% Parameters
target      = 0.2;   % Desired height of the ball [m]
target2 = 0; %stores the trash data from sensor to prevent wrong data reading for target
sample_rate = 0.01;  % Amount of time between control actions [s]

%% Give an initial burst to lift ball and keep in air
set_pwm(device,4095); % Initial burst to pick up ball (LOOK AT DC
% PLOT)
pause(3) % Wait 3 seconds
write(device,"H","string") %Turns the hold mode on for the system
pause(1)
% the pipe

%% Initialize variables
action      = 0;
error       = 0; 
error_sum   = 0;
flush(device); %cleans the old data out of the system to read correctly
%% Feedback loop
while true
    %% Read current height
    [distance, pwm, target2, deadpan] = read_data(device);
    y = ir2y(distance) % Convert from IR reading to distance from bottom [m]
    
    %% Calculate errors for PID controller
    error_prev = error;             % D used for derivative
    error      = target - y       % P 
    error_sum  = error + error_sum; % I, keeps track of the total error
    
    %% Control
    % y is smaller closer half to sensor, larger at bottom
    if error ~=0 %prevents the error from reading 0 and sending 0 value which causes the ball to stutter
        %negative becuase you want the ball to increase speed when below target, and decrease speed above target   
        KP = -error*3000+1500; %3400+1500 general control for the system
        KI = -16*(error_sum); %20 controls going up speed 
        KD = -8000*(error-error_prev) %7060 controls going down speeds 
    end
    action = floor(KP+KI+KD) %+ KD% + KI  %PD control works with red ball 8.3
    %error - error_prev because the system is affected by error only for derivative
    %kd is determined off of sampling rate which is the constant
    set_pwm(device,action); % Implement action
    % Wait for next sample
    pause(sample_rate) %changed sampling time to increase accuracy and performace
    
end

