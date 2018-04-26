function angle_traj_plot( data )

    time = data.get('tout');
    ref = data.get('yout').getElement(1).Values.Data;
    ref = reshape(ref, 3, length(time))';
    angles = data.get('yout').getElement(5).Values.Data;
    angles = reshape(angles, length(time), 3);
    actual_q = angles;

    p_x = ref(:,1); p_y = ref(:,2); p_z = ref(:,3);
    
    l1 = 0.215; l2 = 0.170;
    
    R = sqrt(p_x.^2 + (p_z + l1).^2);
    r = sqrt(p_x.^2 + (p_y - l2).^2 + (p_z + l1).^2);
    beta = atan2(p_y - l2, R);
    gamma = acos((l1^2 + r.^2 - l2^2)./(2*l1*r));
    alpha = acos((l1^2 + l2^2 - r.^2)./(2*l1*l2));
    
    ref_q1 = atan2(p_x, p_z + l1);
    ref_q2 = gamma + beta;
    ref_q3 = ref_q2 + alpha - (pi/2);
    
    ref_q = [ref_q1, ref_q2, ref_q3];
    
    figure;
    subplot(3,1,1);
    plot(time, ref_q(:,1), time, actual_q(:,1));
    legend('ref q_1', 'actual q_1');
    grid on; 
    subplot(3,1,2);
    plot(time, ref_q(:,2), time, actual_q(:,2));
    legend('ref q_2', 'actual q_2');
    grid on; 
    subplot(3,1,3);
    plot(time, ref_q(:,3), time, actual_q(:,3));
    legend('ref q_3', 'actual q_3');
    grid on;
    suptitle('Ref. vs Actual Angle Trajectory');
end

