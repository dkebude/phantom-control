function force_plot( data )

    time = data.get('tout');
    force = data.get('yout').getElement(3).Values.Data;
    force = reshape(force, length(time), 3);

    figure;
    subplot(3,1,1);
    plot(time, force(:,1));
    title('Controller Force Output Along X-axis');
    grid on; 
    subplot(3,1,2);
    plot(time, force(:,2));
    title('Controller Force Output Along Y-axis');
    grid on; 
    subplot(3,1,3);
    plot(time, force(:,3));
    title('Controller Force Output Along Z-axis');
    grid on;

end

