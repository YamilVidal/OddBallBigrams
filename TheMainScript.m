% 06/09/2016 - Created by Yamil Vidal @ L2R Lab, SISSA

function TheMainScript
%% Parameters

% Experiment name
E.exp_name = 'OddBallBigrams';

GetSubInfo;

% Name of the output file
E.filename = [E.exp_name '-' num2str(E.sbj.n) '-' E.sbj.name '-' datestr(now, 'dd-mm-yyyy')];

%% Timing

E.times.NBlocks = 5; % Number of Blocks
E.times.NWords  = 200;

E.times.PresT = 0.1; % time from the question to the onset of the test word
E.times.RespT = 2.0; % time for the trial number

E.times.RSTime       = 60; % Resting State time. Two blocks of this *4 will be run
E.times.RestingPause = 20; % Pause in seconds between Resting State Blocks

E.times.BlockCounter = 1;

%%
try
SetupHardware;
IniHardware;
PreLoadText;
PreLoadStim;

%%

ListenChar(2);


%% -------------------------------------------------------------------------
%  Start to run the experiment

    %HideCursor
    
    %%
    % Connect to NetStation and start recording if successfull
    if useEEG
        EEGstatus = NetStation('Connect', '10.0.0.46');
        if EEGstatus; error('Connection to NetStation failed'); end
        NetStation('StartRecording');
    end
    
    %%
    %RestingBlock;
    
    %% Run Block
    
    % Print instructions
    DrawFormattedText(E.screen.theWindow, E.text.t_blocks,'center','center',255);
    Screen('Flip', E.screen.theWindow);
    
    %WaitSecs(pausetime);
    display('Ready to start');
    
    press_space(c_space) % waits till space is pressed
    display('Start!!');
    
    E = RunBlock( E );
    
    WaitSecs(20);
    
   
    
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

