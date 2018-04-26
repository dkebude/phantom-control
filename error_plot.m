function error_plot( data )

    time = data.get('tout');
    error = data.get('yout').getElement(2).Values.Data;
    error = reshape(error, length(time), 3);

    err_x = mean(error(:,1));
    err_y = mean(error(:,2));
    err_z = mean(error(:,3));
    figure;
    subplot(3,1,1)
    plot(time, error(:,1));
    x_title = sprintf('x_p_o_s Error, Avg: %1.8f', err_x);
    title(x_title);
    grid on; 
    subplot(3,1,2)
    plot(time, error(:,2));
    y_title = sprintf('y_p_o_s Error, Avg: %1.8f', err_y);
    title(y_title);
    grid on; 
    subplot(3,1,3)
    plot(time, error(:,3));
    z_title = sprintf('z_p_o_s Error, Avg: %1.8f', err_z);
    title(z_title);
    grid on;

end

