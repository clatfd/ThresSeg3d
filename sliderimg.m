function varargout=sliderimg(img)
S.SystemFrameHandle=figure;
clf reset                                    
set(gcf,'name','img','numbertitle','off',...
   'unit','normalized','position',[0.2,0.1,0.5,0.5]);
% menu_file=uimenu(gcf,'Label','File(&F)');        
% menu_open_image=uimenu(menu_file,'Label','Open Images(&O)');
S.OriImageShowHandle=axes('Units','normalized',...
  'position',[0.2 0.5  .3  .4],'Color',[0.2 0.2 0.2],'Visible','off','Parent',S.SystemFrameHandle);
S.NewImageShowHandle=axes('Units','normalized',...
  'position',[0.6 0.5  .3  .4],'Color',[0.2 0.2 0.2],'Visible','off','Parent',S.SystemFrameHandle);
imshow(img(:,:,1),'Parent',S.OriImageShowHandle);
thresimg=im2bw(img(:,:,1),0.5);
imshow(thresimg,'Parent',S.NewImageShowHandle);
% slider_h = uicontrol(S.SystemFrameHandle,'Style','slider',...
% 'Tag','Slider_h', ...
% 'Position', [100 100 20 200], ...
% 'Max',1,'Min',0,'Value',0.5,...
% 'SliderStep',[0.05 0.2],...
% 'Callback',{@callback_slider_h,S});
S.h = uicontrol('style','slide',...
                 'unit','pixel',...
                 'position',[100 200 20 200],...
                 'SliderStep',[0.05 0.2],...
                 'value',0.5,...
                 'min',0,'max',1);
S.sliceslide = uicontrol('style','slide',...
                 'unit','pixel',...
                 'position',[150 100 400 20],...
                 'value',1,...
                 'SliderStep',[1 5],...
                 'min',1,'max',size(img,3));
set(S.h,'callback',{@callback_slider_h,S});
set(S.sliceslide,'callback',{@callback_slider_sliceid,S});
setappdata(gcf, 'imgsrc', img);
setappdata(gcf, 'thres_value', 0.5);
setappdata(gcf, 'sliceId', 1);
setappdata(gcf, 'clicktime', 0);
set(gcf,'WindowButtonDownFcn',@ButttonDownFcn);
end

function callback_slider_h(hObject,eventdata,handles)
slide_value=get(hObject,'Value');
assignin('base','thres',slide_value);
setappdata(gcf, 'thres_value', slide_value);
img=getappdata(gcf,'imgsrc');
sliceId=getappdata(gcf,'sliceId');
thresimg=im2bw(img(:,:,sliceId),slide_value);
axes(handles.NewImageShowHandle);
imshow(thresimg);
% disp(slide_value);
end

function callback_slider_sliceid(hObject,eventdata,handles)
sliceId=round(get(hObject,'Value'));
setappdata(gcf, 'sliceId', sliceId);
img=getappdata(gcf,'imgsrc');
axes(handles.OriImageShowHandle);
imshow(img(:,:,sliceId));
axes(handles.NewImageShowHandle);
slide_value=getappdata(gcf,'thres_value');
thresimg=im2bw(img(:,:,sliceId),slide_value);
imshow(thresimg);
%  disp(sliceId);
end


function ButttonDownFcn(src,event)
pt = get(gca,'CurrentPoint');
ptx = round(pt(1,1));
pty = round(pt(1,2));
if ptx>=0 && pty>=0
    hold on;plot(ptx,pty,'b+');
    clicktime=getappdata(gcf,'clicktime');
    if clicktime==0
        setappdata(gcf, 'clicktime', 1);
        cmd=sprintf('crop(1)=%d;',ptx);
        evalin('base',cmd);
        cmd=sprintf('crop(2)=%d;',pty);
        evalin('base',cmd);
        setappdata(gcf, 'crop', [ptx pty]);
    else
        cmd=sprintf('crop(3)=%d;',ptx);
        evalin('base',cmd);
        cmd=sprintf('crop(4)=%d;',pty);
        evalin('base',cmd);
        crop=getappdata(gcf,'crop');
        line([crop(1) ptx],[crop(2) crop(2)]);
        line([crop(1) ptx],[pty pty]);
        line([crop(1) crop(1)],[crop(2) pty]);
        line([ptx ptx],[crop(2) pty]);
    end
end
end

