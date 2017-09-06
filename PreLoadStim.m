
Stim    = cell(12,1);

% All Stim
[Stim{1},  fs] = audioread(fullfile(S1w, 'S1.1_din.wav'));
[Stim{2},  fs] = audioread(fullfile(S1w, 'S1.2_din.wav'));
[Stim{3},  fs] = audioread(fullfile(S1w, 'S1.3_din.wav'));
[Stim{4},  fs] = audioread(fullfile(S1w, 'S1.4_din.wav'));

[Stim{5},  fs] = audioread(fullfile(S2w, 'S2.1_din.wav'));
[Stim{6},  fs] = audioread(fullfile(S2w, 'S2.2_din.wav'));
[Stim{7},  fs] = audioread(fullfile(S2w, 'S2.3_din.wav'));
[Stim{8},  fs] = audioread(fullfile(S2w, 'S2.4_din.wav'));

[Stim{9},  fs] = audioread(fullfile(S3w, 'S3.1_din.wav'));
[Stim{10}, fs] = audioread(fullfile(S3w, 'S3.2_din.wav'));
[Stim{11}, fs] = audioread(fullfile(S3w, 'S3.3_din.wav'));
[Stim{12}, fs] = audioread(fullfile(S3w, 'S3.4_din.wav'));

%% Re sort
StimCat = randperm(3);
StimCat = StimCat - 1;

% STD
Stim2{1} = Stim{1 + StimCat(1)*4};
Stim2{2} = Stim{2 + StimCat(1)*4};
Stim2{3} = Stim{3 + StimCat(1)*4};
Stim2{4} = Stim{4 + StimCat(1)*4};

% DEV1
Stim2{5} = Stim{1 + StimCat(2)*4};
Stim2{6} = Stim{2 + StimCat(2)*4};
Stim2{7} = Stim{3 + StimCat(2)*4};
Stim2{8} = Stim{4 + StimCat(2)*4};

% DEV2
Stim2{9} = Stim{1 + StimCat(3)*4};
Stim2{10} = Stim{2 + StimCat(3)*4};
Stim2{11} = Stim{3 + StimCat(3)*4};
Stim2{12} = Stim{4 + StimCat(3)*4};

Stim = Stim2;
clear Stim2
