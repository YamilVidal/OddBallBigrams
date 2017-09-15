function [ E ] = GetKeyRespBox( E, w )
starttime = GetSecs;
CedrusResponseBox('ResetRTTimer', E.RespBox.hdl);

while ((GetSecs-starttime) < E.times.RespT )
    RTS = CedrusResponseBox('GetButtons', E.RespBox.hdl);
    
    if ~isempty(RTS) && (strcmp(RTS.buttonID, '2.Left') || strcmp(RTS.buttonID, '6.Left')) % Check if one of the proper answer buttons has been pressed
        E.RespTime(E.times.BlockCounter,w) = RTS.rawtime;
        E.Resp(E.times.BlockCounter,w)     = strcmp(RTS.buttonID, '6.Left');
        break;
    end
end
end