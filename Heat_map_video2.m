function [] = Heat_map_video2(data_table,name_of_the_video,nbins,periods)
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

% %Parameter for plotting circles
% x_max = 68;
% x_min = -68;
% 
% y_max = 68;
% y_min = -68;

%Parameter for plotting circles
x_max = max(cellfun(@(x) max(x(:,2)), B));
x_min = min(cellfun(@(x) min(x(:,2)), B));
% x_max=75;
% x_min=-75;
y_max = max(cellfun(@(x) max(x(:,3)), B));
y_min = min(cellfun(@(x) min(x(:,3)), B));
% y_max=75;
% y_min=-75;
% calculate the center and radius of the circle
xCenter = (x_min + x_max) / 2;
yCenter = (y_min + y_max) / 2;
radius = min((x_max - x_min), (y_max - y_min)) / 2;

%Defining the graphing video
Graphing_periods = length(unique_values)/(periods*16); %Beacuse each second is 16 frame
Z1 = 1;
Z2 = periods;
% Initialize the video writer

v = VideoWriter(name_of_the_video,'MPEG-4');
% Set the frame rate and open the video file
v.FrameRate = 1;
v.Quality = 100;
open(v);

for i=1:Graphing_periods

    % Now you have to take a mean value of movement during graphing-period
    z = B(1:Z2,1);
    z = cell2mat(z);
    x = z(:,2); %intermediate brace indexing
    y = z(:,3);

    % create a 2D histogram
    % define the edges for the x and y dimensions
    x_edges = linspace(x_min, x_max, nbins+1);
    y_edges = linspace(y_min,y_max, nbins+1);

    % create a 2D histogram using the edges
    counts = histcounts2(x, y, x_edges, y_edges);
    %counts(counts > 0.5) = 0.5;

    %Normalizing the value of "Counts"
    %counts = counts./mean(counts,'all');

    counts = rot90(counts); %For unknown reason the tracker provide you with a 90 degree rotated version of x-y plane
    

    % Create a Gaussian kernel
    kernel_size = 10;
    sigma = 1.5;
    kernel = fspecial('gaussian', kernel_size, sigma);

    % Apply the kernel to the heatmap
    counts = imfilter(counts, kernel, 'replicate');
    %counts(73:75,:) = (0.1); %In order to correct the artifact
    % display the heatmap
    imagesc(x_edges,y_edges,counts);
    colormap('jet');
    %colorbar;
    sec = i*periods;
    title(name_of_the_video,['second= ',num2str(sec)])

    % draw the circle
    rectangle('Position', [xCenter-radius, yCenter-radius, 2*radius, 2*radius], ...
        'Curvature', [1,1], 'EdgeColor', 'w', 'LineWidth', 2);
    axis equal;
    hold on
    rectangle('Position', [x_max - 20, -7.5,15, 15], ...
        'Curvature', [1,1], 'EdgeColor', 'w','LineWidth', 2); %0Degree
%         rectangle('Position', [x_min+5, -7.5, 15, 15], ...
%             'Curvature', [1,1], 'EdgeColor', 'w','LineWidth', 2); %180
    %     rectangle('Position', [ -7.5,y_max - 20, 15, 15], ...
    %         'Curvature', [1,1], 'EdgeColor', 'w','LineWidth', 2);

%     axis([-68 68 -68 68])
%         rectangle('Position', [-7.5,y_min + 5,15, 15], ...
%             'Curvature', [1,1], 'EdgeColor', 'w','LineWidth', 2); %90degree
    %Before using "getframe", enlarge your figure by maximizing it
    set(1,'Position',[10 40 1200 1200])
    % Write the frame to the video
    frame = getframe(gcf);
    writeVideo(v, frame);

    %defining consecutive periods
    %Z1 = Z1 + periods;
    Z2 = Z2 + (periods*16);

end

% Close the video writer
close(v);
