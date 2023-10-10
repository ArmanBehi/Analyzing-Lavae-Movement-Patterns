clc;
clear;


%% Taking the Data
% Specify the name and path of the Excel file to be imported
filename = 'experiment-2023-04-18_analyzed';
filepath = 'C:\Users\abehrad\Desktop\Analyzed_Data\New folder\experiment-2023-04-18-analysis(90_degree)';

% Construct the full file path
full_path = fullfile(filepath, filename);

% Read the data from the Excel file into a MATLAB table
data_table = readtable(full_path);

var_names = data_table.Properties.VariableNames;

%% ID split
ID_splitTables = IDwiseSplit(data_table);

%% Heat map plot
heatmap_plot(ID_splitTables,300)

%% Frontier selection
frontier_table=frontier_selection(ID_splitTables);

%% First passage time 
[F_p,last_sec] = First_passage(frontier_table, 180);
%% Heat-Map Video
str = '0degree 9cm AM(1 20)(Moving average)';
Heat_map_video(data_table,str,70,5)
%% Trajectory Video
str = '9cm 90degree AM120';
Trajectory_video(data_table,str)

%% Heat-Map Video2
str = '0degree 9cm AM(1 20)(Heat map of trajectory)';
Heat_map_video2(data_table,str,70,5)




