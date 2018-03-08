function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 08-Mar-2018 19:31:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in B_import.
function B_import_Callback(hObject, eventdata, handles)
% hObject    handle to B_import (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[name_file1,name_path1] = uigetfile( ...
    {'*.bmp;*.jpg;','Files of type (*.bmp,*.jpg)';},...
    'Open Images');
if ~isequal(name_file1,0)
    handles.data1 = imread(fullfile(name_path1,name_file1));
    guidata(hObject,handles);
    axes(handles.G1);
    imshow(handles.data1);
else
    return;
end

% --- Executes on button press in B_copy.
function B_copy_Callback(hObject, eventdata, handles)
% hObject    handle to B_copy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Xc = handles.data1;
[sizex sizey sizez]= size(Xc);
    blank = zeros(sizex,sizey,sizez);
    for i=1:sizex
        for j=1:sizey
            for d=1:3
                blank(i,j,d)=Xc(i,j,d);
            end
        end
    end
    axes(handles.G2);
imshow(uint8(blank));


% --- Executes on button press in RB_red.
function RB_red_Callback(hObject, eventdata, handles)
% hObject    handle to RB_red (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RB_red
R = get(handles.RB_red, 'value');
if(R == 1)
    Xc = handles.data1;
[sizex, sizey, sizez]= size(Xc);
    blank = zeros(sizex,sizey,sizez);
    for i=1:sizex
        for j=1:sizey
            %for d=1:3
                blank(i,j,1)=Xc(i,j,1)+255;
                blank(i,j,2)=Xc(i,j,2);
                blank(i,j,3)=Xc(i,j,3);
            %end
        end
    end
    axes(handles.G3);
imshow(uint8(blank));
else
    return;
end


% --- Executes on button press in RB_green.
function RB_green_Callback(hObject, eventdata, handles)
% hObject    handle to RB_green (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RB_green
G = get(handles.RB_green, 'value');
if (G == 1)
    Xc = handles.data1;
[sizex, sizey, sizez]= size(Xc);
    blank = zeros(sizex,sizey,sizez);
    for i=1:sizex
        for j=1:sizey
            %for d=1:3
                blank(i,j,1)=Xc(i,j,1);
                blank(i,j,2)=Xc(i,j,2)+255;
                blank(i,j,3)=Xc(i,j,3);
            %end
        end
    end
    axes(handles.G3);
imshow(uint8(blank));
else
    return;
end


% --- Executes on button press in RB_blue.
function RB_blue_Callback(hObject, eventdata, handles)
% hObject    handle to RB_blue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RB_blue
B = get(handles.RB_blue, 'value');
if (B == 1)
    Xc = handles.data1;
[sizex, sizey, sizez]= size(Xc);
    blank = zeros(sizex,sizey,sizez);
    for i=1:sizex
        for j=1:sizey
            %for d=1:3
                blank(i,j,1)=Xc(i,j,1);
                blank(i,j,2)=Xc(i,j,2);
                blank(i,j,3)=Xc(i,j,3)+255;
            %end
        end
    end
    axes(handles.G3);
imshow(uint8(blank));
else
    return;
end


% --- Executes on button press in RB_cyan.
function RB_cyan_Callback(hObject, eventdata, handles)
% hObject    handle to RB_cyan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RB_cyan
C = get(handles.RB_cyan, 'value');
if (C == 1)
    Xc = handles.data1;
[sizex, sizey, sizez]= size(Xc);
    blank = zeros(sizex,sizey,sizez);
    for i=1:sizex
        for j=1:sizey
            %for d=1:3
                blank(i,j,1)=Xc(i,j,1)+255;
                blank(i,j,2)=Xc(i,j,2);
                blank(i,j,3)=Xc(i,j,3)+255;
            %end
        end
    end
    axes(handles.G3);
imshow(uint8(blank));
else
    return;
end


% --- Executes on button press in RB_magenta.
function RB_magenta_Callback(hObject, eventdata, handles)
% hObject    handle to RB_magenta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RB_magenta
M = get(handles.RB_magenta, 'value');
if (M == 1)
    Xc = handles.data1;
[sizex, sizey, sizez]= size(Xc);
    blank = zeros(sizex,sizey,sizez);
    for i=1:sizex
        for j=1:sizey
            %for d=1:3
                blank(i,j,1)=Xc(i,j,1);
                blank(i,j,2)=Xc(i,j,2)+255;
                blank(i,j,3)=Xc(i,j,3)+255;
            %end
        end
    end
    axes(handles.G3);
imshow(uint8(blank));
else
    return;
end


% --- Executes on button press in RB_yellow.
function RB_yellow_Callback(hObject, eventdata, handles)
% hObject    handle to RB_yellow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RB_yellow
Y = get(handles.RB_yellow, 'value');
if (Y == 1)
    Xc = handles.data1;
[sizex, sizey, sizez]= size(Xc);
    blank = zeros(sizex,sizey,sizez);
    for i=1:sizex
        for j=1:sizey
            %for d=1:3
                blank(i,j,1)=Xc(i,j,1)+255;
                blank(i,j,2)=Xc(i,j,2)+255;
                blank(i,j,3)=Xc(i,j,3);
            %end
        end
    end
    axes(handles.G3);
imshow(uint8(blank));
else
    return;
end
