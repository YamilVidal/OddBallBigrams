%% put this at the top of the script, when you set up

hdl = CedrusResponseBox('Open', 'COM4'); %open port
boxinfo = CedrusResponseBox('GetDeviceInfo', hdl); %get info from Cedrus
Stat = CedrusResponseBox('FlushEvents', hdl); %get info of button pressed


%% put this before setting up trial order

while any(Stat(1,:)) %Make sure subject has released key before starting the trial:
    Stat = CedrusResponseBox('FlushEvents', hdl);
end

%% put thus when you want to collect the response (for me, after target presentation)

Stat = CedrusResponseBox('FlushEvents', hdl);
Stat = CedrusResponseBox('ResetRTTimer', hdl);
tThr = 1.5/(24*3600); %added by Eis- this is a calculation to convert the time from 'now' into seconds. 1.5 sec is the time limite
begin = now; %added by Eis- now is a command that gives the time in days



while ~stop
    RTS = CedrusResponseBox('GetButtons', hdl);
    if ~isempty(RTS) % ~isempty checks to see if the vector is empty (button hasn't been pressed)
        if strcmp(RTS.buttonID, '1.Left') || strcmp(RTS.buttonID, '7.Left');
            TempRespTime = RTS.rawtime %added by Eis- reaction time. N.B. TempRespTime is a global variable in my script
            if strcmp(RTS.buttonID, '1.Left')
                Response=2;
            else strcmp(RTS.buttonID, '7.Left')
                Response=1;
            end
            break;
        end
    end
end