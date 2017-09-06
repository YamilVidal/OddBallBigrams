%%
B.theWindow    = theWindow;
B.BlockCounter = 1;
B.Stim         = Stim;
B.fs           = fs;
B.useET        = useET;

B.ET.Left      = nan(13,150,200,13);
B.ET.Right     = nan(13,150,200,13);
B.ET.Timestamp = nan(13,150,150);

B.ClickTime    = nan(13,150);
B.WordLists    = nan(13,150);

B.p_streams_I  = p_streams_I;

B.Keys.c_escape  = c_escape;
B.Keys.c_space   = c_space;
B.Keys.c_ctrl    = c_ctrl;
B.Keys.c_alt     = c_alt;
B.Keys.c_ans1key = c_ans1key;
B.Keys.c_ans2key = c_ans2key;