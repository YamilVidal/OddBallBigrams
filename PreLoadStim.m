% Directories

StimPath       = fullfile(pwd, 'Stimuli');
p_data         = fullfile(pwd, 'Data');

WordListPathLearn = fullfile(pwd, 'WordLists', 'Learning');
WordListPath      = fullfile(pwd, 'WordLists', 'DevBlocks');

%% Load all characters

E.Stim.C    = randperm(13,9);
E.Stim.I    = cell(9,1);
E.Stim.Char = cell(9,1);

for n = 1:length(E.Stim.C)
    I = imread(fullfile(StimPath,[num2str(E.Stim.C(n)),'.jpg']));
    
    I(I>100) = 255; % Make sure texture is pure black and white
    I(I<100) = 0;
    
    A = I(:,:,1); % Create Alpha channel
    A(I(:,:,1) == 255) = 0;
    A(I(:,:,1) == 0)   = 255;
    I(:,:,4) = A;
    
    E.Stim.I{n}    = I;
    E.Stim.Char{n} = Screen(E.screen.theWindow,'MakeTexture', E.Stim.I{n});
end

%% Shuffle characters

s = randperm(length(E.Stim.Char));

E.Stim.I    = E.Stim.I(s);
E.Stim.Char = E.Stim.Char(s);

E.Stim.Scale = .3; % Scale of the stim on screen

%% By all means, don't touch this, as it defines the statistical structure of the stimuli

E.Stim.Words = [1,2,4;
    5,2,3;
    1,6,3;
    7,8,4;
    5,8,9;
    7,6,9;
    1,2,3;
    7,8,9;
    5,6,4];

%%
E.Stim.StimListLearn  = randperm(20,1);

E.Stim.StimList       = randperm(20,E.times.NBlocks);
E.Stim.WordLists      = nan(E.times.NBlocks,E.times.NWords);

% Load just one list for the learning block
load(fullfile(WordListPathLearn,['S_Learn_',num2str(E.Stim.StimListLearn),'.mat']));
E.Stim.WordListsLearn = words(1:E.times.NWords);

% Load all the lists for the blocks containing deviants
for L = 1:length(E.Stim.StimList)
    load(fullfile(WordListPath,['S_',num2str(E.Stim.StimList(L)),'.mat']));
    E.Stim.WordLists(L,1:E.times.NWords) = words(1:E.times.NWords);
end