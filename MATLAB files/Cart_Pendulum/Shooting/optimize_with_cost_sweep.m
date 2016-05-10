function optimal_parameters = optimize_with_cost_sweep(speed_des, parameters_init, cost_weights, method)
    mu_now = 0.1;
    [M, mp, Jp, Lc, g, mu] = set_parameters(mu_now);
    a1 = []; a2 = [];

    switch method
    case 'fmincon'
        optionsFMINCON = optimoptions(@fmincon, 'Algorithm', 'interior-point', 'Display', 'iter');
        [optimal_parameters, ~] = fmincon(@(x) cost_cpf(x,a1,a2,speed_des),parameters_init,...
            [],[],[],[],[],[],...
            @(x) mycon_cpf(x,speed_des), optionsFMINCON);
    case 'fminsearch'
        % optionsFMINSEARCH = optimset('Display', 'iter');
        optimal_parameters = fminsearch(@(x) cost_cpf_fminsearch_sweep(x,speed_des, cost_weights),parameters_init)%,optionsFMINSEARCH);
    end