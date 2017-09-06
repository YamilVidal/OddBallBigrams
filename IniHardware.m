% Open the screen
PsychImaging('PrepareConfiguration');

if debugmode
    [theWindow] = Screen('OpenWindow', screenN, [127 127 127], [0 0 60 60], clrdepth);
else
    [theWindow] = Screen('OpenWindow', screenN, [127 127 127], [], clrdepth);
end

% Set Text Format
Screen(theWindow,'FillRect',127);
Screen(theWindow,'TextFont','Arial');
Screen(theWindow,'TextSize',B.textsize);

% Maximum priority level
topPriorityLevel = MaxPriority(theWindow);
Priority(topPriorityLevel);

% Collect the time for the first flip with vbl
info.screen.vbl = Screen(theWindow, 'Flip');

% Query the frame duration
info.screen.flipinterval = Screen('GetFlipInterval',theWindow);