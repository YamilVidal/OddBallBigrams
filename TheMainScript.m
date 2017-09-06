% 06/09/2016 - Created by Yamil Vidal @ L2R Lab, SISSA

function TheMainScript
%% ========================================================================
%% Parameters

% Experiment name
exp_name = 'OddBallBigrams';

GetSubInfo;

% Name of the output file
filename = [exp_name '-' num2str(sbj.n) '-' sbj.name '-' datestr(now, 'dd-mm-yyyy')];

%% Timing
t1 = 1.0; % time for the trial number
t2 = 0.5; % time from the question to the onset of the test word
t3 = 0.5; % time between test words
t4 = 0.3; % time after they give an answer and before moving to the next trial

RSTime       = 60; % Resting State time. Two blocks of this *4 will be run
RestingPause = 20; % Pause in seconds between Resting State Blocks

%%
SetupHardware;
IniHardware;
PreLoadText;
GraphicParams;
SetFolders;
PreLoadStim;
Bsetup;

%%

ListenChar(2);


%% -------------------------------------------------------------------------
%  Start to run the experiment
try
    %HideCursor
    
    %%
    % Connect to NetStation and start recording if successfull
    if useEEG
        EEGstatus = NetStation('Connect', '10.0.0.46');
        if EEGstatus; error('Connection to NetStation failed'); end
        NetStation('StartRecording');
    end
    
    %%
    RestingBlock;
    
    %% Standard block
    DrawFormattedText(theWindow, t_blocks,'center','center',255);
    Screen('Flip', theWindow);
    
    %WaitSecs(pausetime);
    display('Ready to start');
    
    press_space(c_space) % waits till space is pressed
    display('Start Standard');
    
    pickstream_std = randperm(20,1);
    B.s             = pickstream_std;
    B.isSTD         = 1;
    B.Stim          = Stim;
    B.StimCat       = StimCat;
    
    B = RunBlock( B );
    
    WaitSecs(20);
    
    %% Deviant blocks
    pickstream_dev = randperm(20,12);
    B.isSTD        = 0;
    
    for b = pickstream_dev
        B.BlockCounter = B.BlockCounter + 1;
        B.s            = b;
        
        display(['Start Deviant Block: ', num2str(B.BlockCounter-1)]);
        
        B = RunBlock( B );
        
        WaitSecs(20);
        if ~mod(B.BlockCounter-1,4); display('Press space to continue'); press_space(c_space); end
    end
    
    %% Test Block
    
    display('Ready for Test Block. Press Space to start.');
    press_space(c_space);
    
    B = RunTestBlock( B );
    
    %% CleanUp
    NetStation('StopRecording');
    NetStation('Disconnect');
    
    if B.useET
        tetio_stopTracking;
        tetio_disconnectTracker;
        tetio_cleanUp;
    end
    
    Screen('CloseAll');
    ShowCursor;
    ListenChar;
    
    DisplayAllAnswers;
    
    %% ---------------------------------------------------------------------
    % 4. Save the data
    
    save(fullfile(p_data,filename), 'B', 'info', 'pickstream_std', 'pickstream_dev');
    
    % ---------------------------------------------------------------------
    % 
    disp('The experiment finished correctly')
    disp(['The data was saved in ' filename])
    
    
    %%
    %clear all; close all;
    
catch err
    if exist([filename '.mat'],'var')==2; filename = [filename '_i']; end
    save(fullfile(pwd,'Crashed',filename))
    disp('There was an arror')
    display(err);
    display(err.message);
    display(err.stack);
    Screen('CloseAll');
    ShowCursor;
    ListenChar;
    
    NetStation('StopRecording');
    NetStation('Disconnect');
    
    if B.useET
        tetio_stopTracking;
        tetio_disconnectTracker;
        tetio_cleanUp;
    end
    
    if exist('pahandle','var')
        PsychPortAudio('Stop', pahandle);
        PsychPortAudio('Close', pahandle);
    end
    
    %clear; close all
end

%% ========================================================================
%% Auxiliar Functions

function press_escape(thekey) % if escape is pressed it generates an error
[~, ~, keyCode, ~] = KbCheck;
if any(keyCode)
    key = find(keyCode);
    K = repmat(thekey,numel(key),1)==repmat(key',1,numel(thekey));
    if any(any(K))
        NetStation('StopRecording');
        NetStation('Disconnect');
        
        if B.useET
            tetio_stopTracking;
            tetio_disconnectTracker;
            tetio_cleanUp;
        end
        
        error('Exp:Aborted', 'Escape was press')
    end
end

function press_space(thekey) % stay in the loop (wait) till space is pressed
while 1
    [~, ~, keyCode, ~] = KbCheck;
    if any(keyCode)
        key = find(keyCode);
        K = repmat(thekey,numel(key),1)==repmat(key',1,numel(thekey));
        if any(any(K))
            break
        end
    end
end

