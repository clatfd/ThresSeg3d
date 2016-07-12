function outtotif(img,foldername)
    if exist(foldername,'dir')==7
        rmdir(foldername, 's')
    end
    mkdir(foldername);
    n=size(img,3);
    for i=1:n    
        imwrite(img(:,:,i), [foldername '/' mat2str(i) '.tif'],'Compression','none');
    end
    imwrite(img(:,:,1), ['stack' foldername '.tif'],'Compression','none')
    for k = 2:size(img,3)
        imwrite(img(:,:,k), ['stack' foldername '.tif'], 'writemode', 'append','Compression','none');
    end
%     svname=['stack' foldername '.mat'];
%     save svname img;
end