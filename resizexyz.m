function D_scale=resizexyz(D,dcminfo)
%resize in x-y plane to fit slice thickness
x_dis=dcminfo.PixelSpacing(1);
y_dis=dcminfo.PixelSpacing(2);
z_dis=dcminfo.SliceThickness;
xo=dcminfo.Width;
yo=dcminfo.Height;

if x_dis~=z_dis || y_dis~=z_dis
    if x_dis==y_dis
        D_scale=imresize(D(:,:,:),x_dis/z_dis);
    else
        D_scale=imresize(D(:,:,:),[xo*x_dis/z_dis yo*y_dis/z_dis]);
    end
else
    D_scale=D;
end
end