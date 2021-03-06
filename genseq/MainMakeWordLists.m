Lists = cell(20,1);

parfor n = 1:length(Lists)
    
    ck = [true true];
    
    while any(ck)
        words = MakeWordList();
        
        %% First, check if std word frequency is stable
        w = 50;
        h = [];
        
        for i = 1:length(words)-w
            h(i,:) = hist(words(i:i+(w-1)),9)/w;
        end
        
        h = h(:,1:6);
        
        ck(1) = any(abs(h(:) - 1/6) > .1);
        
        %% Second, check if at any point, mean dev freq is higher than std freq, or if mean dev freq is above 10% 
        w = 20;
        h = [];
        
        for i = 1:length(words)-w
            h(i,:) = hist(words(i:i+(w-1)),9)/w;
        end
        
        mpd = mean(h(:,7:9),2); % mean prob deviant
        mps = mean(h(:,1:6),2); % mean prob standard
        
        ck(2) = any(mpd > mps) || any(mpd > .1);
        %ck = false;
    end
    
    Lists{n} = words;
    display(['List ', num2str(n),' created']);
end

for n = 1:length(Lists)
    words = Lists{n};
    save(['S_',num2str(n),'.mat'],'words')
end
