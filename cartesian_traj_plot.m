function cartesian_traj_plot( data )

    time = data.get('tout');
    ref = data.get('yout').getElement(1).Values.Data;
    ref = reshape(ref, 3, length(time))';
    actual = data.get('yout').getElement(4).Values.Data;
    actual = reshape(actual, length(time), 3);

    figure;
    subplot(3,1,1);
    plot(time, ref(:,1), time, actual(:,1));
    legend('ref x_p_o_s', 'actual x_p_o_s');
    grid on; 
    subplot(3,1,2);
    plot(time, ref(:,2), time, actual(:,2));
    legend('ref y_p_o_s', 'actual y_p_o_s');
    grid on; 
    subplot(3,1,3);
    plot(time, ref(:,3), time, actual(:,3));
    legend('ref z_p_o_s', 'actual z_p_o_s');
    grid on;
    suptitle('Ref. vs Actual Cartesian Trajectory');

end

