
function varargout = remote_gui(varargin)
% REMOTE_GUI MATLAB code for remote_gui.fig
%      REMOTE_GUI, by itself, creates a new REMOTE_GUI or raises the existing
%      singleton*.
%
%      H = REMOTE_GUI returns the handle to a new REMOTE_GUI or the handle to
%      the existing singleton*.
%
%      REMOTE_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REMOTE_GUI.M with the given inputPanel arguments.
%
%      REMOTE_GUI('Property','Value',...) creates a new REMOTE_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before remote_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to remote_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help remote_gui

% Last Modified by GUIDE v2.5 09-Dec-2015 17:26:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @remote_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @remote_gui_OutputFcn, ...
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


% --- Executes just before remote_gui is made visible.
function remote_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to remote_gui (see VARARGIN)

% Choose default command line output for remote_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes remote_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = remote_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in power.
function power_Callback(hObject, eventdata, handles)
% hObject    handle to power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setCurrentChannel(5);
setLastChannel(5);
setCurrentVolume(10);
setLastVolume(5);
set(handles.infobox,'String',strcat('Channel: ' , num2str(getCurrentChannel()), ' Volume: ' , num2str(getCurrentVolume())));
global tv;
tv.channelSelected = false;
tv.volumeSelected = false;
tv.inputSelected = false;
tv.inputIndex = 1;
set(handles.inputPanel, 'Visible', 'off');
if (strcmp(get(handles.baseScreen, 'Visible'),'on'))
    set(handles.baseScreen, 'Visible', 'off');
else
    set(handles.baseScreen, 'Visible', 'on');
end
if (strcmp(get(handles.channels, 'Visible'),'on'))
    set(handles.channels, 'Visible', 'off');
end


% --- Executes on button press in menu.
function menu_Callback(hObject, eventdata, handles)
% hObject    handle to menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (strcmp(get(handles.mainMenu, 'Visible'),'on'))
    set(handles.mainMenu, 'Visible', 'off');
else
    set(handles.mainMenu, 'Visible', 'on');
end

% --- Executes on button press in channel.
function channel_Callback(hObject, eventdata, handles)
% hObject    handle to channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
setLastChannelNumber(0);
if (tv.channelSelected == false)
    tv.channelSelected = true;
else 
    tv.channelSelected = false;
end
if (strcmp(get(handles.channels, 'Visible'),'on'))
    set(handles.channels, 'Visible', 'off');
else
    set(handles.channels, 'Visible', 'on');
end


% --- Executes on button press in volume.
function volume_Callback(hObject, eventdata, handles)
% hObject    handle to volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
setLastVolumeNumber(0);
if (tv.volumeSelected == false)
    tv.volumeSelected = true;
else 
    tv.volumeSelected = false;
end

% --- Executes on button press in inputPanel.
function input_Callback(hObject, eventdata, handles)
% hObject    handle to inputPanel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (strcmp(get(handles.inputPanel, 'Visible'),'on'))
    set(handles.inputPanel, 'Visible', 'off');
    tv.inputSelected = false;
else
    set(handles.inputPanel, 'Visible', 'on');
    tv.inputSelected = true;
end

% --- Executes on button press in one.
function one_Callback(hObject, eventdata, handles)
% hObject    handle to one (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.channelSelected)
    setLastChannel(getCurrentChannel());
    tv.channelNumber = tv.lastChannelNumber * 10 + 1;
    setLastChannelNumber(tv.channelNumber);
    setCurrentChannel(tv.channelNumber);
end
if (tv.volumeSelected)
    setLastVolume(getCurrentVolume());
    tv.volumeNumber = tv.lastVolumeNumber * 10 + 1;
    setLastVolumeNumber(tv.volumeNumber);
    setCurrentVolume(tv.volumeNumber);
end
set(handles.infobox,'String',strcat('Channel: ' , num2str(getCurrentChannel()), ' Volume: ' , num2str(getCurrentVolume())));



% --- Executes on button press in two.
function two_Callback(hObject, eventdata, handles)
% hObject    handle to two (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.channelSelected)
    setLastChannel(getCurrentChannel());
    tv.channelNumber = tv.lastChannelNumber * 10 + 2;
    setLastChannelNumber(tv.channelNumber);
    setCurrentChannel(tv.channelNumber);
end
if (tv.volumeSelected)
    setLastVolume(getCurrentVolume());
    tv.volumeNumber = tv.lastVolumeNumber * 10 + 2;
    setLastVolumeNumber(tv.volumeNumber);
    setCurrentVolume(tv.volumeNumber);
end
set(handles.infobox,'String',strcat('Channel: ' , num2str(getCurrentChannel()), ' Volume: ' , num2str(getCurrentVolume())));

% --- Executes on button press in three.
function three_Callback(hObject, eventdata, handles)
% hObject    handle to three (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.channelSelected)
    setLastChannel(getCurrentChannel());
    tv.channelNumber = tv.lastChannelNumber * 10 + 3;
    setLastChannelNumber(tv.channelNumber);
    setCurrentChannel(tv.channelNumber);
end
if (tv.volumeSelected)
    setLastVolume(getCurrentVolume());
    tv.volumeNumber = tv.lastVolumeNumber * 10 + 3;
    setLastVolumeNumber(tv.volumeNumber);
    setCurrentVolume(tv.volumeNumber);
end
set(handles.infobox,'String',strcat('Channel: ' , num2str(getCurrentChannel()), ' Volume: ' , num2str(getCurrentVolume())));


% --- Executes on button press in four.
function four_Callback(hObject, eventdata, handles)
% hObject    handle to four (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.channelSelected)
    setLastChannel(getCurrentChannel());
    tv.channelNumber = tv.lastChannelNumber * 10 + 4;
    setLastChannelNumber(tv.channelNumber);
    setCurrentChannel(tv.channelNumber);
end
if (tv.volumeSelected)
    setLastVolume(getCurrentVolume());
    tv.volumeNumber = tv.lastVolumeNumber * 10 + 4;
    setLastVolumeNumber(tv.volumeNumber);
    setCurrentVolume(tv.volumeNumber);
end
set(handles.infobox,'String',strcat('Channel: ' , num2str(getCurrentChannel()), ' Volume: ' , num2str(getCurrentVolume())));

% --- Executes on button press in five.
function five_Callback(hObject, eventdata, handles)
% hObject    handle to five (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.channelSelected)
    setLastChannel(getCurrentChannel());
    tv.channelNumber = tv.lastChannelNumber * 10 + 5;
    setLastChannelNumber(tv.channelNumber);
    setCurrentChannel(tv.channelNumber);
end
if (tv.volumeSelected)
    setLastVolume(getCurrentVolume());
    tv.volumeNumber = tv.lastVolumeNumber * 10 + 5;
    setLastVolumeNumber(tv.volumeNumber);
    setCurrentVolume(tv.volumeNumber);
end
set(handles.infobox,'String',strcat('Channel: ' , num2str(getCurrentChannel()), ' Volume: ' , num2str(getCurrentVolume())));

% --- Executes on button press in six.
function six_Callback(hObject, eventdata, handles)
% hObject    handle to six (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.channelSelected)
    setLastChannel(getCurrentChannel());
    tv.channelNumber = tv.lastChannelNumber * 10 + 6;
    setLastChannelNumber(tv.channelNumber);
    setCurrentChannel(tv.channelNumber);
end
if (tv.volumeSelected)
    setLastVolume(getCurrentVolume());
    tv.volumeNumber = tv.lastVolumeNumber * 10 + 6;
    setLastVolumeNumber(tv.volumeNumber);
    setCurrentVolume(tv.volumeNumber);
end
set(handles.infobox,'String',strcat('Channel: ' , num2str(getCurrentChannel()), ' Volume: ' , num2str(getCurrentVolume())));

% --- Executes on button press in eight.
function eight_Callback(hObject, eventdata, handles)
% hObject    handle to eight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.channelSelected)
    setLastChannel(getCurrentChannel());
    tv.channelNumber = tv.lastChannelNumber * 10 + 8;
    setLastChannelNumber(tv.channelNumber);
    setCurrentChannel(tv.channelNumber);
end
if (tv.volumeSelected)
    setLastVolume(getCurrentVolume());
    tv.volumeNumber = tv.lastVolumeNumber * 10 + 8;
    setLastVolumeNumber(tv.volumeNumber);
    setCurrentVolume(tv.volumeNumber);
end
set(handles.infobox,'String',strcat('Channel: ' , num2str(getCurrentChannel()), ' Volume: ' , num2str(getCurrentVolume())));


% --- Executes on button press in seven.
function seven_Callback(hObject, eventdata, handles)
% hObject    handle to seven (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.channelSelected)
    setLastChannel(getCurrentChannel());
    tv.channelNumber = tv.lastChannelNumber * 10 + 7;
    setLastChannelNumber(tv.channelNumber);
    setCurrentChannel(tv.channelNumber);
end
if (tv.volumeSelected)
    setLastVolume(getCurrentVolume());
    tv.volumeNumber = tv.lastVolumeNumber * 10 + 7;
    setLastVolumeNumber(tv.volumeNumber);
    setCurrentVolume(tv.volumeNumber);
end
set(handles.infobox,'String',strcat('Channel: ' , num2str(getCurrentChannel()), ' Volume: ' , num2str(getCurrentVolume())));


% --- Executes on button press in nine.
function nine_Callback(hObject, eventdata, handles)
% hObject    handle to nine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.channelSelected)
    setLastChannel(getCurrentChannel());
    tv.channelNumber = tv.lastChannelNumber * 10 + 9;
    setLastChannelNumber(tv.channelNumber);
    setCurrentChannel(tv.channelNumber);
end
if (tv.volumeSelected)
    setLastVolume(getCurrentVolume());
    tv.volumeNumber = tv.lastVolumeNumber * 10 + 9;
    setLastVolumeNumber(tv.volumeNumber);
    setCurrentVolume(tv.volumeNumber);
end
set(handles.infobox,'String',strcat('Channel: ' , num2str(getCurrentChannel()), ' Volume: ' , num2str(getCurrentVolume())));

% --- Executes on button press in zero.
function zero_Callback(hObject, eventdata, handles)
% hObject    handle to zero (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.channelSelected)
    setLastChannel(getCurrentChannel());
    tv.channelNumber = tv.lastChannelNumber * 10;
    setLastChannelNumber(tv.channelNumber);
    setCurrentChannel(tv.channelNumber);
end
if (tv.volumeSelected)
    setLastVolume(getCurrentVolume());
    tv.volumeNumber = tv.lastVolumeNumber * 10;
    setLastVolumeNumber(tv.volumeNumber);
    setCurrentVolume(tv.volumeNumber);
end
set(handles.infobox,'String',strcat('Channel: ' , num2str(getCurrentChannel()), ' Volume: ' , num2str(getCurrentVolume())));

% --- Executes on button press in ccbutton.
function ccbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ccbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (strcmp(get(handles.closedCaptioning, 'Visible'),'off'))
    set(handles.closedCaptioning, 'Visible', 'on')
else
    set(handles.closedCaptioning, 'Visible', 'off')
end

% --- Executes on button press in undo.
function undo_Callback(hObject, eventdata, handles)
% hObject    handle to undo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.volumeSelected)
        curVol = getCurrentVolume();
        setCurrentVolume(getLastVolume());
        setLastVolume(curVol);
end
if (tv.channelSelected)
    curChann = getCurrentChannel();
    setCurrentChannel(getLastChannel());
    setLastChannel(curChann);
end
set(handles.infobox, 'String', strcat('Channel: ', int2str(getCurrentChannel()), ' Volume: ' , num2str(getCurrentVolume())));



% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over power.
function power_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on selection change in menuBox.
function menuBox_Callback(hObject, eventdata, handles)
% hObject    handle to menuBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns menuBox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from menuBox


% --- Executes during object creation, after setting all properties.
function menuBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to menuBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in channelList.
function channelList_Callback(hObject, eventdata, handles)
% hObject    handle to channelList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns channelList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from channelList

% --- Executes during object creation, after setting all properties.
function channelList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channelList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in leftButton.
function leftButton_Callback(hObject, eventdata, handles)
% hObject    handle to leftButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
optionsdata = ['TV  '; 'DVD ';'Xbox'];
options = cellstr(optionsdata);
setLastVolumeNumber(0);
setLastChannelNumber(0);
global tv;
if (tv.volumeSelected == true)
        setLastVolume(getCurrentVolume());
        setCurrentVolume(getCurrentVolume() - 1);
end
if (tv.channelSelected == true)
        setLastChannel(getCurrentChannel);
        setCurrentChannel(getCurrentChannel() - 1);
end
if (tv.inputSelected == true)
    if (tv.inputSelected == true)
        if (strcmp(get(handles.inputPanel,'Visible'),'on'))
            if (tv.inputIndex == 1)
                a = size(options);
                tv.inputIndex = a(1,1);
             else
            tv.inputIndex = tv.inputIndex - 1;
             end
        end
    set(handles.inputBox,'String', options(tv.inputIndex,1));
    end
end
set(handles.infobox,'String',strcat('Channel: ' , num2str(getCurrentChannel()), ' Volume: ' , num2str(getCurrentVolume())));



% --- Executes on button press in enterButton.
function enterButton_Callback(hObject, eventdata, handles)
% hObject    handle to enterButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in rightButton.
function rightButton_Callback(hObject, eventdata, handles)
% hObject    handle to rightButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
optionsdata = ['TV  '; 'DVD ';'Xbox'];
options = cellstr(optionsdata);
setLastVolumeNumber(0);
setLastChannelNumber(0);
global tv;
if (tv.volumeSelected == true)
        setLastVolume(getCurrentVolume);
        setCurrentVolume(getCurrentVolume() + 1);
end
if (tv.channelSelected == true)
        setLastChannel(getCurrentChannel);
        setCurrentChannel(getCurrentChannel() + 1);
end
if (tv.inputSelected == true)

    if (strcmp(get(handles.inputPanel,'Visible'),'on'))
        a = size(options);
        if (tv.inputIndex == a(1, 1))
            tv.inputIndex = 1;
        else
            tv.inputIndex = tv.inputIndex + 1;
        end
    end
    set(handles.inputBox,'String', options(tv.inputIndex,1));
end
set(handles.infobox,'String',strcat('Channel: ' , num2str(getCurrentChannel()), ' Volume: ' , num2str(getCurrentVolume())));
