function [train, val] = dataset_split( list, counts_tr, counts_val )

    i=1;
    dim = length(list(:,1));
    train = [];
    val = [];
    c=1;
    
    while i<=dim
        
        disp(['i = ' num2str(i)]);
        
%         class = strsplit(list(i,2),'_');
%         c_idx = findClass(class(1));
        
        f = i + counts_tr(c_idx,2);
        train = [train; list(i:f-1,:)];
        e = f + counts_val(c_idx,2);
        val = [val; list(f:e-1,:)];
        disp(['c = ' num2str(c_idx) ':   from ' num2str(i) ' to ' num2str(e-1)]);
        disp(['   train: ' num2str(i) ' to ' num2str(f-1) ';   val: ' fnum2str() ' to ' num2str(e-1)]);
        i = e;
        
    end

end

