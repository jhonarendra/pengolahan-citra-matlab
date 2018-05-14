function varargout = transform(varargin)
% TRANSFORM MATLAB code for transform.fig
%      TRANSFORM, by itself, creates a new TRANSFORM or raises the existing
%      singleton*.
%
%      H = TRANSFORM returns the handle to a new TRANSFORM or the handle to
%      the existing singleton*.
%
%      TRANSFORM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRANSFORM.M with the given input arguments.
%
%      TRANSFORM('Property','Value',...) creates a new TRANSFORM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before transform_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to transform_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help transform

% Last Modified by GUIDE v2.5 12-Apr-2018 21:17:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @transform_OpeningFcn, ...
                   'gui_OutputFcn',  @transform_OutputFcn, ...
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


% --- Executes just before transform is made visible.
function transform_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to transform (see VARARGIN)

% Choose default command line output for transform
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes transform wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = transform_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in dftBtn.
function dftBtn_Callback(hObject, eventdata, handles)
% hObject    handle to dftBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img
global dft
empty = isempty(get(handles.pb1, 'Children'));

if (empty == 1)
    errordlg('Gambar Belum Dimasukan! Silahkan Klik Pilih Gambar...','Terjadi kesalahan');
else 
    gray = rgb2gray(img);
    imdft = fft2(gray);
    dft = fftshift(imdft);
    guidata(hObject,handles);
    axes(handles.pb2);
    imshow(log(abs(dft)),[]);
end


% --- Executes on button press in dctBtn.
function dctBtn_Callback(hObject, eventdata, handles)
% hObject    handle to dctBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img
global dct
empty = isempty(get(handles.pb1, 'Children'));

if (empty == 1)
    errordlg('Gambar Belum Dimasukan! Silahkan Klik Pilih Gambar...','Terjadi kesalahan');
else 
    gray = rgb2gray(img);
    dct = dct2(gray);
    guidata(hObject,handles);
    axes(handles.pb2);
    imshow(log(abs(dct)),[]);
end

% --- Executes on button press in fftBtn.
function fftBtn_Callback(hObject, eventdata, handles)
% hObject    handle to fftBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img
global fft;
empty = isempty(get(handles.pb1, 'Children'));

if (empty == 1)
    errordlg('Gambar Belum Dimasukan! Silahkan Klik Pilih Gambar...','Terjadi kesalahan');
else 
    gray = rgb2gray(img);
    imfft = fft2(gray);
    %ab = abs(imdft);
    fft = fftshift(imfft);
    guidata(hObject,handles);
    axes(handles.pb2);
    imshow(log(1+abs(fft)),[]);
end


% --- Executes on button press in waveletBtn.
function waveletBtn_Callback(hObject, eventdata, handles)
% hObject    handle to waveletBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img
global dwt;
empty = isempty(get(handles.pb1, 'Children'));

if (empty == 1)
    errordlg('Gambar Belum Dimasukan! Silahkan Klik Pilih Gambar...','Terjadi kesalahan');
else 
    gray = rgb2gray(img);
    dwt = dwt2(gray,'haar');
    guidata(hObject,handles);
    axes(handles.pb2);
    imshow(dwt);
end



% --- Executes on button press in invDFTBtn.
function invDFTBtn_Callback(hObject, eventdata, handles)
% hObject    handle to invDFTBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dft; 

empty = isempty(get(handles.pb2, 'Children'));

if (empty == 1)
    errordlg('Gambar Belum Dimasukan! Silahkan Klik Pilih Gambar...','Terjadi kesalahan');
else             
    F = ifftshift(dft); 
    invdft = ifft2(F);
    guidata(hObject,handles);
    axes(handles.pb3);
    imshow(invdft,[]);
end


% --- Executes on button press in invDCTBtn.
function invDCTBtn_Callback(hObject, eventdata, handles)
% hObject    handle to invDCTBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dct; 

empty = isempty(get(handles.pb2, 'Children'));

if (empty == 1)
    errordlg('Gambar Belum Dimasukan! Silahkan Klik Pilih Gambar...','Terjadi kesalahan');
else             
    invdct = idct2(dct);
    guidata(hObject,handles);
    axes(handles.pb3);
    imshow(invdct,[]);
end

% --- Executes on button press in invFFTBtn.
function invFFTBtn_Callback(hObject, eventdata, handles)
% hObject    handle to invFFTBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fft; 

empty = isempty(get(handles.pb2, 'Children'));

if (empty == 1)
    errordlg('Gambar Belum Dimasukan! Silahkan Klik Pilih Gambar...','Terjadi kesalahan');
else             
    F = ifftshift(fft); 
    invfft = ifft2(F);
    guidata(hObject,handles);
    axes(handles.pb3);
    imshow(invfft,[]);
end


% --- Executes on button press in invWaveletBtn.
function invWaveletBtn_Callback(hObject, eventdata, handles)
% hObject    handle to invWaveletBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dwt; 

empty = isempty(get(handles.pb2, 'Children'));

if (empty == 1)
    errordlg('Gambar Belum Dimasukan! Silahkan Klik Pilih Gambar...','Terjadi kesalahan');
else             
    %sx = size(dwt);
    idwt = idwt2(dwt,'haar'); 
    guidata(hObject,handles);
    axes(handles.pb3);
    imshow(idwt);
end

% --- Executes on button press in openBtn.
function openBtn_Callback(hObject, eventdata, handles)
% hObject    handle to openBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
[nama_file, nama_path] = uigetfile('*.png;*.jpg;*.bmp;*.gif','Select Image');
if ~isequal (nama_file,0)
    img = imread(fullfile(nama_path,nama_file));
    guidata(hObject,handles);
    axes(handles.pb1);
    imshow(img);
else
    return;
end



% --- Executes on button press in exitBtn.
function exitBtn_Callback(hObject, eventdata, handles)
% hObject    handle to exitBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close();
