function varargout = Modul2(varargin)
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
function gui_OpeningFcn(hObject, ~, handles, varargin)
handles.output = hObject;
global validasi;
global validasi2;
global nilai;
global v_gray;
global filter;
v_gray = 0;
nilai = 0;
validasi = 0;
validasi2 = 0;
filter = 0;
% Update struktur handle
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(~, ~, handles) 
varargout{1} = handles.output;


% --- Fungsi saat menekan tombol B_import.
function B_import_Callback(hObject, ~, handles)
global gambar_ori;
global validasi;
[name_file1,name_path1] = uigetfile( ...
    {'*.bmp;*.jpg;','Files of type (*.bmp,*.jpg)';},...
    'Open Images');
if ~isequal(name_file1,0)
    gambar_ori = imread(fullfile(name_path1,name_file1));
    guidata(hObject,handles);
    axes(handles.G1);
    imshow(gambar_ori);
    validasi = 1;
else
    return;
end

% --- Fungsi saat menekan tombol salin
function B_grayscale_Callback(~, ~, handles)
global gambar_ori;
global gambar_grayscale;
global gambar_b;
global validasi;
global validasi2;
global v_gray;
cek_kosong = isempty(get(handles.G1, 'Children'));
if (cek_kosong == 1)
    errordlg('Gambar Belum Dimasukan! Silahkan Klik Pilih Gambar...','Terjadi kesalahan');
elseif (validasi2 == 1 || validasi2 == 3)
    gambar_b = rgb2gray(gambar_b);
    axes(handles.G2);
    imshow(gambar_b);
    validasi = 1;
    v_gray = 1;
elseif (validasi == 1)
    gambar_grayscale = rgb2gray(gambar_ori);
    axes(handles.G2);
    imshow(gambar_grayscale);
    validasi = 2;
    v_gray = 1;
elseif (v_gray == 1)
    errordlg('Gambar Sudah Di Grayscale','Terjadi kesalahan');
end

% --- Fungsi saat menekan tombol keluar
function B_keluar_Callback(~, ~, ~)
close();

% --- Fungsi saat menekan tombol reset
function B_reset_Callback(~, ~, handles)
global validasi;
global nilai;
global v_gray;
global filter;
global perubahan_slider;
filter = 0;
v_gray = 0;
validasi = 0;
nilai = 0;
perubahan_slider = 0;
n_brightness = sprintf('%d', nilai);
set(handles.n_b, 'String', n_brightness);
set(handles.RB_tumbal, 'value',1);
set(handles.Slider_brightness, 'value',0);
cla(handles.G1);
cla(handles.G2);
cla(handles.G3);


% --- Executes on button press in B_biner.
function B_biner_Callback(~, ~, handles)
gambar_olahan=getimage(handles.G2);
cek_kosong = isempty(get(handles.G2, 'Children'));
if (cek_kosong == 1)
    errordlg('Lakukan Proses Grayscale!','Terjadi kesalahan');
else
    gambar_biner = imbinarize(gambar_olahan);

    axes(handles.G3);
    imshow(gambar_biner);
end


% --- Executes on button press in B_noise.
function B_noise_Callback(~, ~, handles)
global gambar_ori;
global validasi2;
global gambar_grayscale;
global gambar_noise;
global gambar_b;
global validasi;
cek_kosong = isempty(get(handles.G1, 'Children'));
if (cek_kosong == 1)
    errordlg('Gambar Belum Dimasukan! Silahkan Klik Pilih Gambar...','Terjadi kesalahan');
elseif (validasi2 == 1 || validasi2 == 2 || validasi2 == 3)
    gambar_b = imnoise(gambar_b,'salt & pepper',0.02);
    axes(handles.G2);
    gambar_noise = gambar_b;
    imshow(gambar_noise);
    validasi = 3;
elseif (validasi == 1)
    gambar_noise = imnoise(gambar_ori,'salt & pepper',0.02);
    axes(handles.G2);
    imshow(gambar_noise);
    validasi = 3;
elseif (validasi == 2)
    gambar_noise = imnoise(gambar_grayscale,'salt & pepper',0.02);
    axes(handles.G2);
    imshow(gambar_noise);
    validasi = 3;
end


% --- Executes on button press in B_lpf.
function B_lpf_Callback(~, ~, handles)
global filter;
gambar_olahan=getimage(handles.G2);
KL_tiga = 1 *ones(3)/9;
KL_lima = 1 *ones(5)/25;
KL_tujuh = 1 *ones(7)/49;
KL_sembilan = 1 *ones(9)/81;

cek_kosong = isempty(get(handles.G2, 'Children'));
if (cek_kosong == 1)
    errordlg('Lakukan Proses Grayscale!','Terjadi kesalahan');
else
    gambar_dobel = im2double(gambar_olahan);
    if (filter == 3)
        gambar_low = filter2(KL_tiga, gambar_dobel);
    elseif (filter == 5)
        gambar_low = filter2(KL_lima, gambar_dobel);
    elseif (filter == 7)
        gambar_low = filter2(KL_tujuh, gambar_dobel);
    elseif (filter == 9)
        gambar_low = filter2(KL_sembilan, gambar_dobel);
    else
        errordlg('Pilih Ukuran Matriks Terlebih Dahulu!','Terjadi kesalahan');
        return
    end
    
    axes(handles.G3);
    imshow(gambar_low);
end



% --- Executes on button press in B_median.
function B_median_Callback(~, ~, handles)
global filter;
gambar_olahan=getimage(handles.G2);
cek_kosong = isempty(get(handles.G2, 'Children'));
if (cek_kosong == 1)
    errordlg('Lakukan Proses Grayscale!','Terjadi kesalahan');
else
    if (filter == 0)
        errordlg('Pilih Ukuran Matriks Terlebih Dahulu!','Terjadi kesalahan');
    else
        gambar_med = medfilt2(gambar_olahan,[filter filter]);
        axes(handles.G3);
        imshow(gambar_med);
    end
end


% --- Executes on button press in B_hpf.
function B_hpf_Callback(~, ~, handles)
global filter;
gambar_olahan=getimage(handles.G2);
KH_tiga = -1 *ones(3);
KH_tiga(2,2) = 8;
KH_lima = -1 *ones(5);
KH_lima(3,3) = 24;
KH_tujuh = -1 *ones(7);
KH_tujuh(4,4) = 48;
KH_sembilan = -1 *ones(9);
KH_sembilan(5,5) = 80;

cek_kosong = isempty(get(handles.G2, 'Children'));
if (cek_kosong == 1)
    errordlg('Lakukan Proses Grayscale!','Terjadi kesalahan');
else
    gambar_dobel = im2double(gambar_olahan);
    if (filter == 3)
        gambar_high = filter2(KH_tiga, gambar_dobel);
    elseif (filter == 5)
        gambar_high = filter2(KH_lima, gambar_dobel);
    elseif (filter == 7)
        gambar_high = filter2(KH_tujuh, gambar_dobel);
    elseif (filter == 9)
        gambar_high = filter2(KH_sembilan, gambar_dobel);
    else
        errordlg('Pilih Ukuran Matriks Terlebih Dahulu!','Terjadi kesalahan');
        return
    end
    
    axes(handles.G3);
    imshow(gambar_high);
end

% --- Executes during object creation, after setting all properties.
function E_matriks_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes when selected object is changed in BG_filter.
function BG_filter_SelectionChangedFcn(~, eventdata, handles)
global filter
cek_kosong = isempty(get(handles.G1, 'Children'));
cek_kosong2 = isempty(get(handles.G2, 'Children'));
if (cek_kosong == 1)
    errordlg('Gambar Belum Dimasukan! Silahkan Klik Pilih Gambar...','Terjadi kesalahan');
    set(handles.RB_tumbal, 'value',1);
elseif (cek_kosong2 == 1)
    errordlg('Salin Gambar Terlebih Dahulu!','Terjadi kesalahan');
    set(handles.RB_tumbal, 'value',1);
else
RB =get(eventdata.NewValue,'tag');
switch RB
     case 'RB_tiga'
        filter = 3;
     case 'RB_lima'
        filter = 5;
     case 'RB_tujuh'
        filter = 7;
     case 'RB_sembilan'
        filter = 9;
end
end


% --- Executes on slider movement.
function Slider_brightness_Callback(hObject, ~, handles)
global gambar_ori;
global gambar_grayscale;
global gambar_b;
global gambar_noise
global nilai;
global validasi;
global validasi2;
global perubahan_slider;
perubahan_slider = get(hObject, 'Value');
cek_kosong = isempty(get(handles.G1, 'Children'));
if (cek_kosong == 1)
    errordlg('Gambar Belum Dimasukan! Silahkan Klik Pilih Gambar...','Terjadi kesalahan');
    set(handles.Slider_brightness, 'value',0);
elseif (validasi == 1)
    gambar_b=gambar_ori;
    gambar_b=gambar_b+perubahan_slider;
    axes(handles.G2);
    imshow(gambar_b);
    nilai = round(perubahan_slider);
    n_brightness = sprintf('%d', nilai);
    set(handles.n_b, 'String', n_brightness);
    validasi  = 1;
    validasi2 = 1;
elseif (validasi == 2)
    gambar_b=gambar_grayscale;
    gambar_b=gambar_b+perubahan_slider;
    axes(handles.G2);
    imshow(gambar_b);
    validasi = 2;
    nilai = round(perubahan_slider);
    n_brightness = sprintf('%d', nilai);
    set(handles.n_b, 'String', n_brightness);
    validasi2 = 2;
elseif (validasi == 3)
    gambar_b=gambar_noise;
    gambar_b=gambar_b+perubahan_slider;
    axes(handles.G2);
    imshow(gambar_b);
    validasi = 3;
    nilai = round(perubahan_slider);
    n_brightness = sprintf('%d', nilai);
    set(handles.n_b, 'String', n_brightness);
    validasi2 = 3;
end

% --- Executes during object creation, after setting all properties.
function Slider_brightness_CreateFcn(hObject, ~, ~)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
