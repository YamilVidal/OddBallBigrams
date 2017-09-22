for n = 1:20
    
    ck = true;
    
    while ck
        words = MakeWordList_Learning();
        w = 30;
        clear h
        
        for i = 1:length(words)-w
            h(i,:) = hist(words(i:i+(w-1)),6)/w;
        end
        
        ck = any(abs(h(:) - 1/6) > .1);
    end
    
    save(['S_Learn_',num2str(n),'.mat'],'words')
end
