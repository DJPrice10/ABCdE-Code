%% Script to run ABCdE code for the stochastic death model

% Note that evaluating the discrepancy for the ABC step in
% ABCDE_death_model is the most time consuming step. Re-write this function
% in C/mex to significantly reduce computation time

% Number of simulations used to evaluate utility
number_of_sims=100000;

% Number of observation times: combinations of discT
ntimes=2;

% Grid of times to observe process; does not need to be equally spaced
discT=0.1:0.1:6;

% Tolerance for ABC. Care must be taken when choosing a suitable tolerance
% for the population size, discrepancy function, number of observations
% etc.
tol=0.25;

% Population size for death model
N=50;

% Run to evaluate optimal observation schedule
optimal_times = ABCDE_death_model(number_of_sims, ntimes, discT, tol, N)