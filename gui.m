function varargout = gui(varargin)
% Kodingan udah dari sananya
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
% Katanya - DO NOT EDIT


% --- Fungsi saat gui pertama kali muncul
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

% Update struktur handle
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Fungsi saat menekan tombol B_import.
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

% --- Fungsi saat menekan tombol salin
function B_copy_Callback(hObject, eventdata, handles)
global gambar_ori;
cek_kosong = isempty(get(handles.G1, 'Children'))
if (cek_kosong == 1)
    errordlg('Gambar Belum Dimasukan! Silahkan Klik Pilih Gambar...','Terjadi kesalahan');
else
red = gambar_ori(:,:,1);
green = gambar_ori(:,:,2);
blue = gambar_ori(:,:,3);

gambar_salin = cat(3, red, green, blue);

axes(handles.G2);
imshow(gambar_salin);
end



% --- Fungsi saat mengganti RadioButton
function RG_rgbfilter_SelectionChangedFcn(hObject, eventdata, handles)
global gambar_ori;
cek_kosong = isempty(get(handles.G1, 'Children'))
cek_kosong2 = isempty(get(handles.G2, 'Children'))
if (cek_kosong == 1)
    errordlg('Gambar Belum Dimasukan! Silahkan Klik Pilih Gambar...','Terjadi kesalahan');
    set(handles.RB_tumbal, 'value',1);
elseif (cek_kosong2 == 1)
    errordlg('Salin Gambar Terlebih Dahulu!','Terjadi kesalahan');
    set(handles.RB_tumbal, 'value',1);
else
RB =get(eventdata.NewValue,'tag');
switch RB
     case 'RB_red'
        red = gambar_ori(:,:,1);
        var = zeros(size(gambar_ori,1), size(gambar_ori,2));
        gambar_filter = cat(3, red, var, var);
        axes(handles.G3);
        imshow(gambar_filter);
     case 'RB_green'
        green = gambar_ori(:,:,2);
        var = zeros(size(gambar_ori,1), size(gambar_ori,2));

        gambar_filter = cat(3, var, green, var);

        axes(handles.G3);
        imshow(gambar_filter);
     case 'RB_blue'
        blue = gambar_ori(:,:,3);
        var = zeros(size(gambar_ori,1), size(gambar_ori,2));

        gambar_filter = cat(3, var, var, blue);

        axes(handles.G3);
        imshow(gambar_filter);
    case 'RB_cyan'
        red = gambar_ori(:,:,1);
        green = gambar_ori(:,:,2);
        var = zeros(size(gambar_ori,1), size(gambar_ori,2));

        gambar_filter = cat(3, red, green, var);

        axes(handles.G3);
        imshow(gambar_filter);
    case 'RB_magenta'
        red = gambar_ori(:,:,1);
        blue = gambar_ori(:,:,3);
        var = zeros(size(gambar_ori,1), size(gambar_ori,2));

        gambar_filter = cat(3, red, var, blue);

        axes(handles.G3);
        imshow(gambar_filter);
    case 'RB_yellow'
        red = gambar_ori(:,:,1);
        green = gambar_ori(:,:,2);
        var = zeros(size(gambar_ori,1), size(gambar_ori,2));

        gambar_filter = cat(3, red, green, var);

        axes(handles.G3);
        imshow(gambar_filter);
end
end


% --- Atasi Error callback pada RadioButton
function RB_red_Callback(hObject, eventdata, handles)
function RB_green_Callback(hObject, eventdata, handles)
function RB_blue_Callback(hObject, eventdata, handles)
function RB_cyan_Callback(hObject, eventdata, handles)
function RB_magenta_Callback(hObject, eventdata, handles)
function RB_yellow_Callback(hObject, eventdata, handles)
function RB_tumbal_Callback(hObject, eventdata, handles)


% --- Fungsi saat menekan tombol keluar
function B_keluar_Callback(hObject, eventdata, handles)
close();

% --- Fungsi saat menekan tombol reset
function B_reset_Callback(hObject, eventdata, handles)
set(handles.RB_tumbal, 'value',1);
cla(handles.G1);
cla(handles.G2);
cla(handles.G3);
