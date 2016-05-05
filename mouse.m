function varargout = mouse(varargin)
clc;
% MOUSE MATLAB code for mouse.fig
%      MOUSE, by itself, creates a new MOUSE or raises the existing
%      singleton*.
%
%      H = MOUSE returns the handle to a new MOUSE or the handle to
%      the existing singleton*.
%
%      MOUSE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOUSE.M with the given input arguments.
%
%      MOUSE('Property','Value',...) creates a new MOUSE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mouse_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mouse_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mouse

% Last Modified by GUIDE v2.5 17-Oct-2015 13:12:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mouse_OpeningFcn, ...
                   'gui_OutputFcn',  @mouse_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before mouse is made visible.
function mouse_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mouse (see VARARGIN)

% Choose default command line output for mouse
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mouse wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mouse_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure(1)
zoom on;
imshow(ones(28*10,28*10));

oldvals = get(gcf);
oldhold = ishold(gca);

hold on;

set(gcf,'Pointer','crosshair','doublebuffer','on');
set(gca,'XLim',[0 28],'YLim',[0 28]);

[xs,ys,~] = ginput(1);
lineobj = line(xs,ys,'tag','tmpregsel');
setappdata(gcf,'lineobj',lineobj);
set(gcf,'windowbuttonmotionfcn',@wbmfcn);
set(gcf,'windowbuttondownfcn',@wbdfcn);

while ~strcmp(get(gcf,'SelectionType'),'alt') & ~strcmp(get(gcf,'SelectionType'),'open')
	drawnow;
end

xs = get(getappdata(gcf,'lineobj'),'xdata')';
ys = get(getappdata(gcf,'lineobj'),'ydata')';

set(gcf,'Pointer',oldvals.Pointer,...
	'windowbuttonmotionfcn',oldvals.WindowButtonMotionFcn,...
    'windowbuttondownfcn',oldvals.WindowButtonDownFcn,...
	'doublebuffer','on');
if ~oldhold, hold off; end 
% save('tempimage.mat','xs','ys');
% load('90_7.mat');
number=processoutput(xs, ys);
set(handles.result,'String',number);


function wbmfcn(varargin)
lineobj = getappdata(gcf,'lineobj');
if strcmp(get(gcf,'selectiontype'),'normal');
    tmpx = get(lineobj,'xdata');
    tmpy = get(lineobj,'ydata');
    a=get(gca,'currentpoint');
    set(lineobj,'xdata',[tmpx,a(1,1)],'ydata',[tmpy,a(1,2)]);
    drawnow;
else
    setappdata(gcf,'lineobj',lineobj);
end

function wbdfcn(varargin)
lineobj = getappdata(gcf,'lineobj');
if strcmp(get(gcf,'selectiontype'),'open')
    tmpx = get(lineobj,'xdata');
    tmpy = get(lineobj,'ydata');
    a=get(gca,'currentpoint');
    set(lineobj,'xdata',[tmpx,tmpx(1)],'ydata',[tmpy,tmpy(1)]);
    setappdata(gcf,'lineobj',lineobj);
    drawnow;
end


return



function result_Callback(hObject, eventdata, handles)
% hObject    handle to result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of result as text
%        str2double(get(hObject,'String')) returns contents of result as a double


% --- Executes during object creation, after setting all properties.
function result_CreateFcn(hObject, eventdata, handles)
% hObject    handle to result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
