
%step6a
[actaccu actprec atrec] = step6a(myTestData, TestDataTargets, myTrainData, myTrainDataTargets, BestTrain);

meanaccuracyActivation = actaccu;

for i = 1:4
    [actaccu actprec actrec] = step6a(myTestData, TestDataTargets, myTrainData, myTrainDataTargets, BestTrain);
    
    meanaccuracyActivation = meanaccuracyActivation + actaccu;
end

meanaccuracyActivation = meanaccuracyActivation/5;
[BestActivation] = findBestActivation(meanaccuracyActivation);

%step6b
[learnaccu learnprec learnrec] = step6b(myTestData, TestDataTargets, myTrainData, myTrainDataTargets, neuronsFirstLevel, neuronsSecondLevel, BestTrain, BestActivation);

meanaccuracyLearning = learnaccu;
for i = 1:4
    [learnaccu learnprec learnrec] = step6b(myTestData, TestDataTargets, myTrainData, myTrainDataTargets, neuronsFirstLevel, neuronsSecondLevel, 'trainlm', BestActivation);
    
    meanaccuracyLearning = meanaccuracyLearning + learnaccu;
end

meanaccuracyLearning = meanaccuracyLearning/5;
[BestLearn] = findBestLearning(meanaccuracyLearning);

%step6c
[valaccu valepoch] = step6c(myTestData, TestDataTargets, myTrainData, myTrainDataTargets, neuronsFirstLevel, neuronsSecondLevel, BestTrain, BestActivation, BestLearn);
meanaccuracyValidation = valaccu;
meanepochValidation = valepoch;

for i = 1:4
    [valaccu valepoch] = step6c(myTestData, TestDataTargets, myTrainData, myTrainDataTargets, neuronsFirstLevel, neuronsSecondLevel, BestTrain, BestActivation, BestLearn);
    meanaccuracyValidation = meanaccuracyValidation + valaccu;
    meanepochValidation = meanepochValidation + valepoch;
end

meanaccuracyValidation = meanaccuracyValidation/5;
meanepochValidation = floor(meanepochValidation/5);
[BestValidation BestEpochs] = findBestValidation(meanaccuracyValidation, meanepochValidation);

%step6d
BoundEpochs = floor(BestEpochs/5) + 1;
[NoValaccu NoValepochs] = step6d(myTestData, TestDataTargets, myTrainData, myTrainDataTargets, neuronsFirstLevel, neuronsSecondLevel, BestTrain, BestActivation, BestLearn, BestEpochs, BoundEpochs);
meanaccuracyNoValidation = NoValaccu;
meanepochsNoValidation = NoValepochs;

for i = 1:4
    [NoValaccu NoValepochs] = step6d(myTestData, TestDataTargets, myTrainData, myTrainDataTargets, neuronsFirstLevel, neuronsSecondLevel, BestTrain, BestActivation, BestLearn, BestEpochs, BoundEpochs);
    meanaccuracyNoValidation = meanaccuracyNoValidation + NoValaccu;
    meanepochsNoValidation = meanepochsNoValidation + NoValepochs;
end

meanaccuracyNoValidation = meanaccuracyNoValidation/5;
meanepochsNoValidation = meanepochsNoValidation/5;
[BestEpochsNoVal] = findBestEpochsNoValidation(meanaccuracyNoValidation, meanepochsNoValidation);

%step6e

[BestRateaccu] = step6e(myTestData, TestDataTargets, myTrainData, myTrainDataTargets, neuronsFirstLevel, neuronsSecondLevel);
meanaccuracyRate = BestRateaccu;

for i = 1:4
    [BestRateaccu] = step6e(myTestData, TestDataTargets, myTrainData, myTrainDataTargets, neuronsFirstLevel, neuronsSecondLevel);
    meanaccuracyRate = meanaccuracyRate + BestRateaccu;
end

[BestLR BestLRTraining] = findBestLR(meanaccuracyRate);
meanaccuracyRate = meanaccuracyRate/5;

%step7
[BestaccuracyTotal] = step7(myTestData, TestDataTargets, myTrainData, myTrainDataTargets, neuronsFirstLevel, neuronsSecondLevel, BestTrain, BestActivation, BestLearn, BestValidation);
meanaccuracyTotal = BestaccuracyTotal;

for i = 1:4
    [BestaccuracyTotal] = step7(myTestData, TestDataTargets, myTrainData, myTrainDataTargets, neuronsFirstLevel, neuronsSecondLevel, BestTrain, BestActivation, BestLearn, BestValidation);
    meanaccuracyTotal = meanaccuracyTotal + BestaccuracyTotal;
end

meanaccuracyTotal = meanaccuracyTotal/5;
disp(meanaccuracyTotal);