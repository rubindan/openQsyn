%% Loop-shaping GUI
%% Overview
% Quantitative Feedback Theory (QFT) is a frequency domain robust control
% design technique, introduced by Isaac Horowitz. Open Qsyn is a Matlab based,
% object-oriented toolbox to aid QFT control synthesis.
% 
% Loop-shaping is the process in which a feedback controller is designed,
% in order to transform the output of the regulated system to have desired
% characteristics. The design process requires to make a wise use in known
% compensation networks, such that cascading them with the plant will yield
% the intended output. To make the design process easier, This graphical user
% interface (GUI) was developed.
%
% This GUI is structured to accommodate all the needs of a control engineer
% that wants to perform loop shaping, and is developed according to a 
% consensus of six steps of controllers design via the QFT method.

%% Controller
%%
%
% *     PID – opens a submenu for a PID controller design 
% 
% *     Gain – opens a submenu for a gain addition 
% 
% *     Lead – opens a submenu for a Lead compensator design
% 
% *     Lag – opens a submenu for a Lag compensator design
% 
% * 	Add Poles/Zeros – opens a submenu for a manual addition of poles and zeros 
% 
% *     Notch/anti Notch – opens a submenu for a notch/anti notch filter design
% 
% * 	Reset Controller – Resets the designed controller 
% 
% * 	Edit – enables a manual editing of the chosen controller from the
% controller's list
% 
% * 	Delete – deletes the chosen controller from the controller's list

%%     Controller Poles and zeros
%%
%
% Shows the poles and zeros of the designed controller.
%%
% *     Drag poles and zeros – enables the user to drag the poles and zeros of the controller
% *     Nichols/Bode – shows the response of the regulated system (QFT controller + plant)
% * 	Nichols plot – displays the relation between the magnitude and phase of the regulated system.
% * 	Closed Loop Bode – displays the magnitude of the closed loop system
% * 	Open Loop Bode – displays the magnitude and phase of the open loop system

%%      Options
%%
%
% * 	Save Controller to workspace 
% * 	Discrete design – converts an existing analog controller to a discrete form
% *     Load plant from workspace
% * 	Save controller to workspace
% * 	Load controller from workspace
% * 	Cancel – closes the GUI 
