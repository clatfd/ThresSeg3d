function bwimg=im2bw3D(img,thres)
bwimg=zeros(size(img));
for i=1:size(img,3)
    img(:,:,i)=img(:,:,i)./max(max(img(:,:,i)));
    bwimg(:,:,i)=im2bw(img(:,:,i),thres);
end