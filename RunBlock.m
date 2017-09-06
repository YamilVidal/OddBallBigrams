function [ B ] = RunBlock( B )
%RUNBLOCK Run a block of audio stim.


%% Load stream information to send TCP/IP mark when there is a deviant

if B.isSTD, sf = 'STD'; else sf = 'DEV'; end
if B.isSTD, Bt = 'Lear'; else Bt = 'Devi'; end

NetStation('Event',Bt, GetSecs, 0.001, 'bloc', B.BlockCounter, 'type', 'start', 'strm', B.s);
load(fullfile(B.p_streams_I,sf,['S_',num2str(B.s),'.mat']));

B.WordLists(B.BlockCounter, 1:length(words)) = words;

%% Start playing the familiarization sound
Screen(B.theWindow,'TextSize',B.textsize*4);
DrawFormattedText(B.theWindow,'+','center','center',255);
Screen('Flip', B.theWindow);
pahandle = PsychPortAudio('Open', [], [], 1, B.fs  , 2);

NetStation('Synchronize');

for w = 1:length(words)
    PsychPortAudio('FillBuffer', pahandle, B.Stim{words(w)}'*.5);
    
    Event = ['wr',num2str(words(w))];
    NetStation('Event',Event, GetSecs, 0.001, 'bloc', B.BlockCounter, 'type', num2str(words(w)), 'strm', B.s);
    PsychPortAudio('Start', pahandle, 1, 0, 1);
    
    if B.useET
        [~, ~, ~,~] = tetio_readGazeData;  % ET buffer cleaning
    end
    
    SOA = .650 + 1.8 + .4*rand;
    GetMouseClick;
    
    if B.useET
        [lefteye, righteye, timestamp] = tetio_readGazeData;
        
        B.ET.Left(B.BlockCounter,w,1:size(lefteye,1),:)    = lefteye;
        B.ET.Right(B.BlockCounter,w,1:size(lefteye,1),:)   = righteye;
        B.ET.Timestamp(B.BlockCounter,w,1:size(lefteye,1)) = timestamp;
    end
    
    STOP = 0;
    STOP = press_ctrlalt(B.Keys.c_alt, B.Keys.c_ctrl); % if ctrl+alt are pressed it moves to the test phase
    if STOP; break; end
    press_escape(B.Keys.c_escape) % generate an error and exit if escape is pressed
end

NetStation('Event',Bt, GetSecs, 0.001, 'bloc', B.BlockCounter, 'type', 'stop', 'strm', B.s);

PsychPortAudio('Stop', pahandle);
PsychPortAudio('Close', pahandle);

% Instructions. Tets phase
Screen(B.theWindow,'TextSize',B.textsize);
DrawFormattedText(B.theWindow,'Puoi prendere una piccola pausa','center','center',255);
%DrawFormattedText(theWindow,'Puoi prendere una piccola pausa \n Premi la BARRA per continuare','center','center',255);
Screen('Flip', B.theWindow);
display('End of Bock');

end

function press_escape(thekey) % if escape is pressed it generates an error
[~, ~, keyCode, ~] = KbCheck;
if any(keyCode)
    key = find(keyCode);
    K = repmat(thekey,numel(key),1)==repmat(key',1,numel(thekey));
    if any(any(K))
        NetStation('StopRecording');
        NetStation('Disconnect');
        error('Exp:Aborted', 'Escape was press')
    end
end
end

function var = press_ctrlalt(altkey,ctrlkey) % If ctrl + alt are pressed it set the variable out to 0
[~, ~, keyCode, ~] = KbCheck;
%if any(keyCode)
key = find(keyCode);
K1 = repmat(altkey,numel(key),1)  == repmat(key',1,numel(altkey));
K2 = repmat(ctrlkey,numel(key),1) == repmat(key',1,numel(ctrlkey));
if any(any(K1)) &&  any(any(K2))
    var = 1;
else
    var = 0;
end
%end
end