% Open the screen
PsychImaging('PrepareConfiguration');

if E.debugmode
    [E.screen.theWindow] = Screen('OpenWindow', E.screen.screenN, E.screen.bckgrnd, [0 0 200 200], E.screen.clrdepth);
else
    [E.screen.theWindow] = Screen('OpenWindow', E.screen.screenN, E.screen.bckgrnd, [], E.screen.clrdepth);
end

% Enable transparency
Screen('BlendFunction',E.screen.theWindow, 'GL_SRC_ALPHA','GL_ONE_MINUS_SRC_ALPHA');

[E.screen.cx, E.screen.cy] = WindowCenter(E.screen.theWindow);


% Set Text Format
Screen(E.screen.theWindow,'TextFont','Arial');
Screen(E.screen.theWindow,'TextSize',E.screen.textsize);

% Maximum priority level
topPriorityLevel = MaxPriority(E.screen.theWindow);
Priority(topPriorityLevel);

% Collect the time for the first flip with vbl
E.screen.vbl = Screen(E.screen.theWindow, 'Flip');

% Query the frame duration
E.screen.flipinterval = Screen('GetFlipInterval',E.screen.theWindow);

ListenChar(2);

if E.RespBox.use
    CedrusResponseBox('CloseAll');
    E.RespBox.hdl     = CedrusResponseBox('Open', 'COM3'); %open port
end
