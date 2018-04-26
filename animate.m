function animate( data, axis_handle1, axis_handle2 )
    
    cla(axis_handle1, 'reset')
    cla(axis_handle2, 'reset')

    time = data.get('tout');
    ref = data.get('yout').getElement(1).Values.Data;
    ref = reshape(ref, 3, length(time))';
    actual = data.get('yout').getElement(4).Values.Data;
    actual = reshape(actual, length(time), 3);
    angles = data.get('yout').getElement(5).Values.Data;
    angles = reshape(angles, length(time), 3);
    l1 = 0.215; l2 = 0.170; l_fix = 0.04;
    fixed = [0 l_fix -l1];
    base = [0 l2 -l1];
    elbow = [0 l2 0];
    ee = [0 0 0];
    [b_X, b_Y, b_Z] = ellipsoid(fixed(1), fixed(2), fixed(3), 0.02, 0.001, 0.02, 20);
    
    ax1 = axis_handle1;
    ax2 = axis_handle2;
    
    axes(ax1);
    hl1(1) = line(ref(:,1), ref(:,2), ref(:,3), 'Color', 'k');
    hold on;
    hl1(2) = line(actual(:,1), actual(:,2), actual(:,3), 'Color', 'r');
    hl1(3) = line([fixed(1) base(1)], [fixed(2) base(2)], [fixed(3) base(3)], 'Color', 'k', 'LineWidth', 2);
    hl1(4) = line([base(1) elbow(1)], [base(2) elbow(2)], [base(3) elbow(3)], 'Color', 'k', 'LineWidth', 2);
    hl1(5) = line([elbow(1) ee(1)], [elbow(2) ee(2)], [elbow(3) ee(3)], 'Color', 'k', 'LineWidth', 2);
    hl1(6) = surf(b_X, b_Y, b_Z); set(hl1(6),'LineStyle','none'); set(hl1(6), 'FaceColor', [0.25 0.25 0.25]);
    hl1(7) = plot3(base(1), base(2), base(3), 'ok', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
    hl1(8) = plot3(elbow(1), elbow(2), elbow(3), 'ok', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
    hl1(9) = plot3(ee(1), ee(2), ee(3), 'ok', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
    grid on;
    title('Side View');
    t1 = hgtransform('Parent', ax1);
    set(hl1, 'Parent', t1);
    Ry = makehgtform('yrotate', pi/2);
    set(t1, 'Matrix', Ry);
    xlim([-(l1 + l2) (l1+l2)]); ylim([(l2-(l1+l2)) (l_fix+l1+l2)]); zlim([-(l1 + l2) (l1+l2)]);
    xlabel('z'); ylabel('y');
        
    axes(ax2);
    hl2(1) = line(ref(:,1), ref(:,2), ref(:,3), 'Color', 'k', 'LineStyle', '--');
    hold on;
    hl2(2) = line(actual(:,1), actual(:,2), actual(:,3), 'Color', 'r');
    hl2(3) = line([fixed(1) base(1)], [fixed(2) base(2)], [fixed(3) base(3)], 'Color', 'k', 'LineWidth', 2);
    hl2(4) = line([base(1) elbow(1)], [base(2) elbow(2)], [base(3) elbow(3)], 'Color', 'k', 'LineWidth', 2);
    hl2(5) = line([elbow(1) ee(1)], [elbow(2) ee(2)], [elbow(3) ee(3)], 'Color', 'k', 'LineWidth', 2);
    hl2(6) = surf(b_X, b_Y, b_Z); set(hl2(6),'LineStyle','none'); set(hl2(6), 'FaceColor', [0.25 0.25 0.25]);
    hl2(7) = plot3(base(1), base(2), base(3), 'ok', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
    hl2(8) = plot3(elbow(1), elbow(2), elbow(3), 'ok', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
    hl2(9) = plot3(ee(1), ee(2), ee(3), 'ok', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
    grid on;
    title('Top View');
    t2 = hgtransform('Parent', ax2);
    set(hl2, 'Parent', t2);
    Rx = makehgtform('xrotate', pi/2);
    Rz = makehgtform('zrotate', pi/2);
    set(t2, 'Matrix', Rz*Rx);
    xlim([-(l1 + l2) (l1+l2)]); ylim([(l2-(l1+l2)) (l_fix+l1+l2)]); zlim([-(l1 + l2) (l1+l2)]);
    xlabel('z'); ylabel('x');
    skip = 1e4;
    
    for i = 1:skip:length(ref)
        q1 = angles(i,1); q2 = angles(i,2); q3 = angles(i,3);
        
        x_elbow = l1*sin(q1)*cos(q2);
        y_elbow = l2 + l1*sin(q2);
        z_elbow = -l1 + l1*cos(q1)*cos(q2);
        
        x_ee = sin(q1)*(l1*cos(q2)+l2*sin(q3));
        y_ee = l2 - l2*cos(q3) + l1*sin(q2);
        z_ee = -l1 + cos(q1)*(l1*cos(q2)+l2*sin(q3));
        
        x_link1 = [base(1), x_elbow];
        y_link1 = [base(2), y_elbow];
        z_link1 = [base(3), z_elbow];
        
        x_link2 = [x_elbow, x_ee];
        y_link2 = [y_elbow, y_ee];
        z_link2 = [z_elbow, z_ee];
        
        set(hl1(4), 'XData', x_link1, 'YData', y_link1, 'ZData', z_link1);
        set(hl1(5), 'XData', x_link2, 'YData', y_link2, 'ZData', z_link2);
        set(hl1(8), 'XData', x_elbow, 'YData', y_elbow, 'ZData', z_elbow);
        set(hl1(9), 'XData', x_ee, 'YData', y_ee, 'ZData', z_ee);
        
        set(hl2(4), 'XData', x_link1, 'YData', y_link1, 'ZData', z_link1);
        set(hl2(5), 'XData', x_link2, 'YData', y_link2, 'ZData', z_link2);
        set(hl2(8), 'XData', x_elbow, 'YData', y_elbow, 'ZData', z_elbow);
        set(hl2(9), 'XData', x_ee, 'YData', y_ee, 'ZData', z_ee);
        
        drawnow
    end
end

