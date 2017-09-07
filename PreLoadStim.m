% Directories

StimPath = fullfile(pwd, 'Stimuli');
p_data   = fullfile(pwd, 'Data');

%% Load all characters

E.Stim.I    = cell(9,1);
E.Stim.Char = cell(9,1);

for n = 1:length(E.Stim.Char)
    E.Stim.I{n} = imread(fullfile(StimPath,[num2str(n),'.png']));
    E.Stim.Char{n} = Screen(E.screen.theWindow,'MakeTexture', E.Stim.I{n});
end

%% Shuffle characters

s = randperm(length(E.Stim.Char));

E.Stim.I    = E.Stim.I(s);
E.Stim.Char = E.Stim.Char(s);

%%

E.Stim.StimList     = randperm(20,E.times.NBlocks);
E.Stim.WordLists    = nan(E.times.NBlocks,E.times.NWords);