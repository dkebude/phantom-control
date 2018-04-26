function zero_config( axis_handle1, axis_handle2 )

    cla(axis_handle1, 'reset')
    cla(axis_handle2, 'reset')

    l1 = 0.215; l2 = 0.170; l_fix = 0.04;
    fixed = [0 l_fix -l1];
    base = [0 l2 -l1];
    elbow = [0 l2 0];
    ee = [0 0 0];
    [b_X, b_Y, b_Z] = ellipsoid(fixed(1), fixed(2), fixed(3), 0.02, 0.001, 0.02, 20);
    
    ax1 = axis_handle1;
    ax2 = axis_handle2;
    
    axes(ax1);
    hl1(1) = line([fixed(1) base(1)], [fixed(2) base(2)], [fixed(3) base(3)], 'Color', 'k', 'LineWidth', 2);
    hold on;
    hl1(2) = line([base(1) elbow(1)], [base(2) elbow(2)], [base(3) elbow(3)], 'Color', 'k', 'LineWidth', 2);
    hl1(3) = line([elbow(1) ee(1)], [elbow(2) ee(2)], [elbow(3) ee(3)], 'Color', 'k', 'LineWidth', 2);
    hl1(4) = surf(b_X, b_Y, b_Z); set(hl1(4),'LineStyle','none'); set(hl1(4), 'FaceColor', [0.25 0.25 0.25]);
    hl1(5) = plot3(base(1), base(2), base(3), 'ok', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
    hl1(6) = plot3(elbow(1), elbow(2), elbow(3), 'ok', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
    hl1(7) = plot3(ee(1), ee(2), ee(3), 'ok', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
    grid on;
    title('Side View');
    t1 = hgtransform('Parent', ax1);
    set(hl1, 'Parent', t1);
    Ry = makehgtform('yrotate', pi/2);
    set(t1, 'Matrix', Ry);
    xlim([-(l1 + l2) (l1+l2)]); ylim([(l2-(l1+l2)) (l_fix+l1+l2)]); zlim([-(l1 + l2) (l1+l2)]);
    xlabel('z'); ylabel('y');
        
    axes(ax2);
    hl2(1) = line([fixed(1) base(1)], [fixed(2) base(2)], [fixed(3) base(3)], 'Color', 'k', 'LineWidth', 2);
    hold on;
    hl2(2) = line([base(1) elbow(1)], [base(2) elbow(2)], [base(3) elbow(3)], 'Color', 'k', 'LineWidth', 2);
    hl2(3) = line([elbow(1) ee(1)], [elbow(2) ee(2)], [elbow(3) ee(3)], 'Color', 'k', 'LineWidth', 2);
    hl2(4) = surf(b_X, b_Y, b_Z); set(hl2(4),'LineStyle','none'); set(hl2(4), 'FaceColor', [0.25 0.25 0.25]);
    hl2(5) = plot3(base(1), base(2), base(3), 'ok', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
    hl2(6) = plot3(elbow(1), elbow(2), elbow(3), 'ok', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
    hl2(7) = plot3(ee(1), ee(2), ee(3), 'ok', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
    grid on;
    title('Top View');
    t2 = hgtransform('Parent', ax2);
    set(hl2, 'Parent', t2);
    Rx = makehgtform('xrotate', pi/2);
    Rz = makehgtform('zrotate', pi/2);
    set(t2, 'Matrix', Rz*Rx);
    xlim([-(l1 + l2) (l1+l2)]); ylim([(l2-(l1+l2)) (l_fix+l1+l2)]); zlim([-(l1 + l2) (l1+l2)]);
    xlabel('z'); ylabel('x');

end

