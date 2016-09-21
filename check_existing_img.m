
imagedir = '/home/mafra/Desktop/objectness/images/';        % ????????????????????????????

all_images = dir(fullfile(imagedir,'*.jpg')); % va bene anche se one folder per class
all_images = (struct2cell(all_images))';

load('Training_new/Images/structGT_sort.mat');

matrix = (struct2cell(structGT_sort))';   %convert to a cell array

i=1;
while i<=length(matrix(:,1));
    image = structTG_sort(i,2);
    if ~strmatch(image, all_images)
        matrix(i,:) = [];
        disp(['delete ' image]);
    else
        imagename = [imagedir '/' image];
        info = imfinfo(imagename);
        if info.FileSize/1024 <= 9.2
            matrix(i,:) = [];
            disp(['delete ' image]);
        else
            i=i+1;
        end
    end
end

save('Training_new/Images/structGT_final.mat', 'structGT_final');

