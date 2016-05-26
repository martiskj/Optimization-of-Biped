clear all;
close all;
clc;

addpath(genpath(strcat(pwd,'\Shooting\')));
addpath(genpath(strcat(pwd,'\Direct_collocation\')));

init.x  = 0;
init.dx = 1;
init.y  = 0;
init.dy = 1;

initialStateGuess = [init.x; init.dx; init.y; init.dy];
parameters = set_parameters();
guess.endTime = 3;
N_shooting = 50;
tic;
solutionShooting = run_shooting(initialStateGuess, guess, N_shooting, parameters);
runTimeShooting = toc;

samplePoints = [25, 50, 75, 100];
runTimeDC = zeros(1, length(samplePoints));

for i = 1:length(samplePoints)
	N = samplePoints(i);
	initialTrajectoryGuess = calc_init_trajectory(initialStateGuess, N, guess, parameters);
	tic;
	solutionDC.(strcat('N',int2str(samplePoints(i)))) = run_direct_collocation(initialTrajectoryGuess, parameters);
	runTimeDC(i) = toc;
end

%% Time comparisons
figure; 
plot(samplePoints, runTimeDC, '-bo', samplePoints, ones(1,length(samplePoints))*runTimeShooting, '-ro'); 
xlabel('Sample Points'); 
ylabel('Time (s)'); 
legend('Direct collocation','Shooting'); 

%% Accuracy comparison
for i=1:length(samplePoints)
	currentSolution = solutionDC.(strcat('N',int2str(samplePoints(i))));
	errorDC.(strcat('N',int2str(samplePoints(i)))) = calc_accuracy(currentSolution, parameters);
end
errorShooting = calc_accuracy(solutionShooting, parameters);

% plotting:
figure; 
hold on;
for i = 1:length(samplePoints)
   plot(samplePoints(i), sum(errorDC.(strcat('N',int2str(samplePoints(i))))(1,:)),'bo-','MarkerFaceColor','b'); 
end
plot(N_shooting, sum(errorShooting(1,:)),'ro-','MarkerFaceColor','r');
hold off;
grid on; 
xlabel('Points (N)') 
ylabel('Error') 
title('Accuracy vs. Points') 

