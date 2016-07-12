function [D dcminfo]=load3dtof()
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
Imgstack=zeros(size(fp,1),size(fp,2),n);
loc=zeros(n,2);
for i=1:n
    I=im2double(dicomread(FileFullName{i}));
    maxval=max(max(I));
    Imgstack(:,:,i)=I./maxval;
    metadata(i)=dicominfo(FileFullName{i});
    loc(i,:)=[i metadata(i).SliceLocation];
end
%sort ascend according to slice location, to place slices in correct order
locasc=sortrows(loc,2);
for i=1:n
    D(:,:,i)=Imgstack(:,:,locasc(i,1));
end

dcminfo=dicominfo(FileFullName{1});
end