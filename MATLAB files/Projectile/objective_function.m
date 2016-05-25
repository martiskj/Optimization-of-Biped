function cost = objective_function(x)

%% Try to hit the target
% The cost is the shortest distance the projectile ever is from the goal 

target_x = 10;
target_y = 0;

cost = sqrt((target_x - x(1,1))^2 + (target_y - x(3,1))^2);
for i = 2:length(x)-1
    new_cost = sqrt((target_x - x(1,i))^2 + (target_y - x(3,i))^2);
    if(new_cost < cost)
        cost = new_cost;
    end
end