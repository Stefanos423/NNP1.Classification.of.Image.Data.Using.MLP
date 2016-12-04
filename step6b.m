function [accuracy precision recall] = step6b(TestData, TestDataTargets, TrainData, TrainDataTargets, BestFirst, BestSecond, BestTrain, BestActivation)

accuracy = [];
precision = [];
recall = [];

neural = newff(TrainData, TrainDataTargets, [BestFirst BestSecond], {'tansig','tansig',BestActivation}, BestTrain, 'learngd');
neural = train(neural, TrainData, TrainDataTargets);
TestDataOutput = sim(neural, TestData);
[accu(1,:),prec(1,:),rec(1,:)] = eval_Accuracy_Precision_Recall(TestDataOutput, TestDataTargets);

neural = newff(TrainData, TrainDataTargets, [BestFirst BestSecond], {'tansig','tansig',BestActivation}, BestTrain, 'learngdm');
neural = train(neural, TrainData, TrainDataTargets);
TestDataOutput = sim(neural, TestData);
[accu(2,:),prec(2,:),rec(2,:)] = eval_Accuracy_Precision_Recall(TestDataOutput, TestDataTargets);

accuracy = horzcat(accuracy, accu);
precision = horzcat(precision, prec);
recall = horzcat(recall, rec);
