%%
B.theWindow    = theWindow;
B.BlockCounter = 1;
B.I            = I;
B.Char         = Char;

B.BlockCounter = 1;

B.StimList     = randperm(20,NBlocks);
B.WordLists    = nan(NBlocks,NWords);

B.Keys.c_escape  = c_escape;
B.Keys.c_space   = c_space;
B.Keys.c_ctrl    = c_ctrl;
B.Keys.c_alt     = c_alt;
B.Keys.c_ans1key = c_ans1key;
B.Keys.c_ans2key = c_ans2key;