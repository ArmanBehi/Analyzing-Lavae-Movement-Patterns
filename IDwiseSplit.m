function  ID_splitTables = IDwiseSplit(data_table)

% Group the table rows by the values in 'myColumn'
IDs = findgroups(data_table.id);

% Split the table into smaller tables based on the groups
ID_splitTables = splitapply(@(x){data_table(x,:)}, (1:height(data_table))', IDs);

