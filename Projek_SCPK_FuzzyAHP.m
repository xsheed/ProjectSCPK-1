function varargout = Projek_SCPK_FuzzyAHP(varargin)
% PROJEK_SCPK_FUZZYAHP MATLAB code for Projek_SCPK_FuzzyAHP.fig
%      PROJEK_SCPK_FUZZYAHP, by itself, creates a new PROJEK_SCPK_FUZZYAHP or raises the existing
%      singleton*.
%
%      H = PROJEK_SCPK_FUZZYAHP returns the handle to a new PROJEK_SCPK_FUZZYAHP or the handle to
%      the existing singleton*.
%
%      PROJEK_SCPK_FUZZYAHP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJEK_SCPK_FUZZYAHP.M with the given input arguments.
%
%      PROJEK_SCPK_FUZZYAHP('Property','Value',...) creates a new PROJEK_SCPK_FUZZYAHP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Projek_SCPK_FuzzyAHP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Projek_SCPK_FuzzyAHP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Projek_SCPK_FuzzyAHP

% Last Modified by GUIDE v2.5 03-Jul-2021 09:52:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Projek_SCPK_FuzzyAHP_OpeningFcn, ...
                   'gui_OutputFcn',  @Projek_SCPK_FuzzyAHP_OutputFcn, ...
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


% --- Executes just before Projek_SCPK_FuzzyAHP is made visible.
function Projek_SCPK_FuzzyAHP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Projek_SCPK_FuzzyAHP (see VARARGIN)

% Choose default command line output for Projek_SCPK_FuzzyAHP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Projek_SCPK_FuzzyAHP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Projek_SCPK_FuzzyAHP_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in input.
function input_Callback(hObject, eventdata, handles)
% hObject    handle to input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
co1 = str2num(get(handles.coding1,'string'));
co2 = str2num(get(handles.coding2,'string'));
co3 = str2num(get(handles.coding3,'string'));
ma1 = str2num(get(handles.math1,'string'));
ma2 = str2num(get(handles.math2,'string'));
ma3 = str2num(get(handles.math3,'string'));
te1 = str2num(get(handles.teori1,'string'));
te2 = str2num(get(handles.teori2,'string'));
te3 = str2num(get(handles.teori3,'string'));

maksCoding = 100;
maksMath = 100;
maksTheory = 100;

data = [ co1 ma1 te1
         co2 ma2 te2
         co3 ma3 te3];
     
data(:,1) = data(:,1)/maksCoding;
data(:,2) = data(:,2)/maksMath;
data(:,3) = data(:,3)/maksTheory;

relasiAntarKriteria = [ 1 3 4  
                        0 1 2
                        0 0 1];
                    
TFN = {[-100/3 0     100/3] [3/100 0     -3/100]
       [0      100/3 200/3] [3/200 3/100 0     ]
       [100/3  200/3 300/3] [3/300 3/200 3/100 ]
       [200/3  300/3 400/3] [3/400 3/300 3/200 ]};

[RasioKonsistensi] = HitungKonsistensiAHP(relasiAntarKriteria);

if RasioKonsistensi < 0.10

[bobotAntarKriteria, relasiAntarKriteria] = FuzzyAHP(relasiAntarKriteria, TFN);

 ahp = data * bobotAntarKriteria';
    for i = 1:size(ahp, 1)
        if ahp(i) < 0.79
            status = 'Tidak Lolos';
        else
            status = 'Lolos';
        end
        
 skor(i) = ahp(i);
        if i == 1
            set(handles.hasilstatus1,'string',(status));
        elseif i == 2
            set(handles.hasilstatus2,'string',(status));
        elseif i == 3
            set(handles.hasilstatus3,'string',(status));
        end
    end
    set(handles.hasilskor1,'string',(skor(1)));
    set(handles.hasilskor2,'string',(skor(2)));
    set(handles.hasilskor3,'string',(skor(3)));
end



function coding1_Callback(hObject, eventdata, handles)
% hObject    handle to coding1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coding1 as text
%        str2double(get(hObject,'String')) returns contents of coding1 as a double


% --- Executes during object creation, after setting all properties.
function coding1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coding1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function math1_Callback(hObject, eventdata, handles)
% hObject    handle to math1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of math1 as text
%        str2double(get(hObject,'String')) returns contents of math1 as a double


% --- Executes during object creation, after setting all properties.
function math1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to math1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function teori1_Callback(hObject, eventdata, handles)
% hObject    handle to teori1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of teori1 as text
%        str2double(get(hObject,'String')) returns contents of teori1 as a double


% --- Executes during object creation, after setting all properties.
function teori1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to teori1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function coding2_Callback(hObject, eventdata, handles)
% hObject    handle to coding2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coding2 as text
%        str2double(get(hObject,'String')) returns contents of coding2 as a double


% --- Executes during object creation, after setting all properties.
function coding2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coding2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function coding3_Callback(hObject, eventdata, handles)
% hObject    handle to coding3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coding3 as text
%        str2double(get(hObject,'String')) returns contents of coding3 as a double


% --- Executes during object creation, after setting all properties.
function coding3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coding3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function math2_Callback(hObject, eventdata, handles)
% hObject    handle to math2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of math2 as text
%        str2double(get(hObject,'String')) returns contents of math2 as a double


% --- Executes during object creation, after setting all properties.
function math2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to math2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function math3_Callback(hObject, eventdata, handles)
% hObject    handle to math3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of math3 as text
%        str2double(get(hObject,'String')) returns contents of math3 as a double


% --- Executes during object creation, after setting all properties.
function math3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to math3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function teori2_Callback(hObject, eventdata, handles)
% hObject    handle to teori2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of teori2 as text
%        str2double(get(hObject,'String')) returns contents of teori2 as a double


% --- Executes during object creation, after setting all properties.
function teori2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to teori2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function teori3_Callback(hObject, eventdata, handles)
% hObject    handle to teori3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of teori3 as text
%        str2double(get(hObject,'String')) returns contents of teori3 as a double


% --- Executes during object creation, after setting all properties.
function teori3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to teori3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.coding1,'String', '');
set(handles.coding2,'String', '');
set(handles.coding3,'String', '');
set(handles.math1,'String', '');
set(handles.math2,'String', '');
set(handles.math3,'String', '');
set(handles.teori1,'String', '');
set(handles.teori2,'String', '');
set(handles.teori3,'String', '');
set(handles.hasilskor1,'String', '');
set(handles.hasilskor2,'String', '');
set(handles.hasilskor3,'String', '');
set(handles.hasilstatus1,'String', '');
set(handles.hasilstatus2,'String', '');
set(handles.hasilstatus3,'String', '');
