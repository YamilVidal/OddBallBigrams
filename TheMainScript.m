% 06/09/2016 - Created by Yamil Vidal @ L2R Lab, SISSA

function TheMainScript
%% Parameters

% Experiment name
E.exp_name = 'OddBallBigrams';

GetSubInfo;

% Name of the output file
E.filename = [E.exp_name '-' num2str(E.sbj.n) '-' E.sbj.name '-' datestr(now, 'dd-mm-yyyy')];

%% Timing

E.times.NBlocks = 3; % Number of Blocks
E.times.NWords  = 200;

E.times.PresT = 0.1; % time from the question to the onset of the test word
E.times.RespT = 1.5; % time to give response
E.times.SOA   = 0.5; % Actual SOA is this plus rand from 0 to .5. This in addition to RespT.

E.times.RSTime       = 60; % Resting State time. Two blocks of this *4 will be run
E.times.RestingPause = 20; % Pause in seconds between Resting State Blocks

E.times.BlockCounter = 1;

E.ClickTime = nan(E.times.NBlocks,E.times.NWords);

%%
try
    SetupHardware;
    IniHardware;
    PreLoadText;
    PreLoadStim;
    
    %% Start to run the experiment
    ListenChar(2);
    
    %HideCursor
    
    %% Run Block
    
    % Print instructions
    %     DrawFormattedText(E.screen.theWindow, E.text.t_blocks,'center','center',255);
    %     Screen('Flip', E.screen.theWindow);
    
    %WaitSecs(pausetime);
    display('Ready to start');
    
    press_space(c_space) % waits till space is pressed
    display('Start!!');
    
    for b = 1:E.times.NBlocks
        E = RunBlock( E );
        WaitSecs(20);
    end
    
    %% CleanUp
    Screen('CloseAll');
    ShowCursor;
    ListenChar;
    
    % DisplayAllAnswers;
    
    %% Save the data
    
    save(fullfile(p_data,E.filename), 'E');
    
    disp('The experiment finished correctly');
    disp(['The data was saved in ' E.filename]);
    
catch err
    if exist([E.filename '.mat'],'var')==2; E.filename = [E.filename '_i']; end
    save(fullfile(pwd,'Crashed',E.filename))
    disp('There was an arror')
    display(err);
    display(err.message);
    display(err.stack);
    Screen('CloseAll');
    ShowCursor;
    ListenChar;
end

%% Auxiliar Functions

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