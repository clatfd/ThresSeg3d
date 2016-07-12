%Matlab code for segmentation of 3D carotid vessel by thresholding to a 3D
%TOF image
%Author: Li Chen (http://clatfd.cn)
[D,dcminfo]=load3dtof(); %Or >> load data_ori.mat
%GUI for adjusting threshold in im2bw, 
%and selecting two points(first is left-top corner, second is right-bottom
%corner) to crop, then close windows(variable stored automatically)
sliderimg(D);   
Da=D(crop(2):crop(4),crop(1):crop(3),:);    %crop
Db=im2bw3D(Da,thres);
outtotif(Db,'output_tif');    %output to tif files in folder
%save Db 'output_crop.mat';
Dc=rmsmallobj(Db,500);  %remove small(voxel < 500) and seperated part
outtotif(Dc,'output_tif_r');
%save Dc 'output_cr.mat';
D_scale=logical(resizexyz(Dc,dcminfo));
outtotif(D_scale,'output_tif_rr');