function [ B ] = RunTestBlock( B )
%RUNTESTBLOCK Run a block of audio stim.


%%
for w = 1:length(TestPairs)
    
    % Wait for the response
    resp = nan;
    while isnan(resp)
        press_escape(B.Keys.c_escape) % generate an error and exit is escape is pressed
        resp = giveans(B.Keys.c_ans1key,B.Keys.c_ans2key, resp);
    end
    
    % Display answer
    c    = TestPairs(w,1) < TestPairs(w,2);
    hits = ~resp == c;
    
    display(num2str(hits));
    
    % Store the response
    B.answers(w) = hits;
    WaitSecs(.5);
    
    press_escape(B.Keys.c_escape) % generate an error and exit if escape is pressed
end

NetStation('Event','Test', GetSecs, 0.001, 'bloc', 1, 'type', 'stop');

PsychPortAudio('Stop', pahandle);
PsychPortAudio('Close', pahandle);

% Instructions. Tets phase
Screen(B.theWindow,'TextSize',B.textsize);
%DrawFormattedText(B.theWindow,'Puoi prendere una piccola pausa','center','center',255);
%DrawFormattedText(theWindow,'Puoi prendere una piccola pausa \n Premi la BARRA per continuare','center','center',255);
Screen('Flip', B.theWindow);
display('End of Test Bock');

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

function response = giveans(key1,key2,response) % key response a the force choice task
[~, ~, keyCode, ~] = KbCheck;
if any(keyCode)
    key = find(keyCode);
    K1 = repmat(key1,numel(key),1)==repmat(key',1,numel(key1));
    K2 = repmat(key2,numel(key),1)==repmat(key',1,numel(key2));
    if any(any(K1)); response = 0;
    elseif any(any(K2)); response = 1;
    end
end
end