function opt_times = ABCDE_death_model(number_of_sims, ntimes, discT, tol, N)
%%
% Code to evaluate the optimal observation schedule for the stochastic death model
%
% FUNCTION INPUTS
% number_of_sims: number of sims used to evaluate utility at each design
% ntimes: number of observation times (combinations of discT)%% 
% discT: discrete Times to observe process at
% tol: ABC tolerance
% N: population size for death model

% FUNCTION OUTPUTS
% opt_times: The optimal observation schedule

% Code written by David J. Price, on the 6th March, 2015, for 
% "On the Efficient Determination of Optimal Bayesian Experimental Designs using ABC: A Case Study in Optimal Observation of Epidemics," 
% by David J. Price, Nigel G. Bean, Joshua V. Ross and Jonathan Tuke.

% Please direct any questions or comments to david.j.price@adelaide.edu.au.
%%

% Define prior distribution parameters % 
prior_b1=-0.005;
sd_b1=sqrt(0.01);

% Chose cut-offs such that P(lower < X < upper) > 0.999
upper_b1=1.4;
lower_b1=0.7;

% Define designs over grid. NOTE: You may need to change to nchoosek if using a later version of MATLAB
D=combntns(discT,ntimes);

% Define prior distribution across grid points %
n=100;
prior_grid=(lower_b1):((upper_b1-lower_b1)/n):upper_b1;
prior_probabilities = lognpdf(prior_grid, prior_b1, sd_b1)/(logncdf(upper_b1,prior_b1,sd_b1)-logncdf((upper_b1/n),prior_b1,sd_b1));
prior_probabilities = prior_probabilities./sum(prior_probabilities);

% Simulated prior values
prior_values = randsample(prior_grid,number_of_sims,true,prior_probabilities);


% Pre-allocate variables
data = zeros(number_of_sims,length(discT));
kld=zeros(length(D),1);


% Simulate data at each observation time for each prior_value % 
parfor i=1:number_of_sims
    data(i,:)=death_simulate(prior_values(i), discT, N);
end

% ABCdE to evalute EKLD for each design and return optimal
parfor i=1:length(D)
    tmp_data = data(:, ismember(discT, D(i,:)));
    
    [uni_data, num] = howmanyunique(tmp_data);
    
    tmp_kld=zeros(size(uni_data,1),1);
    std_tmp=std(tmp_data);
    
    for k=1:size(uni_data,1)
        % ABC: keep prior_values corresponding to discrepancy<tol.

        % Most of the time is spent evaluating the discrepancy. Write in a
        % mex function to speed up code significantly.
        keep = prior_values(sum(bsxfun(@rdivide, bsxfun(@minus, tmp_data, uni_data(k,:)), std_tmp),2)<tol);
        
        % Evaluate posterior density
        density=bsxfun(@rdivide, histc(keep, prior_grid), length(keep));
       
        % Evaluate contribution to kld for this set of unique data
        tmp_kld(k) = sum(nansum(log(density./prior_probabilities).*density))/length(density);         
    end
    % Evaluate ekld for this design
    kld(i) = dot(tmp_kld, num/sum(num));
end

% Find the row of kld that corresponds to the max. kld, and print design
% corresponding to this entry
r=find(kld==max(max(kld)));
opt_times = D(r,:);






