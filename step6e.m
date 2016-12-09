function [accuracy] = step6e(TestData, TestDataTargets, TrainData, TrainDataTargets, neuronsFirstLevel, neuronsSecondLevel)

accuracy = [];
precision = [];
recall = [];

j = 1;
for i = 0.05:0.05:0.4
    neural = newff(TrainData, TrainDataTargets, [neuronsFirstLevel neuronsSecondLevel]);
    neural.trainFcn = 'traingd';
    neural.divideParam.trainRatio = 0.8;
    neural.divideParam.valRatio = 0.2;
    neural.divideParam.testRatio = 0;
    neural.trainParam.epochs = 1000;
    neural.trainParam.lr = i;
   
    [neural, tr] = train(neural, TrainData, TrainDataTargets);
    TestDataOutput = sim(neural, TestData);
    [accu(j,:),prec(j,:),rec(j,:)] = eval_Accuracy_Precision_Recall(TestDataOutput, TestDataTargets);
    j = j + 1;
end

accuracy = horzcat(accuracy, accu);
precision = horzcat(precision, prec);
recall = horzcat(recall,rec);

j = 1;
for i = 0.05:0.05:0.4
%    neural = newff(TrainData, TrainDataTargets, [neuronsFirstLevel neuronsSecondLevel], {'tansig','tansig',BestActivation}, 'traingdx', BestLearn);
    neural = newff(TrainData, TrainDataTargets, [neuronsFirstLevel neuronsSecondLevel]);
    neural.trainFcn = 'traingdx';
    neural.divideParam.trainRatio = 0.8;
    neural.divideParam.valRatio = 0.2;
    neural.divideParam.testRatio = 0;
    neural.trainParam.epochs = 1000;
    neural.trainParam.lr = i;
   
    [neural, tr] = train(neural, TrainData, TrainDataTargets);
    TestDataOutput = sim(neural, TestData);
    [accu(j,:),prec(j,:),rec(j,:)] = eval_Accuracy_Precision_Recall(TestDataOutput, TestDataTargets);
    j = j + 1;
end

accuracy = horzcat(accuracy, accu);