function varargout = m(varargin)
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
global validasi;
global nilai;
global v_gray;
global filter;
v_gray = 0;
nilai = 0;
validasi = 0;
filter = 0;
% Update struktur handle
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Fungsi saat menekan tombol B_import.
function B_import_Callback(hObject, eventdata, handles)
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
function B_grayscale_Callback(hObject, eventdata, handles)
global gambar_ori;
global gambar_grayscale;
global gambar_b;
global validasi;
global v_gray;
cek_kosong = isempty(get(handles.G1, 'Children'));
if (cek_kosong == 1)
    errordlg('Gambar Belum Dimasukan! Silahkan Klik Pilih Gambar...','Terjadi kesalahan');
elseif (validasi == 1)
    gambar_grayscale = rgb2gray(gambar_ori);

    axes(handles.G2);
    imshow(gambar_grayscale);
    validasi = 2;
    v_gray = 1;
elseif (v_gray == 1)
    errordlg('Gambar Sudah Di Grayscale','Terjadi kesalahan');
else
    gambar_b = rgb2gray(gambar_b);

    axes(handles.G2);
    imshow(gambar_b);
    validasi = 0;
    v_gray = 1; 
end

% --- Fungsi saat menekan tombol keluar
function B_keluar_Callback(hObject, eventdata, handles)
close();

% --- Fungsi saat menekan tombol reset
function B_reset_Callback(hObject, eventdata, handles)
global validasi;
global nilai;
global v_gray;
global filter;
filter = 0;
v_gray = 0;
validasi = 0;
nilai = 0;
n_brightness = sprintf('%d', nilai);
set(handles.t_b, 'String', n_brightness);
cla(handles.G1);
cla(handles.G2);
cla(handles.G3);


% --- Executes on button press in B_biner.
function B_biner_Callback(hObject, eventdata, handles)
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
function B_noise_Callback(hObject, eventdata, handles)
global gambar_ori;
global gambar_grayscale;
global gambar_noise;
global gambar_b;
global validasi;
cek_kosong = isempty(get(handles.G1, 'Children'));
if (cek_kosong == 1)
    errordlg('Gambar Belum Dimasukan! Silahkan Klik Pilih Gambar...','Terjadi kesalahan');
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
else
    gambar_b = imnoise(gambar_b,'salt & pepper',0.02);

    axes(handles.G2);
    imshow(gambar_b);
    validasi = 0;
end


% --- Executes on button press in B_lpf.
function B_lpf_Callback(hObject, eventdata, handles)
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
    end
    
    axes(handles.G3);
    imshow(gambar_low);
end



% --- Executes on button press in B_median.
function B_median_Callback(hObject, eventdata, handles)
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
    end
    
    axes(handles.G3);
    imshow(gambar_med);
end


% --- Executes on button press in B_hpf.
function B_hpf_Callback(hObject, eventdata, handles)
% hObject    handle to B_hpf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function E_matriks_Callback(hObject, eventdata, handles)
% hObject    handle to E_matriks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of E_matriks as text
%        str2double(get(hObject,'String')) returns contents of E_matriks as a double


% --- Executes during object creation, after setting all properties.
function E_matriks_CreateFcn(hObject, eventdata, handles)
% hObject    handle to E_matriks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in B_kb.
function B_kb_Callback(hObject, eventdata, handles)
global gambar_ori;
global gambar_grayscale;
global gambar_noise;
global gambar_b;
global nilai;
global validasi;
cek_kosong = isempty(get(handles.G1, 'Children'));
if (cek_kosong == 1)
    errordlg('Gambar Belum Dimasukan! Silahkan Klik Pilih Gambar...','Terjadi kesalahan');
elseif (validasi == 1)
    gambar_b=gambar_ori;
    gambar_b=gambar_b-50;

    axes(handles.G2);
    imshow(gambar_b);
    nilai = -50;
    n_brightness = sprintf('%d', nilai);
    set(handles.t_b, 'String', n_brightness);
    validasi = 0;
elseif (validasi == 2)
    gambar_b=gambar_grayscale;
    gambar_b=gambar_b-50;

    axes(handles.G2);
    imshow(gambar_b);
    validasi = 0;
    nilai = -50;
    n_brightness = sprintf('%d', nilai);
    set(handles.t_b, 'String', n_brightness);
elseif (validasi == 3)
    gambar_b=gambar_noise;
    gambar_b=gambar_b-50;

    axes(handles.G2);
    imshow(gambar_b);
    validasi = 0;
    nilai = -50;
    n_brightness = sprintf('%d', nilai);
    set(handles.t_b, 'String', n_brightness);
else
    gambar_b=gambar_b-50;

    axes(handles.G2);
    imshow(gambar_b);
    if (nilai <= -250)
        errordlg('Gambar Dah Hitam Bro!','Terjadi kesalahan');
    else
    nilai = nilai-50;
    n_brightness = sprintf('%d', nilai);
    set(handles.t_b, 'String', n_brightness);
    end
end


% --- Executes on button press in B_tb.
function B_tb_Callback(hObject, eventdata, handles)
global gambar_ori;
global gambar_grayscale;
global gambar_b;
global nilai;
global validasi;
cek_kosong = isempty(get(handles.G1, 'Children'));
if (cek_kosong == 1)
    errordlg('Gambar Belum Dimasukan! Silahkan Klik Pilih Gambar...','Terjadi kesalahan');
elseif (validasi == 1)
    gambar_b=gambar_ori;
    gambar_b=gambar_b+50;

    axes(handles.G2);
    imshow(gambar_b);
    nilai = +50;
    n_brightness = sprintf('%d', nilai);
    set(handles.t_b, 'String', n_brightness);
    validasi = 0;
elseif (validasi == 2)
    gambar_b=gambar_grayscale;
    gambar_b=gambar_b-50;

    axes(handles.G2);
    imshow(gambar_b);
    validasi = 0;
    nilai = +50;
    n_brightness = sprintf('%d', nilai);
    set(handles.t_b, 'String', n_brightness);
else
    gambar_b=gambar_b+50;

    axes(handles.G2);
    imshow(gambar_b);
    if (nilai >= 250)
        errordlg('Gambar Dah Putih Bro!','Terjadi kesalahan');
    else
    nilai = nilai+50;
    n_brightness = sprintf('%d', nilai);
    set(handles.t_b, 'String', n_brightness);
    end
end


% --- Executes when selected object is changed in BG_filter.
function BG_filter_SelectionChangedFcn(hObject, eventdata, handles)
global filter

KH_tiga = [-1 -1 -1;-1 4 -1;-1 -1 -1];
KH_lima = [1 1 1 1 1;1 1 1 1 1;1 1 1 1 1]/25;
KH_tujuh = [1 1 1 1 1 1 1;1 1 1 1 1 1 1;1 1 1 1 1 1 1]/49;
KH_sembilan = [1 1 1 1 1 1 1 1 1;1 1 1 1 1 1 1 1 1;1 1 1 1 1 1 1 1 1]/81;


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
