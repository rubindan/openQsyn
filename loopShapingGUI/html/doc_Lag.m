%% Lag
% Lag system is used to increase the gain in lower frequencies in order to
% receive larger error and stiffness coefficients, which yields a higher 
% gain at lower frequencies. Notice that using this compensator will lower
% the phase at all frequencies. The main problem of this is that it pushes
% the phase curve towards the crossover frequency (i.e. 0 [db] ), thus lowers
% the phase margin $$\varphi_m$. 
%
% This submenu enables the user to choose the desired gain decrease at a 
% given frequency, and see the resulted magnitude and phase of the 
% compensator via bode plot. Once the user is satisfied with the result,
% the save & exit button can be pressed. Doing so concatenates the lag
% compensator inside the QFT controller.
