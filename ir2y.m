function [y, pipe_percentage] = ir2y(ir)
%% Converts IR reading from the top to the distance in meters from the bottom
% Inputs:
%  ~ ir: the IR reading from time of flight sensor [mm]
% Outputs:
%  ~ y: the distance in [m] from the bottom to the ball
%  ~ pipe_percentage: on a scale of 0 (bottom of pipe) to 1 (top of pipe)
%  where is the ball
%
% Created by:  Kyle Naddeo 2/2/2022
% Modified by: YOUR NAME and DATE

%% Parameters
ir_bottom = 956;  % IR reading when ball is at bottom of pipe
ir_top    = 64;  % top of pipe
y_top     = 0.9144; % Ball at top of the pipe [m]

%% Bound the IR reading and send error message 
% (remeber the IR values are inverted ie small values == large height and large values == small height)

%% Set
pipe_percentage = (ir - ir_top)/(ir_bottom - ir_top); %Calculates where you are at in the pipe with sensor
y = y_top * pipe_percentage; %This is where you are actually at in the pipe in units m

