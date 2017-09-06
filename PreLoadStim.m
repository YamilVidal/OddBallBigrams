%% Load all characters

I    = cell(9,1);
Char = cell(9,1);

for n = 1:length(Char)
    I{n} = imread(fullfile(StimPath,[num2str(n),'.png']));
    Char{n} = Screen(theWindow,'MakeTexture', I{n});
end

%% Shuffle characters

s = randperm(length(Char));

I    = I(s);
Char = Char(s);
