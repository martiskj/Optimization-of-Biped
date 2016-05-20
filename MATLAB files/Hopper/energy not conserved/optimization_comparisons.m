clc;
clear all;
close all;

addpath(genpath(strcat(pwd,'/shooting/')));
addpath(genpath(strcat(pwd,'/direct_collocation/')));
parameters = get_parameters();
tMax = parameters(end);
x_init = [4; 0];

tic;
main_shooting(x_init);
runTimeS = toc;

samplePoints = [25, 50, 75, 100, 125];
runTimeDC = zeros(1, length(samplePoints));
figure;
for i = 1:length(samplePoints)
    N = samplePoints(i);
    tic;
    optimalSolutions.(strcat('N',int2str(samplePoints(i)))) = main_direct_collocation(N, x_init);
    runTimeDC(i) = toc;
    subplot(length(samplePoints),1, i);
    plot(linspace(0, tMax, 200), optimalSolutions.(strcat('N',int2str(samplePoints(i)))))
    grid on;
    xlabel('Time (s)');
    ylabel('Position (m)');
    title(sprintf('Direct Collocation, N=%d', samplePoints(i)));
    axis([0, inf, 0, inf]);
end

%% Timecomparison

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
   xlabel('Time (s)');
   ylabel('Error')
   title(sprintf('Accuracy vs. Time, N = %d', samplePoints(i)))
end

figure;
hold on;
for i = 1:length(samplePoints)
   plot(samplePoints(i), sum(accuracies.(strcat('N',int2str(samplePoints(i))))(1,:)),'bo-','MarkerFaceColor','b');
end
grid on;
xlabel('Points (N)')
ylabel('Error')
title('Accuracy vs. Points')
    