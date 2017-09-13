function [] = ShowWord( E, w)
%SHOWWORD Summary of this function goes here
%   Detailed explanation goes here

s = E.Stim.Scale;

Words = E.Stim.Words;

[~, cy] = WindowCenter(E.screen.theWindow);

inx = (E.screen.res(1) - size(E.Stim.I{Words(w,1)},2)*s - size(E.Stim.I{Words(w,2)},2)*s - size(E.Stim.I{Words(w,3)},2)*s)/2;

pos = [inx;
    cy - size(E.Stim.I{Words(w,1)},1)*s/2;
    inx + size(E.Stim.I{Words(w,1)},2)*s;
    cy + size(E.Stim.I{Words(w,1)},1)*s/2];

Screen('DrawTexture', E.screen.theWindow, E.Stim.Char{Words(w,1)},[],pos);

pos = [pos(3);
    cy - size(E.Stim.I{Words(w,2)},1)*s/2;
    pos(3) + size(E.Stim.I{Words(w,2)},2)*s;
    cy + size(E.Stim.I{Words(w,1)},1)*s/2];

Screen('DrawTexture', E.screen.theWindow, E.Stim.Char{Words(w,2)},[],pos);

pos = [pos(3);
    cy - size(E.Stim.I{Words(w,3)},1)*s/2;
    pos(3) + size(E.Stim.I{Words(w,3)},2)*s;
    cy + size(E.Stim.I{Words(w,1)},1)*s/2];

Screen('DrawTexture', E.screen.theWindow, E.Stim.Char{Words(w,3)},[],pos);

Screen('Flip', E.screen.theWindow);

%WaitSecs(E.times.PresT);
%Screen('Flip', E.screen.theWindow);
end

