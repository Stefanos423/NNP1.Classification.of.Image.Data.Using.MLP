function [accuracy epoch] = step6d(TestData, TestDataTargets, TrainData, TrainDataTargets, neuronsFirstLevel, neuronsSecondLevel, BestTrain, BestActivation, BestLearn, BestEpochs, BoundEpochs)

accuracy = [];
epoch = [];

spam = -BoundEpochs;
for i = 1: (2*BoundEpochs + 1)
    neural = newff(TrainData, TrainDataTargets, [neuronsFirstLevel neuronsSecondLevel], {'tansig','tansig',BestActivation}, BestTrain, BestLearn);
    neural.divideParam.trainRatio=1.0;
    neural.divideParam.valRatio=0.0;
    neural.divideParam.testRatio=0;
    neural.trainParam.epochs=BestEpochs + spam;
    
    neural = train(neural, TrainData, TrainDataTargets);
    TestDataOutput = sim(neural, TestData);
    [accu(i,:),prec(i,:),rec(i,:)] = eval_Accuracy_Precision_Recall(TestDataOutput, TestDataTargets);
    novalep(i,:) = BestEpochs + spam;
    spam = spam + 1;
end

accuracy = horzcat(accuracy, accu);
epoch = horzcat(epoch, novalep);