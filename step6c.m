function [accuracy epoch] = step6c(TestData, TestDataTargets, TrainData, TrainDataTargets, neuronsFirstLevel, neuronsSecondLevel, BestTrain, BestActivation, BestLearn)

accuracy = [];
epoch = [];

for i = 1:7
    neural = newff(TrainData, TrainDataTargets, [neuronsFirstLevel neuronsSecondLevel], {'tansig','tansig',BestActivation}, BestTrain, BestLearn);
    neural.divideParam.trainRatio=0.65 + (0.05 * i);
    neural.divideParam.valRatio=1.0 - (0.65 + (0.05 * i) );
    neural.divideParam.testRatio=0;
    neural.trainParam.epochs=1000;
    
    [neural tr]= train(neural, TrainData, TrainDataTargets);
    TestDataOutput = sim(neural, TestData);
    [accu(i,:),prec(i,:),rec(i,:)] = eval_Accuracy_Precision_Recall(TestDataOutput, TestDataTargets);

    ep(i,:) = tr.num_epochs;
end


accuracy = horzcat(accuracy, accu);
epoch = horzcat(epoch, ep);