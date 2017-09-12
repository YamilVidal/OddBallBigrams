
for n = 1:5
    
    ck = true;
    
    while ck
        words = MakeWordList();
        w = 20;
        clear h
        
        for i = 1:length(words)-w
            h(i,:) = hist(words(i:i+(w-1)),9)/w;
        end
        
        mpd = mean(h(:,7:9),2); % mean prob deviant
        mps = mean(h(:,1:6),2); % mean prob standard
        
        ck = any(mpd > mps) || any(mpd > .1);
    end
    
    
    save(['S_',num2str(n),'.mat'],'words')
end

