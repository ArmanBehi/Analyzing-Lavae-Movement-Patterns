function  [frontier_table] = frontier_selection(ID_splitTables)

%This script suppose to eliminate all of the IDs that have not the first
%frame (Only the IDs that detected at the initiation of tracking will
%remains in the game)

%% Defining based on when they started
z = 0;

for i=1:length(ID_splitTables)
    if any(ID_splitTables{i,1}.frame>100) && any(ID_splitTables{i,1}.frame<960 )
        z = z + 1;
        frontier_table{z} = ID_splitTables{i};
    end
end

%% Defining based on where they started
% % Define the circular area
% yCenter_1 = 0;   % x-coordinate of the center
% xCenter_1 = 0;   % y-coordinate of the center
% 
% radius = 15;    % radius of the circle
% 
% for i=1:length(ID_splitTables)
%     % Calculate the distance between the center of the circle and the point
%     distance_1 = sqrt((ID_splitTables{i}.spinepoint_x_6_conv(3) - xCenter_1)^2 + (ID_splitTables{i}.spinepoint_y_6_conv(3) - yCenter_1)^2);
% 
% 
%     % Check if the point is inside the circle
%     if radius >= distance_1
%         z=z+1;
%         frontier_table{1,z} =ID_splitTables{i};
%     end
% 
% end
% end
