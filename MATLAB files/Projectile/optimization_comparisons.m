clear all;
close all;
clc;

addpath(genpath(strcat(pwd,'\Shooting\')));
addpath(genpath(strcat(pwd,'\Direct_collocation\')));

initialVelocityGuess = [0;0];

tic;
solutionShooting = run_shooting(initialVelocityGuess);
runTimeShooting = toc;

samplePoints = [25, 50, 75, 100];
runTimeDC = zeros(1, length(samplePoints));

for i = 1:length(samplePoints)
	N = samplepoints(i);
	initialTrajectoryGuess = calc_init_trajectory(N, initialVelocityGuess);
	tic;
	solutionDC = run_direct_collocation(initialTrajectoryGuess);
	runTimeDC(i) = toc;
end

%% Time comparisons

figure; 
plot(samplePoints, runTimeDC, '-bo', samplePoints, ones(1,length(samplePoints))*runTimeShooting, '-ro'); 
xlabel('Sample Points'); 
ylabel('Time (s)'); 
legend('Direct collocation','Shooting'); 

%% Accuracy comparison