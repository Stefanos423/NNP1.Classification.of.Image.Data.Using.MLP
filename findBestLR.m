function [BestLR BestLRTraining] = findBestLR(meanaccuracyRate)

index_row = find(max(max(meanaccuracyRate'))==max(meanaccuracyRate'));
index_column = find(max(max(meanaccuracyRate))==max(meanaccuracyRate));

if (index_column == 1)
    BestLR = index_row * 0.05;
    BestLRTraining = 'traingd';
else
    BestLR = index_row * 0.05;
    BestLRTraining = 'traingdx';
end