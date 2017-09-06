%% Resting State block
if useEEG
    DrawFormattedText(theWindow, t_rest,'center','center',255);
    Screen('Flip', theWindow);
    %WaitSecs(2);
    
    display('Ready to Start Resting. Press SPACE');
    
    press_space(c_space) % waits till space is pressed
    display('Start Resting');
    
    for re = 1:2
        Screen(B.theWindow,'TextSize',B.textsize*4);
        DrawFormattedText(theWindow,'+','center','center',255); % fixation cross
        Screen('Flip', theWindow);
        WaitSecs(2);
        
        NetStation('Event','Rest', GetSecs, 0.001, 'bloc', re, 'type', 'start', 'strm', 1);
        
        if B.useET
            [~, ~, ~,~] = tetio_readGazeData;  % ET buffer cleaning
        end
        
        for n=1:4
            WaitSecs(RSTime); % 60 secs
            NetStation('Synchronize');
        end
        
        if B.useET
            [lefteye, righteye, timestamp] = tetio_readGazeData;
            
            B.ET.Resting.Left{re}      = lefteye;
            B.ET.Resting.Right{re}     = righteye;
            B.ET.Resting.Timestamp{re} = timestamp;
        end
        
        NetStation('Event','Rest', GetSecs, 0.001, 'bloc', re, 'type', 'stop', 'strm', 1);
        
        if re
            DrawFormattedText(theWindow,'Puoi prendere una piccola pausa','center','center',255);
            Screen('Flip', theWindow);
            display('Pause Resting');
            WaitSecs(RestingPause);
            
            DrawFormattedText(theWindow,'Continuiamo','center','center',255);
            Screen('Flip', theWindow);
            WaitSecs(1);
            
            display('Pause Resting finished');
            %press_space(c_space) % waits till space is pressed
        end
    end
    
    display('End Resting. Check on subject');
end