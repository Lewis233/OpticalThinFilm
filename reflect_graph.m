function varargout = reflect_graph(varargin)
% REFLECT_GRAPH MATLAB code for reflect_graph.fig
%      REFLECT_GRAPH, by itself, creates a new REFLECT_GRAPH or raises the existing
%      singleton*.
%
%      H = REFLECT_GRAPH returns the handle to a new REFLECT_GRAPH or the handle to
%      the existing singleton*.
%
%      REFLECT_GRAPH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REFLECT_GRAPH.M with the given input arguments.
%
%      REFLECT_GRAPH('Property','Value',...) creates a new REFLECT_GRAPH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before reflect_graph_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to reflect_graph_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help reflect_graph

% Last Modified by GUIDE v2.5 13-Mar-2019 02:44:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @reflect_graph_OpeningFcn, ...
                   'gui_OutputFcn',  @reflect_graph_OutputFcn, ...
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


% --- Executes just before reflect_graph is made visible.
function reflect_graph_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to reflect_graph (see VARARGIN)

% Choose default command line output for reflect_graph
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes reflect_graph wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = reflect_graph_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n = str2double(get(handles.edit1,'String'));
k = str2double(get(handles.edit3,'String'));
handles.n = n;
handles.k = k;
guidata(hObject, handles);
t = 0:0.1:90;
num = length(t)
y1 = zeros([1,num]);
y2 = zeros([1,num]);
for j = 1:1:num
    y=reflect(t(j),n,k);
    y1(j)=y(1);
    y2(j)=y(2);
end
% plot(handles.img,t,y1,'b',t,y2,'r');
plot(t,y1,'b',t,y2,'r');
