function varargout = Modul4(varargin)
% MODUL4 MATLAB code for Modul4.fig
%      MODUL4, by itself, creates a new MODUL4 or raises the existing
%      singleton*.
%
%      H = MODUL4 returns the handle to a new MODUL4 or the handle to
%      the existing singleton*.
%
%      MODUL4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MODUL4.M with the given input arguments.
%
%      MODUL4('Property','Value',...) creates a new MODUL4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Modul4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Modul4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Modul4

% Last Modified by GUIDE v2.5 27-Apr-2018 09:44:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Modul4_OpeningFcn, ...
                   'gui_OutputFcn',  @Modul4_OutputFcn, ...
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


% --- Executes just before Modul4 is made visible.
function Modul4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Modul4 (see VARARGIN)

% Choose default command line output for Modul4
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Modul4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Modul4_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in B_import.
function B_import_Callback(hObject, eventdata, handles)
global gambar_ori;
[name_file1,name_path1] = uigetfile( ...
    {'*.bmp;*.jpg;','Files of type (*.bmp,*.jpg)';},...
    'Open Images');
if ~isequal(name_file1,0)
    gambar_ori = imread(fullfile(name_path1,name_file1));
    guidata(hObject,handles);
    axes(handles.G1);
    imshow(gambar_ori);
else
    return;
end


% --- Executes on button press in B_keluar.
function B_keluar_Callback(hObject, eventdata, handles)
close();


% --- Executes on button press in B_reset.
function B_reset_Callback(hObject, eventdata, handles)
cla(handles.G1);
cla(handles.G2);
cla(handles.G3);
cla(handles.G4);


% --- Executes on button press in B_dilasi.
function B_dilasi_Callback(hObject, eventdata, handles)
global gambar_ori;
global dilasi;
biner = im2bw(gambar_ori,graythresh(gambar_ori) );
kernel = ones(6, 6);
dilasi = imdilate(biner, kernel);
guidata(hObject,handles);
axes(handles.G2);
imshow(dilasi);

val = sprintf('Dilasi');
set(handles.T1, 'String', val);


% --- Executes on button press in B_sobel.
function B_sobel_Callback(hObject, eventdata, handles)
global gambar_ori;

biner = im2bw(gambar_ori,graythresh(gambar_ori));
sobel_h = edge(biner,'sobel','horizontal');
sobel_v = edge(biner,'sobel','vertical');
sobel_m = imgradient(biner,'sobel');

guidata(hObject,handles);
axes(handles.G2);
imshow(sobel_h);
val = sprintf('Sobel Horizontal');
set(handles.T1, 'String', val);

guidata(hObject,handles);
axes(handles.G3);
imshow(sobel_v);
val = sprintf('Sobel Vertical');
set(handles.T2, 'String', val);

guidata(hObject,handles);
axes(handles.G4);
imshow(sobel_m);
val = sprintf('Sobel Gradient Magnitude');
set(handles.T3, 'String', val);


% --- Executes on button press in B_growing.
function B_growing_Callback(hObject, eventdata, handles)
global gambar_ori;
    
biner = im2bw(gambar_ori,graythresh(gambar_ori) );
f=double(biner);
s=255;
t=65;
if numel(s)==1
    si=f==s;
    s1=s;
else
    si=bwmorph(s,'shrink',Inf);
    j= si;
    s1=f(j);
end
ti=false(size(f));
for k=1:length(s1)
    sv=s1(k);
    s=abs(f-sv)<=t;
    ti=ti|s;
end
[g nr]=bwlabel(imreconstruct(si,ti));
guidata(hObject,handles);
axes(handles.G2);
imshow(g);
val = sprintf('Region Growing');
set(handles.T1, 'String', val);


% --- Executes on button press in B_erosi.
function B_erosi_Callback(hObject, eventdata, handles)
global gambar_ori;
global erosi;
biner = im2bw(gambar_ori,graythresh(gambar_ori) );
kernel = ones(6, 6);
erosi = imerode(biner, kernel);
guidata(hObject,handles);
axes(handles.G3);
imshow(erosi);

val = sprintf('Erosi');
set(handles.T2, 'String', val);


% --- Executes on button press in B_opening.
function B_opening_Callback(hObject, eventdata, handles)
global gambar_ori;
global opening;
biner = im2bw(gambar_ori,graythresh(gambar_ori) );
kernel = ones(3, 3);
opening = imopen(biner, kernel);
guidata(hObject,handles);
axes(handles.G2);
imshow(opening);

val = sprintf('Opening');
set(handles.T1, 'String', val);


% --- Executes on button press in B_closing.
function B_closing_Callback(hObject, eventdata, handles)
global gambar_ori;
global close;
biner = im2bw(gambar_ori,graythresh(gambar_ori) );
kernel = ones(3, 3);
close = imclose(biner, kernel);
guidata(hObject,handles);
axes(handles.G3);
imshow(close);

val = sprintf('Closing');
set(handles.T2, 'String', val);


% --- Executes on button press in B_thinning.
function B_thinning_Callback(hObject, eventdata, handles)
global gambar_ori;
global thinning;
biner = im2bw(gambar_ori,graythresh(gambar_ori) );
kernel = ones(3, 3);
thinning = bwmorph(biner, 'thin', Inf);
guidata(hObject,handles);
axes(handles.G2);
imshow(thinning);

val = sprintf('Thinning');
set(handles.T1, 'String', val);


% --- Executes on button press in B_robert.
function B_robert_Callback(hObject, eventdata, handles)
global gambar_ori;

biner = im2bw(gambar_ori,graythresh(gambar_ori));
robert_h = edge(biner,'roberts','horizontal');
robert_v = edge(biner,'roberts','vertical');
robert_m = imgradient(biner,'roberts');

guidata(hObject,handles);
axes(handles.G2);
imshow(robert_h);
val = sprintf('Robet Horizontal');
set(handles.T1, 'String', val);

guidata(hObject,handles);
axes(handles.G3);
imshow(robert_v);
val = sprintf('Robet Vertical');
set(handles.T2, 'String', val);

guidata(hObject,handles);
axes(handles.G4);
imshow(robert_m);
val = sprintf('Robet Gradient Magnitude');
set(handles.T3, 'String', val);


% --- Executes on button press in B_prewitt.
function B_prewitt_Callback(hObject, eventdata, handles)
global gambar_ori;

biner = im2bw(gambar_ori,graythresh(gambar_ori));
prewit_h = edge(biner,'prewitt','horizontal');
prewit_v = edge(biner,'prewitt','vertical');
prewit_m = imgradient(biner,'prewitt');

guidata(hObject,handles);
axes(handles.G2);
imshow(prewit_h);
val = sprintf('Prewit Horizontal');
set(handles.T1, 'String', val);

guidata(hObject,handles);
axes(handles.G3);
imshow(prewit_v);
val = sprintf('Prewit Vertical');
set(handles.T2, 'String', val);

guidata(hObject,handles);
axes(handles.G4);
imshow(prewit_m);
val = sprintf('Prewit Gradient Magnitude');
set(handles.T3, 'String', val);


% --- Executes on button press in B_canny.
function B_canny_Callback(hObject, eventdata, handles)
global gambar_ori;

biner = im2bw(gambar_ori,graythresh(gambar_ori));
canny = edge(biner,'canny');

guidata(hObject,handles);
axes(handles.G2);
imshow(canny);
val = sprintf('Canny');
set(handles.T1, 'String', val);

% --- Executes on button press in B_log.
function B_log_Callback(hObject, eventdata, handles)
global gambar_ori;

biner = im2bw(gambar_ori,graythresh(gambar_ori));
canny = edge(biner,'log');

guidata(hObject,handles);
axes(handles.G3);
imshow(canny);
val = sprintf('LOG');
set(handles.T1, 'String', val);


% --- Executes on button press in B_watershed.
function B_watershed_Callback(hObject, eventdata, handles)
global gambar_ori;

biner = im2bw(gambar_ori,graythresh(gambar_ori));
water = watershed(biner);

warna = label2rgb(water, 'spring', 'c', 'shuffle');
guidata(hObject,handles);
axes(handles.G3);
imshow(warna);
val = sprintf('Watershed');
set(handles.T2, 'String', val);
