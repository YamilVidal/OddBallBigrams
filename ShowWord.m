function [] = ShowWord( E, w)

s = E.Stim.Scale; % Font size

Words = E.Stim.Words;

[~, E.screen.cy] = WindowCenter(E.screen.theWindow);

inx = (E.screen.res(1) - size(E.Stim.I{Words(w,1)},2)*s - size(E.Stim.I{Words(w,2)},2)*s - size(E.Stim.I{Words(w,3)},2)*s)/2;

pos = [inx;
    E.screen.cy - size(E.Stim.I{Words(w,1)},1)*s/2;
    inx + size(E.Stim.I{Words(w,1)},2)*s;
    E.screen.cy + size(E.Stim.I{Words(w,1)},1)*s/2];

Screen('DrawTexture', E.screen.theWindow, E.Stim.Char{Words(w,1)},[],pos);

pos = [pos(3);
    E.screen.cy - size(E.Stim.I{Words(w,2)},1)*s/2;
    pos(3) + size(E.Stim.I{Words(w,2)},2)*s;
    E.screen.cy + size(E.Stim.I{Words(w,1)},1)*s/2];

Screen('DrawTexture', E.screen.theWindow, E.Stim.Char{Words(w,2)},[],pos);

pos = [pos(3);
    E.screen.cy - size(E.Stim.I{Words(w,3)},1)*s/2;
    pos(3) + size(E.Stim.I{Words(w,3)},2)*s;
    E.screen.cy + size(E.Stim.I{Words(w,1)},1)*s/2];

Screen('DrawTexture', E.screen.theWindow, E.Stim.Char{Words(w,3)},[],pos);

Screen('Flip', E.screen.theWindow);

end