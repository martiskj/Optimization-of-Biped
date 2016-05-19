clc;
clear all;
close all;

addpath(genpath(strcat(pwd,'\shooting\')));
addpath(genpath(strcat(pwd,'\direct_collocation\')));
parameters = get_parameters();
tMax = parameters(5);
x_init = [4; 0];

tic;
main_shooting(x_init);
runTimeS = toc;

samplePoints = [5, 10];%, 100, 200];
runTimeDC = zeros(1, length(samplePoints));
figure;
for i = 1:length(samplePoints)
    N = samplePoints(i);
    tic;
    optimalSolutions.(strcat('N',int2str(samplePoints(i)))) = main_direct_collocation(N, x_init);
    runTimeDC(i) = toc;
    subplot(length(samplePoints),1, i);
    plot(linspace(0, tMax, 200), optimalSolutions.(strcat('N',int2str(samplePoints(i)))))
    xlabel('Time (s)');
    ylabel('Position (m)');
    title(sprintf('Direct Collocation, N=%d', samplePoints(i)));
end

%% Timecomparison
axis([0, inf, 0, inf]);
figure;
plot(samplePoints, runTimeDC, '-bo', samplePoints, ones(1,length(samplePoints))*runTimeS, '-ro');
xlabel('Sample Points');
ylabel('Time (s)');
legend('Direct collocation','Shooting');

%% Accuracy comparison

time = linspace(0,parameters(5),200);
accuracies = zeros(1, length(samplePoints));
figure;
for i = 1:length(samplePoints)
   current_solution = optimalSolutions.(strcat('N',int2str(samplePoints(i))));
   accuracies.(strcat('N',int2str(samplePoints(i)))) = calc_accuracy(current_solution, parameters);
   subplot(1,length(samplePoints),i)
   plot(time, accuracies.(strcat('N',int2str(samplePoints(i))))(1,:))
   xlabel('time (s)');
   ylabel('error')
   title(sprintf('Accuracy, N = %d', samplePoints(i)))
end