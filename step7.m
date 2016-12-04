function [accuracy] = step7(TestData, TestDataTargets, TrainData, TrainDataTargets, neuronsFirstLevel, neuronsSecondLevel, BestTrain, BestActivation, BestLearn, BestValidation)

accuracy = [];

    neural = newff(TrainData, TrainDataTargets, [neuronsFirstLevel neuronsSecondLevel], {'tansig','tansig',BestActivation}, BestTrain, BestLearn);
    neural.divideParam.trainRatio=BestValidation;
    neural.divideParam.valRatio=1.0 - BestValidation;
    neural.divideParam.testRatio=0;
    neural.trainParam.epochs=1000;
    
    [neural tr]= train(neural, TrainData, TrainDataTargets);
    TestDataOutput = sim(neural, TestData);
    [accu(1,:),prec(1,:),rec(1,:)] = eval_Accuracy_Precision_Recall(TestDataOutput, TestDataTargets);
    
    accuracy = horzcat(accuracy,accu);
    