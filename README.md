# Analyzing-Larvae-Movement-Patterns


## Description

This project analyzes the movement patterns of lavae in a petri dish, making decisions based on single or multiple attractive targets. The analysis includes generating trajectory videos and heat maps using data from IMBAtracker. 
Start with the .m file "Analyzing-Lavae-Movement-Patterns"

## Prerequisites

Before running the code, make sure you have the following:

- MATLAB installed on your system.
- Data collected using IMBAtracker (available at [IMBAtracker](https://doi.org/10.1098/rsob.220308)).
- Sample data in a folder called `sample_data`.

## Code Overview

- `IDwiseSplit(data_table)`: Splits the data into individual IDs.
- `frontier_selection(ID_splitTables)`: Selects IDs based on specific criteria.
- `heatmap_plot(frontier_table, nbins)`: Plots heat maps based on X and Y coordinates.
- `Heat_map_video(data_table, name_of_the_video, nbins, periods)`: Generates a video of the heat map.
- `Trajectory_video(data_table, name_of_the_video)`: Generates a video of the lavae trajectories.

## Usage

1. Run `IDwiseSplit(data_table)` to split the data by ID.

2. Use `frontier_selection(ID_splitTables)` to select relevant IDs.

3. Generate a heat map by running `heatmap_plot(frontier_table, nbins)`.

4. Create a heat map video using `Heat_map_video(data_table, name_of_the_video, nbins, periods)`.

5. Generate a trajectory video with `Trajectory_video(data_table, name_of_the_video)`.

## Sample Data

Sample data should be placed in the `sample_data` folder.

## Acknowledgements

The analysis in this project is based on data obtained from IMBAtracker.

