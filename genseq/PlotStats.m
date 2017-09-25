close
clear h

w = 50;

for n = 1:200-w
    h(n,:) = hist(words(n:n+(w-1)),numel(unique(words)))/w;
end


subplot(2,1,1)
plot([mean(h(:,1:6),2),mean(h(:,7:9),2)])
axis([1 length(h) 0 .2])

subplot(2,1,2)
hold on
plot(h(:,1:6),'k')
plot(h(:,7:9),'r')
axis([1 length(h) 0 .3])


%%

close all
clear h

w = 50;

for n = 1:200-w
    h(n,:) = hist(words(n:n+(w-1)),numel(unique(words)))/w;
end


subplot(2,1,1)
plot([mean(h(:,1:6),2)])
axis([1 length(h) 0 .2])

subplot(2,1,2)
hold on
plot(h(:,1:6),'k')
axis([1 length(h) 0 .3])