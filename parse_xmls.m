% untar all tar files in inputdir into outputdir
inputdir = '/home/fra/Downloads/objectness/Annotation/';
%     outputdir = '/home/fra/Downloads/objectness/bounding_boxes/';
%     if ~exist(outputdir, 'dir')
%         mkdir(outputdir);
%     end

list_tar = dir(fullfile(inputdir,'*.tar.gz'));
%     list_tar = dir(inputdir);
%     length(list_tar)
%     disp('list tar');
all_boxes = [];
all_images = [];

disp('Reading xmls...');
disp([num2str(length(list_tar)) ' tar files']);

%     for l=1:length(list_tar) %1728 - 2678; 2679 - length(list_ter)
for l=1728:length(list_tar)
% %         files = untar([inputdir list_tar(l).name],outputdir);
    files = untar([inputdir list_tar(l).name]);

    for f=1:length(files)
        xml = xml2struct(files{f});

        filename = xml.Children(4).Children.Data;
%             fprintf('filename: %s\n', filename);

        imagename = [filename '.jpg'];

        % read all the boxes (one foreach obj in img)
        objects = xml.Children(12:end);

        curr_boxes = [];
        for obj=1:2:length(objects)
            bndbox = objects(obj).Children(10);
            xmin = str2num(bndbox.Children(2).Children.Data);
            ymin = str2num(bndbox.Children(4).Children.Data);
            xmax = str2num(bndbox.Children(6).Children.Data);
            ymax = str2num(bndbox.Children(8).Children.Data);

            box = [xmin, ymin, xmax, ymax];
            curr_boxes = [curr_boxes; box];
        end

        all_boxes = [all_boxes; {curr_boxes}];
        all_images = [all_images; {imagename}];

    end

%         if ~mod(l,10)
%             disp([num2str(l) ' -  ' list_tar(l) ':   ' num2str(length(objects)/2) ' objects']);
%         end
    if ~mod(l,100)
        save('work_space.mat','all_boxes','all_images','list_tar','l');
    end

end

matrix = [all_boxes, all_images];
matrix_sort = sortrows(matrix, 2);

[~,ind,~] = unique(matrix_sort(:,2));
matrix_unique = matrix_sort(ind,:);

structGT = cell2struct(matrix_unique, {'boxes','img'}, 2);


% comment if running parse_xml in two steps
disp('Saving...');
save('Training_new/Images/structGT_sort.mat', 'structGT_sort');
