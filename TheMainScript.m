% 06/09/2016 - Created by Yamil Vidal @ L2R Lab, SISSA

function E = TheMainScript()
%% Parameters

% Experiment name
E.exp_name = 'OddBallBigrams';

GetSubInfo;

% Name of the output file
E.filename = [E.exp_name '-' E.sbj.n '-' datestr(now, 'dd-mmm-yyyy HH:MM:SS')];

%%
try
    SetupTiming;
    SetupHardware;
    IniHardware;
    PreLoadText;
    PreLoadStim;
    
    %% Start to run the experiment
    %% Run Block
    display('Ready to start');
    press_space(E.keys.c_space) % waits till space is pressed
    display('Start!!');
    
    for b = 1:E.times.NBlocks
        E = RunBlock( E );
        if b ~= E.times.NBlocks; TakeBreak(E); end
    end
    
     %% Save the data
    
    save(fullfile(p_data,E.filename), 'E');
    
    disp('The experiment finished correctly');
    disp(['The data was saved in ' E.filename]);
    
    %% Thank participant and CleanUp
    ThankYou;
    Screen('CloseAll');
    ShowCursor;
    ListenChar;
    if E.RespBox.use; CedrusResponseBox('CloseAll'); end
    
    % DisplayAllAnswers;
    
catch err
    E.err = err;
    if exist([E.filename '.mat'],'var')==2; E.filename = [E.filename '_i']; end
    save(fullfile(pwd,'Crashed',E.filename))
    disp('There was an arror')
    display(err);
    display(err.message);
    display(err.stack);
    Screen('CloseAll');
    ShowCursor;
    ListenChar;
    if E.RespBox.use; CedrusResponseBox('CloseAll'); end
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