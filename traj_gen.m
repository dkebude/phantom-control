function ref = traj_gen( start, finish, dt, finish_time )

    c1 = 0; c2 = 0; c3 = 0;
    s1 = start(1); s2 = start(2); s3 = start(3);
    f1 = finish(1); f2 = finish(2); f3 = finish(3);
    samples_curtostart = 1.0/dt+2;
    samples_actual = finish_time/dt+2;
        
    p1 = [linspace(c1, s1, samples_curtostart)'; linspace(s1, s1, 10001)'; linspace(s1, f1, samples_actual)'; linspace(f1, f1, 10001)'];
    p2 = [linspace(c2, s2, samples_curtostart)'; linspace(s2, s2, 10001)'; linspace(s2, f2, samples_actual)'; linspace(f2, f2, 10001)'];
    p3 = [linspace(c3, s3, samples_curtostart)'; linspace(s3, s3, 10001)'; linspace(s3, f3, samples_actual)'; linspace(f2, f2, 10001)'];
    
    ref.time = [linspace(0.0, 1.0, samples_curtostart)'; linspace(1.0, 1.1, 10001)'; linspace(1.1, 1.1+finish_time, samples_actual)'; linspace(1.1+finish_time, 1.1+finish_time+0.1, 10001)'];
    ref.signals.values = [p1, p2, p3];
    ref.signals.dimensions = 3;
    
end

