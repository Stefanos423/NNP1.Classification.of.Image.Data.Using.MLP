function [BestActivation] = findBestActivation (meanaccuracyActivation)

temp = find(max(meanaccuracyActivation));
if (temp == 1)
    BestActivation = 'purelin';
elseif (temp == 2)
    BestActivation = 'tansig';
elseif (temp == 3)
    BestActivation = 'logsig';
else
    BestActivation = 'hardlim';
end