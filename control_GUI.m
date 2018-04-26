function control_GUI
    clear all; close all; clc;
    
    fprintf('Generating GUI...\n');
    handles.f = figure('Visible','off','Position',[50,50,1300,600]);
    
    handles.htextinitpos_x  = uicontrol('Style','text','String','X coord. of Start Pos.',...
                 'Position',[1140,580,150,15]);
    handles.heditinitpos_x  = uicontrol('Style','edit','String','0',...
                 'Position',[1140,560,150,20]);
    handles.htextinitpos_y  = uicontrol('Style','text','String','Y coord. of Start Pos.',...
                 'Position',[1140,540,150,15]);
    handles.heditinitpos_y  = uicontrol('Style','edit','String','0',...
                 'Position',[1140,520,150,20]);
    handles.htextinitpos_z  = uicontrol('Style','text','String','Z coord. of Start Pos.',...
                 'Position',[1140,500,150,15]);
    handles.heditinitpos_z  = uicontrol('Style','edit','String','0',...
                 'Position',[1140,480,150,20]);
    handles.htextendpos_x  = uicontrol('Style','text','String','X coord. of Target Pos.',...
                 'Position',[1140,460,150,15]);
    handles.heditendpos_x  = uicontrol('Style','edit','String','0.1',...
                 'Position',[1140,440,150,20]);
    handles.htextendpos_y  = uicontrol('Style','text','String','Y coord. of Target Pos.',...
                 'Position',[1140,420,150,15]);
    handles.heditendpos_y  = uicontrol('Style','edit','String','0.1',...
                 'Position',[1140,400,150,20]);
    handles.htextendpos_z  = uicontrol('Style','text','String','Z coord. of Target Pos.',...
                 'Position',[1140,380,150,15]);
    handles.heditendpos_z  = uicontrol('Style','edit','String','0.1',...
                 'Position',[1140,360,150,20]);
    handles.htextfinishtime = uicontrol('Style','text','String','Finish Time',...
                 'Position',[1140,340,150,15]);
    handles.heditfinishtime = uicontrol('Style','edit','String','1',...
                 'Position',[1140,320,150,20]);
    handles.htextstepsize = uicontrol('Style','text','String','Time Step Size',...
                 'Position',[1140,300,150,15]);
    handles.heditstepsize = uicontrol('Style','edit','String','1e-5',...
                 'Position',[1140,280,150,20]);
    handles.htextstatus = uicontrol('Style','text','String','Ready',...
                 'Position',[1140,30,150,15]);
    
    handles.ha1 = axes('Units','pixels','Position',[60,60,500,500]);
    handles.ha2 = axes('Units','pixels','Position',[620,60,500,500]);
 
    start_x = str2double(get(handles.heditinitpos_x,'string'));
    start_y = str2double(get(handles.heditinitpos_y,'string'));
    start_z = str2double(get(handles.heditinitpos_z,'string'));
    start = [start_x; start_y; start_z];
    target_x = str2double(get(handles.heditendpos_x,'string'));
    target_y = str2double(get(handles.heditendpos_y,'string'));
    target_z = str2double(get(handles.heditendpos_z,'string'));
    target = [target_x; target_y; target_z];
    finish_time = str2double(get(handles.heditfinishtime,'string'));
    dt = str2double(get(handles.heditstepsize,'string'));
    
    fprintf('...Generating Initial Trajectory...\n');
    ref = traj_gen(start, target, dt, finish_time);
    assignin('base', 'ref', ref);    
    fprintf('\b\b\b\b [DONE]\n');
    
    fprintf('...Simulating with Initial Parameters...\n');
    handles.data = sim('control_model.slx', 'FixedStep', num2str(dt), 'StartTime', '0', 'StopTime', num2str(1.1+finish_time));
    fprintf('\b\b\b\b [DONE]\n');
    
    handles.hzeroconfig    = uicontrol('Style','pushbutton',...
                 'String','Go To Zero Config.','Position',[1140,240,150,25],...
                 'Callback',{@zeroconfig_Callback, handles});
    handles.hsimulate    = uicontrol('Style','pushbutton',...
                 'String','Simulate','Position',[1140,210,150,25],...
                 'Callback',{@simulate_Callback, handles});
    handles.hcarttraj    = uicontrol('Style','pushbutton',...
                 'String','Plot Cartesian Traj.','Position',[1140,180,150,25],...
                 'Callback',{@carttraj_Callback, handles});
    handles.hangletraj    = uicontrol('Style','pushbutton',...
                 'String','Plot Angle Traj.','Position',[1140,150,150,25],...
                 'Callback',{@angletraj_Callback, handles});
    handles.hforces    = uicontrol('Style','pushbutton',...
                 'String','Plot Forces','Position',[1140,120,150,25],...
                 'Callback',{@forces_Callback, handles});
    handles.herror    = uicontrol('Style','pushbutton',...
                 'String','Plot Error','Position',[1140,90,150,25],...
                 'Callback',{@error_Callback, handles});
    handles.hanimate = uicontrol('Style','pushbutton',...
                 'String','Animate','Position',[1140,60,150,25],...
                 'Callback', {@animate_Callback, handles});
    
    
    fprintf('...Generating Workspace in Zero Configuration...\n');
    zero_config(handles.ha1, handles.ha2);
    fprintf('\b\b\b\b [DONE]\n');
    
    fprintf('...Displaying GUI.\n');
    handles.f.Visible = 'on';
end

function zeroconfig_Callback(source, eventdata, handles)
    zero_config(handles.ha1, handles.ha2);
end

function simulate_Callback(source, eventdata, handles)
    global data;
    
    start_x = str2double(get(handles.heditinitpos_x,'string'));
    start_y = str2double(get(handles.heditinitpos_y,'string'));
    start_z = str2double(get(handles.heditinitpos_z,'string'));
    start = [start_x; start_y; start_z];
    target_x = str2double(get(handles.heditendpos_x,'string'));
    target_y = str2double(get(handles.heditendpos_y,'string'));
    target_z = str2double(get(handles.heditendpos_z,'string'));
    target = [target_x; target_y; target_z];
    finish_time = str2double(get(handles.heditfinishtime,'string'));
    dt = str2double(get(handles.heditstepsize,'string'));

    ref = traj_gen(start, target, dt, finish_time);
    assignin('base', 'ref', ref);    
    
    set(handles.htextstatus, 'String', 'Simulating...');
    data = sim('control_model.slx', 'FixedStep', num2str(dt), 'StartTime', '0', 'StopTime', num2str(1.1+finish_time));
    set(handles.htextstatus, 'String', 'Simulating [DONE]');
    pause(1);
    set(handles.htextstatus, 'String', 'Ready');
end

function carttraj_Callback(source, eventdata, handles)
    global data;
    finish_time = str2double(get(handles.heditfinishtime,'string'));
    if isempty(data)
        set(handles.htextstatus, 'String', 'Plotting Cart. Traj.');
        cartesian_traj_plot(handles.data);
        f_name = sprintf('Figures/Cart_%1.1f.PNG', finish_time);
        print(gcf, f_name, '-dpng', '-r300');
        set(handles.htextstatus, 'String', 'Ready');
    else
        set(handles.htextstatus, 'String', 'Plotting Cart. Traj.');
        cartesian_traj_plot(data);
        f_name = sprintf('Figures/Cart_%1.1f.PNG', finish_time);
        print(gcf, f_name, '-dpng', '-r300');
        set(handles.htextstatus, 'String', 'Ready');
    end
end

function angletraj_Callback(source, eventdata, handles)
    global data;
    finish_time = str2double(get(handles.heditfinishtime,'string'));
    if isempty(data)
        set(handles.htextstatus, 'String', 'Plotting Angle Traj.');
        angle_traj_plot(handles.data);
        f_name = sprintf('Figures/Angles_%1.1f.PNG', finish_time);
        print(gcf, f_name, '-dpng', '-r300');
        set(handles.htextstatus, 'String', 'Ready');
    else
        set(handles.htextstatus, 'String', 'Plotting Angle Traj.');
        angle_traj_plot(data);
        f_name = sprintf('Figures/Angles_%1.1f.PNG', finish_time);
        print(gcf, f_name, '-dpng', '-r300');
        set(handles.htextstatus, 'String', 'Ready');
    end
end

function forces_Callback(source, eventdata, handles)
    global data;
    finish_time = str2double(get(handles.heditfinishtime,'string'));
    if isempty(data)
        set(handles.htextstatus, 'String', 'Plotting Forces');
        force_plot(handles.data);
        f_name = sprintf('Figures/Force_%1.1f.PNG', finish_time);
        print(gcf, f_name, '-dpng', '-r300');
        set(handles.htextstatus, 'String', 'Ready');
    else
        set(handles.htextstatus, 'String', 'Plotting Forces');
        force_plot(data);
        f_name = sprintf('Figures/Force_%1.1f.PNG', finish_time);
        print(gcf, f_name, '-dpng', '-r300');
        set(handles.htextstatus, 'String', 'Ready');
    end
end

function error_Callback(source, eventdata, handles)
    global data;
    finish_time = str2double(get(handles.heditfinishtime,'string'));
    if isempty(data)
        set(handles.htextstatus, 'String', 'Plotting Errors');
        error_plot(handles.data);
        f_name = sprintf('Figures/Error_%1.1f.PNG', finish_time);
        print(gcf, f_name, '-dpng', '-r300');
        set(handles.htextstatus, 'String', 'Ready');
    else
        set(handles.htextstatus, 'String', 'Plotting Errors');
        error_plot(data);
        f_name = sprintf('Figures/Error_%1.1f.PNG', finish_time);
        print(gcf, f_name, '-dpng', '-r300');
        set(handles.htextstatus, 'String', 'Ready');
    end
end

function animate_Callback(source, eventdata, handles)
    global data;
    finish_time = str2double(get(handles.heditfinishtime,'string'));
    if isempty(data)
        set(handles.htextstatus, 'String', 'Animating...');
        animate(handles.data, handles.ha1, handles.ha2);
        set(handles.htextstatus, 'String', 'Animating [DONE]');
        f_name = sprintf('Figures/Animation_%1.1f.PNG', finish_time);
        print(gcf, f_name, '-dpng', '-r300');
        pause(1);
        set(handles.htextstatus, 'String', 'Ready');
    else
        set(handles.htextstatus, 'String', 'Animating...');
        animate(data, handles.ha1, handles.ha2);
        set(handles.htextstatus, 'String', 'Animating [DONE]');
        f_name = sprintf('Figures/Animation_%1.1f.PNG', finish_time);
        print(gcf, f_name, '-dpng', '-r300');
        pause(1);
        set(handles.htextstatus, 'String', 'Ready');
    end
end