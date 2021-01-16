%% Notch/Anti notch
% This compensator has two zeros and two poles (can be chosen to be complex
% or not), and a trait which enables it to attenuate the gain at a certain
% frequency. *Notice* that the penalty for using it is an increase of the phase
% at its frequency, thus yielding an even higher phase at than before. 
% 
% Choosing  $$\omega_n = \omega_d$  yields a notch filter, and
%  $$\omega_n \neq \omega_d$ yields  a skew filter. A notch filter passes
% most frequencies unaltered, and attenuates (evenly at both sides of a given
% frequency) others that are inside a specific range. A skew notch attenuates
% the gain unevenly, meaning that at gain will be higher slowly decrease at
% low frequencies and sharply increase at higher frequencies. 
%
% Using this compensator will highly increase the phase at the chosen 
% frequency, whereas a skew notch will employ a more moderate increase of the phase.  
% This submenu enables the user to choose the desired filtered frequency 
% decrease, and see the resulted magnitude and phase of the filter via bode plot.
% Once the user is satisfied with the result, the save & exit button can be 
% pressed. Doing so concatenates the notch/anti notch compensator inside the QFT controller.
%
% *|WARNING:|* for notching, the damping coefficients must satisfy the following inequality:
% 
% $$\xi_n < \xi_d$
