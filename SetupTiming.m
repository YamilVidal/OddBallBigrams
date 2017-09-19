
E.times.NBlocks = 8; % Number of Blocks
E.times.NWords  = 200; % Max is 200

% E.times.PresT = 0.1; % time from the question to the onset of the test word
E.times.RespT = 2.0; % time to give response
E.times.SOA   = 0.5; % Actual SOA is this plus rand from 0 to .5. This in addition to RespT.

E.times.Break     = 60*1.5; % Break between blocks
E.times.CountDown = 10; % Break between blocks countdown

E.times.BlockCounter = 1;

E.Resp     = nan(E.times.NBlocks,E.times.NWords);
E.RespTime = nan(E.times.NBlocks,E.times.NWords);