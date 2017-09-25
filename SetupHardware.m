%% Screen parameters
% E.screen.screenN = max(Screen('Screens'));  % screen where the experiment is shown
E.screen.screenN  = 2;
ScreenData        = Screen('Resolution',E.screen.screenN);
E.screen.res      = [ScreenData.width ScreenData.height];
E.screen.window   = 1*E.screen.res; % size of the window were the experiment is shown
E.screen.rec      = [E.screen.res - E.screen.window E.screen.res]; % position of the window where the experiment is shown
E.screen.clrdepth = 32;

% Text
E.screen.textsize  = 20; % text size for the instructions
E.screen.textcolor = 0; % text size for the instructions

E.screen.bckgrnd  = repmat(100,1,3);

% Detect the code of some relevant keys
KbName('UnifyKeyNames')

E.keys.c_escape  = KbName('Escape');
E.keys.c_space   = KbName('space');
E.keys.c_ctrl    = KbName('LeftControl');
E.keys.c_alt     = KbName('LeftAlt');
E.keys.c_ans1key = KbName('z');
E.keys.c_ans2key = KbName('m');

E.keys.ResKey    = '2.Left';