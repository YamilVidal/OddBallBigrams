function [] = ShowWord( E, w )
%SHOWWORD Summary of this function goes here
%   Detailed explanation goes here

[~, cy] = WindowCenter(E.screen.theWindow);

inx = (E.screen.res(1) - size(E.Stim.I{w},2) - size(E.Stim.I{w},2) - size(E.Stim.I{w},2))/2;

pos = [inx;
    cy - 125;
    inx + size(E.Stim.I{w},2);
    cy + 125];

Screen('DrawTexture', E.screen.theWindow, E.Stim.Char{w},[],pos);

pos = [pos(3);
    pos(2);
    pos(3) + size(E.Stim.I{w},2);
    pos(4)];

Screen('DrawTexture', E.screen.theWindow, E.Stim.Char{w},[],pos);

pos = [pos(3);
    pos(2);
    pos(3) + size(E.Stim.I{w},2);
    pos(4)];

Screen('DrawTexture', E.screen.theWindow, E.Stim.Char{w},[],pos);

Screen('Flip', E.screen.theWindow);

%WaitSecs(B.PresT)

%Screen('Flip', B.theWindow);
end

