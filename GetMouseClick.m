starttime = GetSecs;

MousePress = 0; %initializes flag to indicate no response

while    ((GetSecs-starttime) < SOA )
%while    ((GetSecs-starttime) < 5 )
    if MousePress == 0
        [x,y,buttons] = GetMouse(); %waits for a key-press
        MousePress = any(buttons); %sets to 1 if a button was pressed
    end
    if MousePress == 1
        B.ClickTime(B.BlockCounter,w) = GetSecs-starttime;
        NetStation('Event','Clic', GetSecs, 0.001, 'bloc', B.BlockCounter, 'type', num2str(words(w)), 'strm', B.s);
        %NetStation('Event','Clic', GetSecs, 0.001, 'bloc', 1, 'type', '1');
        MousePress = 2;
    end
end