clc; clear; close all;

fid = fopen('images.txt');

i = 1;
tline = fgets(fid);
while i <= 1
    disp(tline)
    tline = fgets(fid);
    i = i+1;
    
    %imgExample = imread(tline(:,1:end-1));
    
    imgExample = imread('val/ILSVRC2010_val_00000009.JPEG');
    boxes = runObjectness(imgExample,10000);
    objHeatMap = computeObjectnessHeatMap(imgExample,boxes);
        
    mask = objHeatMap > 0.6*255;
    mask = uint8(mask)*255;
    
    [rows, cols, val] = find(mask);
    
    min_rows = min(rows);
    max_rows = max(rows);
    min_cols = min(cols);
    max_cols = max(cols);
    
    my_box = [min_cols, min_rows, max_cols, max_rows, 1];
    
    
    C = imfuse(imgExample, mask, 'blend');
    figure(i+100)
    imshow(C);
    hold on
    figure(i+100)
    drawBoxes(boxes(1,:));
    drawBoxes(my_box, [0 1 0]);
    
    centers = [(boxes(:,1)+boxes(:,3))/2, (boxes(:,2)+boxes(:,4))/2, boxes(:,5)];
   
    [a, ind] = sortrows(centers, [1,2]);
    
    %[a, ind] = sortrows(boxes, [1,2,3,4]);
    
    filtered_a = find(a(:,3) >0.9);
    
%     for k = 1:lenght(filtered_a)
%         
%     end

    figure(102)
    pivot = 3;
    range = filtered_a(pivot)-2:1:filtered_a(pivot)+2;
%     
    disp(range)

    %$drawBoxes(boxes(range,:),[0 0 1])
    drawBoxes(boxes(filtered_a,:),[0 0 1])
    
    figure
    plot(a(:,3));

end
