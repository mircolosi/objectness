% only needed if create_structGT has been run in two different steps

ws1 = load('work_space_primo.mat');
ws2 = load('work_space.mat');

start = length(ws1.all_images);
image = ws2.all_images(1);

while start>0 && strcmp(ws1.all_images(start),image)
    start = start-1;
end

ws1.all_boxes(start:end) = [];
ws1.all_images(start:end) = [];

all_b = [ws1.all_boxes; ws2.all_boxes];
all_i = [ws1.all_images; ws2.all_images];

% struct_gt = struct('boxes',all_boxes, 'img',all_images);
matrix = [all_b, all_i];

% structGT_cell = (struct2cell(struct_gt))';   %convert to a cell array
% structGT_sort = sortrows(structGT_cell, 2);
matrix_sort = sortrows(matrix, 2);


% [~, ind] = unique(structGT_sort(:, 2), 'rows');
% structGT_sort_unique = structGT_sort(ind,:);
[~,ind,~] = unique(matrix_sort(:,2));
matrix_unique = matrix_sort(ind,:);

structGT = cell2struct(matrix_unique, {'boxes','img'}, 2);

disp('Saving...');
save('Training_new/Images/structGT_sort.mat', 'structGT');