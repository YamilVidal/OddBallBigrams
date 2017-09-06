function [] = ShowWord( B, w )
%SHOWWORD Summary of this function goes here
%   Detailed explanation goes here

[~, cy] = WindowCenter(B.theWindow);

inx = (B.res(1) - size(B.I{1},2) - size(B.I{2},2) - size(B.I{3},2))/2;

pos = [inx;
    cy - 125;
    inx + size(B.I{1},2);
    cy + 125];

Screen('DrawTexture', B.theWindow, B.Char{w},[],pos);

pos = [pos(3);
    pos(2);
    pos(3) + size(B.I{2},2);
    pos(4)];

Screen('DrawTexture', B.theWindow, B.Char{w},[],pos);

pos = [pos(3);
    pos(2);
    pos(3) + size(B.I{2},2);
    pos(4)];

Screen('DrawTexture', B.theWindow, B.Char{w},[],pos);

Screen('Flip', B.theWindow);

WaitSecs(B.PresT)

Screen('Flip', B.theWindow);
end

