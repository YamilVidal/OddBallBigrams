function [] = ShowWord( E, w)

s = E.Stim.Scale; % Font size

Words = E.Stim.Words;

Width(1) = size(E.Stim.I{Words(w,1)},2)*s;
Width(2) = size(E.Stim.I{Words(w,2)},2)*s;
Width(3) = size(E.Stim.I{Words(w,3)},2)*s;

Height(1) = size(E.Stim.I{Words(w,1)},1)*s;
Height(2) = size(E.Stim.I{Words(w,2)},1)*s;
Height(3) = size(E.Stim.I{Words(w,3)},1)*s;

[E.screen.cx, E.screen.cy] = WindowCenter(E.screen.theWindow);

inx = (E.screen.res(1) - sum(Width))/2;

pos = [inx;
    E.screen.cy - Height(1)/2;
    inx + Width(1);
    E.screen.cy + Height(1)/2];

Screen('DrawTexture', E.screen.theWindow, E.Stim.Char{Words(w,1)},[],pos);

pos = [pos(3)+1;
    E.screen.cy - Height(2)/2;
    pos(3)+1 + Width(2);
    E.screen.cy + Height(2)/2];

Screen('DrawTexture', E.screen.theWindow, E.Stim.Char{Words(w,2)},[],pos);

pos = [pos(3)+1;
    E.screen.cy - Height(3)/2;
    pos(3)+1 + Width(3);
    E.screen.cy + Height(3)/2];

Screen('DrawTexture', E.screen.theWindow, E.Stim.Char{Words(w,3)},[],pos);

% Draw lines to test centering
% Screen('DrawLine', E.screen.theWindow, [255 0 0], E.screen.res(1)/2, 1, E.screen.res(1)/2, E.screen.res(2), 1);
% Screen('DrawLine', E.screen.theWindow, [255 0 0], 1, E.screen.res(2)/2, E.screen.res(1),  E.screen.res(2)/2, 1);

Screen('Flip', E.screen.theWindow);

end