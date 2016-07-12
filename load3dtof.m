function D=load3dtof()
geshi={'*.dcm','Dicom image (*.dcm)';...
       '*.bmp','Bitmap image (*.bmp)';...
       '*.jpg','JPEG image (*.jpg)';...
       '*.*','All Files (*.*)'};
[FileName FilePath]=uigetfile(geshi,'Load files','*.dcm','MultiSelect','on');
if ~isequal([FileName,FilePath],[0,0]);
    FileFullName=strcat(FilePath,FileName);
    if  ~ischar(FileFullName)
        FileFullName=FileFullName([2:end 1])';
    end
else
    return;
end

n=length(FileFullName);
fp=dicomread(FileFullName{1});
D=zeros(size(fp,1),size(fp,2),n);
for i=1:n
    I=im2double(dicomread(FileFullName{i}));
    maxval=max(max(I));
    I=I./maxval;
    metadata(i)=dicominfo(FileFullName{i});
    loc=metadata(i).SliceLocation;
    D(:,:,loc+1)=I;
end

end