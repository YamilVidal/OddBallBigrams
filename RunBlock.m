function [ E ] = RunBlock( E )
%RUNBLOCK Run a block


%% Load stream information to send TCP/IP mark when there is a deviant

% NetStation('Event',Bt, GetSecs, 0.001, 'bloc', B.BlockCounter, 'type', 'start', 'strm', B.s);

%%
Screen(E.screen.theWindow,'TextSize',E.screen.textsize*5);
DrawFormattedText(E.screen.theWindow,'+','center','center',255);
Screen('Flip', E.screen.theWindow);
WaitSecs(E.times.SOA + rand*.5);

% NetStation('Synchronize');

for w = 1:E.times.NWords
    
%     Event = ['wr',num2str(words(w))];
%     NetStation('Event',Event, GetSecs, 0.001, 'bloc', B.BlockCounter, 'type', num2str(words(w)), 'strm', B.s);

    W = E.Stim.WordLists(E.times.BlockCounter,w);
    ShowWord(E,W);
        
    GetMouseClick;

    Screen(E.screen.theWindow,'TextSize',E.screen.textsize*5);
    DrawFormattedText(E.screen.theWindow,'+','center','center',255);
    Screen('Flip', E.screen.theWindow);
    WaitSecs(E.times.SOA + rand*.5);
    
    STOP = 0;
    STOP = press_ctrlalt(E.keys.c_alt, E.keys.c_ctrl); % if ctrl+alt are pressed, ends the Block and continues
    if STOP; break; end
    press_escape(E.keys.c_escape) % generate an error and exit if escape is pressed
end

%NetStation('Event',Bt, GetSecs, 0.001, 'bloc', B.BlockCounter, 'type', 'stop', 'strm', B.s);

%% Instructions
Screen(E.screen.theWindow,'TextSize',E.screen.textsize*2);
DrawFormattedText(E.screen.theWindow,'Puoi prendere una piccola pausa','center','center',255);
%DrawFormattedText(theWindow,'Puoi prendere una piccola pausa \n Premi la BARRA per continuare','center','center',255);
Screen('Flip', E.screen.theWindow);
display(['End of Bock ',num2str(E.times.BlockCounter)]);

E.times.BlockCounter = E.times.BlockCounter+1;

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