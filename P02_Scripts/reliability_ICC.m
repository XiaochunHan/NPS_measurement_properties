function icc_mean = reliability_ICC(DAT)

celldat = DAT;
clear means robmeans means12
for i = 1:100
for j = 1:length(celldat)
    t = length(celldat{j});
    seq = Shuffle([1:t]);
    wh1 = 1:floor(t/2);
    wh2 = floor(t/2):t;
    mat(j,1) = mean(celldat{j}(seq(wh1)));
    mat(j,2) = mean(celldat{j}(seq(wh2)));
end
icc(i,1) = ICC(1, 'k', mat);  
end
icc_mean = mean(icc);
end % function
