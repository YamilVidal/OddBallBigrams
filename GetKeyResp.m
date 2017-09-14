function [ E ] = GetKeyResp( E, w )

starttime = GetSecs;

resp = nan; %initializes flag to indicate no response

while    ((GetSecs-starttime) < E.times.RespT )
    
    resp = giveans(E.keys.c_ans1key, E.keys.c_ans2key, resp);
    
    if ~isnan(resp)
        E.Resp(E.times.BlockCounter,w)     = resp;
        E.RespTime(E.times.BlockCounter,w) = GetSecs-starttime;
        break
    end
end

%% Auxiliary functions
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
end