function D=stackimg()
    geshi={'*.*','All Files (*.*)'};
    [FileName FilePath]=uigetfile(geshi,'Load files','*.tif','MultiSelect','on');
    if ~isequal([FileName,FilePath],[0,0]);
        FileFullName=strcat(FilePath,FileName);
        if  ~ischar(FileFullName)
            FileFullName=FileFullName([2:end 1])';
        end
    else
        return;
    end
    n=length(FileFullName);
    if n==0
        return;
    end
    fp=imread(FileFullName{1});
    D=zeros(size(fp,1),size(fp,2),n);
    for i=1:n
        D(:,:,i)=imread(FileFullName{i});
    end
    imwrite(D(:,:,1), 'stack.tif')
    for k = 2:size(D,3)
        imwrite(D(:,:,k), 'stack.tif', 'writemode', 'append');
    end
end