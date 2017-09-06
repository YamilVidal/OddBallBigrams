% Enter the info of the subject
prompt      = {'N:';...
    'Name:';...
    'Gender:';...
    'Age:';...
    'Handness:';...
    'Languages:';...
    'Debug';...
    'DebugAudio';...
    'EEG';...
    'EyeTracker'};

defans      = {'99';...
    'xxx';...
    'f';...
    '25' ;...
    'r';...
    'n';...
    '0';...
    '0';...
    '0';...
    '0'};

answer = inputdlg(prompt,'Subject Info',1,defans);

sbj.n       = str2double(answer{1});
sbj.name    = answer{2};
sbj.gender  = answer{3};
sbj.age     = str2double(answer{4});
sbj.hand    = answer{5};
sbj.lang    = answer{6};
debugmode   = logical(str2double(answer{7}));
debugaudio  = logical(str2double(answer{8}));
useEEG      = logical(str2double(answer{9}));
useET       = logical(str2double(answer{10}));