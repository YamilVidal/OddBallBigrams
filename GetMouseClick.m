starttime = GetSecs;

MousePress = 0; %initializes flag to indicate no response

while    ((GetSecs-starttime) < E.times.RespT )

    if MousePress == 0
        [x,y,buttons] = GetMouse(); %waits for a key-press
        MousePress = any(buttons); %sets to 1 if a button was pressed
    end
    if MousePress == 1
        E.RespTime(E.times.BlockCounter,w) = GetSecs-starttime;
        MousePress = 2;
        break
    end
end