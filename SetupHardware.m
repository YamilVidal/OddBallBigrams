%% Screen and Audio parameters
screenN     = max(Screen('Screens'));  % screen where the experiment is shown
screenN     = 1;
%res         = [1920 1080];
res         = [1024 768];
window      = 1*res;              % size of the window were the experiment is shown
rec         = [res-window res];     % position of the window where the experiment is shown
clrdepth    = 32;
nrchannels  = 2;                    % One channel only -> Mono sound.
B.textsize  = 20;                   % text size for the instructions

% Detect the code of some relevant keys
KbName('UnifyKeyNames')
c_escape  = KbName('Escape');
c_space   = KbName('space');
c_ctrl    = KbName('LeftControl');
c_alt     = KbName('LeftAlt');
c_ans1key = KbName('z');
c_ans2key = KbName('m');

% EyeTracker
if useET
    tetio_init();
    trackerId = 'TT120-208-10200804';
    tetio_connectTracker(trackerId)
    currentFrameRate = tetio_getFrameRate;
    if not(currentFrameRate==60),error('ET sampling rate not 60'),end
    disp('eyetracker OK')
    tetio_startTracking;
end

% Store the useful information
InitializePsychSound; % Ini Sound
info.audio.nchannels    = nrchannels;
info.audio.version      = PsychPortAudio('Version');
info.audio.oldlevel     = PsychPortAudio('Verbosity',0);
info.audio.count        = PsychPortAudio('GetOpenDeviceCount');
info.audio.devices      = PsychPortAudio('GetDevices');
info.screen.resolution  = res;
info.screen.windowsize  = window;
info.screen.rec         = rec;
info.sbj                = sbj;
