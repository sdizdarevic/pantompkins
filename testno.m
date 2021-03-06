function varargout = testno(varargin)
% TESTNO M-file for testno.fig
%      TESTNO, by itself, creates a new TESTNO or raises the existing
%      singleton*.
%
%      H = TESTNO returns the handle to a new TESTNO or the handle to
%      the existing singleton*.
%
%      TESTNO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TESTNO.M with the given input arguments.
%
%      TESTNO('Property','Value',...) creates a new TESTNO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before testno_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to testno_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help testno

% Last Modified by GUIDE v2.5 11-May-2015 20:45:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @testno_OpeningFcn, ...
                   'gui_OutputFcn',  @testno_OutputFcn, ...
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


% --- Executes just before testno is made visible.
function testno_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to testno (see VARARGIN)

% Choose default command line output for testno
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes testno wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = testno_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in dugme.
function dugme_Callback(hObject, eventdata, handles)
% hObject    handle to dugme (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

y = evalin('base','ecg'); %uzimanje iz workspace-a

fs = evalin('base','fs'); %uzimanje iz workspace-a

s = evalin('base','s'); %uzimanje iz workspace-a
 
 
 
HR=[]; 
x = 1:length(y);
 

xi = x(1);
yi = y(1);
 
h = plot(xi, yi, 'YDataSource', 'yi', 'XDataSource', 'xi');
 
ylim([-1,1]);

%xlim([-0.2,800]);

 
[qrs_amplituda,qrsind,kasnjenje]= pan_tompkin(y,fs,0); %(length(yi)-1)/2
%qrsind=[0 qrsind]
%for i=1:length(qrsind)
%    pause(diff(qrsind(i)))
%    sound(s,44100)
%end

 
%for k = 1:length(qrs_indeks)
%    priv=qrs_indeks(i)
%    pause(qrs_indeks(i+1)-priv)
%    %diff????
%    sound(s,44100)
%end
    

for k = 2:length(y) 
    

    
    
xi = x(1:k);
yi = y(1:k);
if mod(k,721)==0 %moraju biti najmanje 2 RR intervala (priblizno 2 s signala) -> za treniranje (predikciju)
    
pause(721/360); %pauza 1 interval -> 2s
[qrs_amplituda,qrs_indeks,kasnjenje]= pan_tompkin(yi,fs,0); %(length(yi)-1)/2

 

set(h,'Xdata',xi,'YData',yi); 
%drawnow;
%pause(0.25);

HR=[qrs_indeks]
HR=60./diff(HR)*fs 
HR=mean(HR)
set(handles.text1,'String',num2str(HR));
sound(s,44100)
 

end
 
  
end;  
