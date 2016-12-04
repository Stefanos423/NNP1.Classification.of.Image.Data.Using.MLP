function [BestLearn] = findBestLearning (meanaccuracyLearning)

temp = find(max(meanaccuracyLearning));
if (temp == 1)
    BestLearn = 'learngd';
else
    BestLearn = 'learngdm';
end