function []=heatmap_plot(frontier_table,nbins)

%This function suppose to take the table and plot the heat map of
%"spinepoint_x_6_conv" and "spinepoint_y_6_conv"

%Most of the data has NaN value for first two frame, so we have to fillmiss
%them

%First for X
X_position = cell(1,length(frontier_table));
for i=1:length(frontier_table)
    X_position{i} = fillmissing(frontier_table{i}.spinepoint_x_6_conv,"nearest");
end

%Now for Y
Y_position = cell(1,length(frontier_table));
for i=1:length(frontier_table)
    Y_position{i} = fillmissing(frontier_table{i}.spinepoint_y_6_conv,"nearest");
end

%Now merging X and Y in one double array together
% use cellfun to apply the length function to each element of the cell array
% lengths = cellfun(@length, my_cell);
% 
% Num_of_positions = sum(lengths);

z=0;
for i=1:numel(X_position)
    for j=1:numel(X_position{i})
        z=z+1;
        Positions(z,1) = Y_position{1,i}(j);
        Positions(z,2) = X_position{1,i}(j);
    end
end
% create some example data
x = Positions(:,2);
y = Positions(:,1);

% create a 2D histogram
% define the edges for the x and y dimensions
x_edges = linspace(-68, 68, nbins+1);
y_edges = linspace(-68, 68, nbins+1);

% create a 2D histogram using the edges
counts = histcounts2(x, y, x_edges, y_edges);
counts(counts > 150) = 150;
%counts = counts';
counts = rot90(counts);

% Change the smoothing method and window size as needed
%counts = smoothdata(counts, 1, 'movmean', 3); 

% Create a Gaussian kernel
kernel_size = 5;
sigma = 1;
kernel = fspecial('gaussian', kernel_size, sigma);

% Apply the kernel to the heatmap
counts = imfilter(counts, kernel, 'replicate');

% display the heatmap
imagesc(x_edges,y_edges,counts);
colormap('jet');
colorbar;
