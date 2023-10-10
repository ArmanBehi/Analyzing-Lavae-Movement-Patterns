function [] = Trajectory_video(data_table,name_of_the_video)
%% Fillmissing data

Y = fillmissing(data_table.spinepoint_y_6_conv, 'nearest');
X = fillmissing(data_table.spinepoint_x_6_conv,"nearest");
Frame = data_table.frame;
location = [Frame,X,Y];

%% Make a cell of locations with same frame
% Find the unique values of frames
[unique_values,~,indices] = unique(location(:,1));

% Find the indices of rows with the same value in the first column(Frame)
rows_with_same_value = accumarray(indices,1:size(location,1),[],@(x) {x});

% Create a cell
B = cell(numel(unique_values),1);
for i = 1:numel(unique_values)

    B{i,1} = location(rows_with_same_value{i},:);

end

%% Plot the heat map

%Parameter for plotting circles
x_max = max(cellfun(@(x) max(x(:,2)), B));
x_min = min(cellfun(@(x) min(x(:,2)), B));

y_max = max(cellfun(@(x) max(x(:,3)), B));
y_min = min(cellfun(@(x) min(x(:,3)), B));

% calculate the center and radius of the circle
xCenter = (x_min + x_max) / 2;
yCenter = (y_min + y_max) / 2;
radius = min((x_max - x_min), (y_max - y_min)) / 2;

v = VideoWriter(name_of_the_video,'MPEG-4');
% Set the frame rate and open the video file
v.FrameRate = 20;
v.Quality = 100;
open(v);



for i=1:numel(B)

    %%draw the circle
    rectangle('Position', [xCenter-radius, yCenter-radius, 2*radius, 2*radius], ...
        'Curvature', [1,1], 'EdgeColor', 'b', 'LineWidth', 2);
    axis equal;
    hold on
%     rectangle('Position', [x_max - 20, -7.5, 15, 15], ...
%         'Curvature', [1,1], 'EdgeColor', 'b','LineWidth', 2); %0Degree
    %         rectangle('Position', [x_min+5, -7.5, 15, 15], ...
    %             'Curvature', [1,1], 'EdgeColor', 'b','LineWidth', 2); %180
    %     rectangle('Position', [ -7.5,y_max - 20, 15, 15], ...
    %         'Curvature', [1,1], 'EdgeColor', 'b','LineWidth', 2);

    %     axis([-68 68 -68 68])
    %         rectangle('Position', [-7.5,y_min + 5, 15, 15], ...
    %             'Curvature', [1,1], 'EdgeColor', 'w','LineWidth', 2); %90degree

    %%Before using "getframe", enlarge your figure by maximizing it
    set(1,'Position',[10 40 1200 1200])

    %%Main Plot
    plot(B{i,1}(:,2),B{i,1}(:,3),'.')
    sec = ceil(i/16);
    title(name_of_the_video,['second= ',num2str(sec)])


    % Write the frame to the video
    frame = getframe(gcf);
    writeVideo(v, frame);
end


