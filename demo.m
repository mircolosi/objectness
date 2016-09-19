clc; clear; close all;
cd '/home/mafra/Desktop/n01621127';
pwd
fid = fopen('images.txt');

i = 1;
tline = fgets(fid);
% tline ='./n03425595_1041.JPEG '
mkdir('../heatmaps_mat/');
mkdir('../heatmaps_fig/');

while ischar(tline)
% while i<=1
    
    [path,name,ext]=fileparts(tline);
    [~,class,~]=fileparts(path);
    %name = strread(tline, '%s', 'delimiter','.JPEG');
    %%name = strsplit(tline, '.JPEG');
    %name = name{2};
    %%disp(name)
    %name = strread(name, '%s', 'delimiter','/');
    %%name = strsplit(name,'/');
    %name = name{2};
    %%disp(name)
    %i = i+1;
    
    %imagename = tline(:,1:end-1);
    imagename = [class '/' name '.' ext];
    
    imgExample = imread(imagename);
    
    info=imfinfo(imagename);
    if info.FileSize/1024 >= 350
        imgExample = imresize(imgExample, 0.5);
        disp('resized.')
    end
    
    %%disp(tline)
    %imgExample = imread('val/ILSVRC2010_val_00000009.JPEG');
    boxes = runObjectness(imgExample,10000);
    objHeatMap = computeObjectnessHeatMap(imgExample,boxes);
    H = gcf;
    
    class = strread(name, '%s', 'delimiter','_');
    class = class{1};
    if ~exist(['../heatmaps_fig/' class],'dir')
        mkdir(['../heatmaps_fig/' class]);
    end
    if ~exist(['../heatmaps_mat/' class],'dir')
        mkdir(['../heatmaps_mat/' class]);
    end
    
    fig_name = ['../heatmaps_fig/' class '/' name];
    saveas(H, fig_name)
    
    save(['../heatmaps_mat/' name],'objHeatMap');
    
    close all
    
    tline = fgets(fid);
%     mask = objHeatMap > 0.6*255;
%     mask = uint8(mask)*255;
%     
%     [rows, cols, val] = find(mask);
%     
%     min_rows = min(rows);
%     max_rows = max(rows);
%     min_cols = min(cols);
%     max_cols = max(cols);
%     
%     my_box = [min_cols, min_rows, max_cols, max_rows, 1];
%     
    
%     C = imfuse(imgExample, mask, 'blend');
%     figure(i+100)
%     imshow(C);
%     hold on
%     figure(i+100)
%     drawBoxes(boxes(1,:));
%     drawBoxes(my_box, [0 1 0]);
%     
%     centers = [(boxes(:,1)+boxes(:,3))/2, (boxes(:,2)+boxes(:,4))/2, boxes(:,5)];
%    
%     [a, ind] = sortrows(centers, [1,2]);
%     
%     %[a, ind] = sortrows(boxes, [1,2,3,4]);
%     
%     filtered_a = find(a(:,3) >0.9);
%     
% %     for k = 1:lenght(filtered_a)
% %         
% %     end
% 
%     figure(102)
%     pivot = 3;
%     range = filtered_a(pivot)-2:1:filtered_a(pivot)+2;
% %     
%     disp(range)
% 
%     %$drawBoxes(boxes(range,:),[0 0 1])
%     drawBoxes(boxes(filtered_a,:),[0 0 1])
%     
%     figure
%     plot(a(:,3));

end

fclose(fid)
