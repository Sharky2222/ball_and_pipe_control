function [distance, pwm, target, deadpan] = read_data(device)
%% Reads data sent back from Ball and Pipe system
% Inputs:
%  ~ device: serialport object controlling the real world system
% Outputs:
%  ~ distance: the IR reading from the time of flight sensor
%  ~ pwm: the PWM from the manual knob of the system (NOT THE SAME AS THE
%  PWM YOU MAY SET THROUGH SERIAL COMMUNICATION)
%  ~ target: the desired height of the ball set by the manual knob of the
%  system
%  ~ deadpan: the time delay after an action set by the manual knob of the
%  system
%
% Created by:  Kyle Naddeo 1/3/2022
% Modified by: YOUR NAME and DATE

%% Ask nicely for data
% use the serialport() command options to write the correct letter to the
% system (Hint: the letters are in the spec sheet)
%write(device, "H", "single")
%write(device, "S", "string")

%writeline(device, "H")
write(device, "S","string")

%% Read data
% use the serialport() command options to read the response
%info = readline(device)
pause(.1);
info_raw = read(device, 20, "String"); %Reads in Raw data
info = split(extractAfter(info_raw,':'),',');
%% Translate
% translate the response to 4 doubles using str2double() and
% extractBetween() (Hint: the response is in the spec sheet)
distance   = str2double(info{1}); % cell 1 of info is distance and so on
pwm        = str2double(info{2});
target     = str2double(info{3})
deadpan    = str2double(info{4});

end