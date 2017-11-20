# ABCdE-Code
Code to implement ABCdE, from Price et al. (2016) J. Stat. Plan. &amp; Inf.



INCLUDED FUNCTIONS:
"Run_ABCdE_death.m": Use this function to evaluate an example of determining the approximate Bayesian optimal 
observation schedule for the death model.

"ABCDE_death_model.m": This function contains the ABCdE algorithm and all required parts.

"death_simulate.m": Simulates the death process, this function was supplied by Drovandi & Pettitt (2013) for 
"Bayesian Experimental Design for Models with Intractable Likelihoods", in Biometrics. Code was accessed via 
the Biometrics website at the Wiley Online Library.

"howmanyunique.m": Returns the unique rows in a matrix, and the frequency of each.

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 


To run the ABCdE design methodology code for the death example from our paper, use the file 
"Run_ABCdE_death.m".  

Please note that the algorithm can be run much faster by implementing the code to evaluate the 
discrepancy using a mex function. We implemented this ourselves. However, for the purpose of illustrating the 
methodology and for greater accessibility, all code included is written in MATLAB.

Please also note that the code is correct for the examples we have considered, however, we cannot 
guarantee that there will not be an issue if aspects of the code are changed to consider alternative
input (i.e., other prior distributions). Care must be taken to ensure all aspects of the code are correct for 
alternative examples.


If you utilise this code and/or method, please cite our paper "On the Efficient Determination of Optimal 
Bayesian Experimental Designs using ABC: A Case Study in Optimal Observation of Epidemics", 
by David J. Price, Nigel G. Bean, Joshua V. Ross and Jonathan Tuke.


Please direct any questions or comments about the code to david.j.price@adelaide.edu.au.
