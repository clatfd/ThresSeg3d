function rem=rmsmallobj(img,thres)
rem=zeros(size(img));
C = bwconncomp(img);
L = labelmatrix(C);
S = regionprops(C);
area=cat(1,S.Area);
mainid=find(area>thres);

for x=1:size(img,1)
    for y=1:size(img,2)
        for z=1:size(img,3)
            if L(x,y,z)&&size(find(mainid(:)==L(x,y,z)),1)
                rem(x,y,z)=img(x,y,z);
            end
        end
    end
end
end