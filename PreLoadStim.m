% Directories

StimPath       = fullfile(pwd, 'Stimuli');
p_data         = fullfile(pwd, 'Data');
WordListPath   = fullfile(pwd, 'WordLists');

%% Load all characters

E.Stim.I    = cell(9,1);
E.Stim.Char = cell(9,1);

for n = 1:length(E.Stim.Char)
    E.Stim.I{n} = imread(fullfile(StimPath,[num2str(n),'.png']));
    E.Stim.Char{n} = Screen(E.screen.theWindow,'MakeTexture', E.Stim.I{n});
end

%% Shuffle characters

% s = randperm(length(E.Stim.Char));
% 
% E.Stim.I    = E.Stim.I(s);
% E.Stim.Char = E.Stim.Char(s);

%%

E.Stim.StimList     = randperm(3,E.times.NBlocks);
E.Stim.WordLists    = nan(E.times.NBlocks,E.times.NWords);

E.Stim.Words = [1,2,4;
                5,2,3;
                1,6,3;
                7,8,4;
                5,8,9;
                7,6,9;
                1,2,3;
                7,8,9;
                5,6,4];

for L = 1:length(E.Stim.StimList)
    load(fullfile(WordListPath,['S_',num2str(E.Stim.StimList(L)),'.mat']));
    
    E.Stim.WordLists(L,:) = words;
end