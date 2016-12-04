function [accuracy precision recall] = step6a(TestData, TestDataTargets, TrainData, TrainDataTargets, BestTrain)

accuracy = [];
precision = [];
recall = [];

neural = newff(TrainData, TrainDataTargets, [25 10], {'tansig' 'tansig' 'purelin'},BestTrain);
neural = train(neural, TrainData, TrainDataTargets);
TestDataOutput = sim(neural, TestData);
[accu(1,:),prec(1,:),rec(1,:)] = eval_Accuracy_Precision_Recall(TestDataOutput, TestDataTargets);

neural = newff(TrainData, TrainDataTargets, [25 10], {'tansig' 'tansig' 'tansig'},BestTrain);
neural = train(neural, TrainData, TrainDataTargets);
TestDataOutput = sim(neural, TestData);
[accu(2,:),prec(2,:),rec(2,:)] = eval_Accuracy_Precision_Recall(TestDataOutput, TestDataTargets);

neural = newff(TrainData, TrainDataTargets, [25 10], {'tansig' 'tansig' 'logsig'},BestTrain);
neural = train(neural, TrainData, TrainDataTargets);
TestDataOutput = sim(neural, TestData);
[accu(3,:),prec(3,:),rec(3,:)] = eval_Accuracy_Precision_Recall(TestDataOutput, TestDataTargets);

neural = newff(TrainData, TrainDataTargets, [25 10], {'tansig' 'tansig' 'hardlim'},BestTrain);
neural = train(neural, TrainData, TrainDataTargets);
TestDataOutput = sim(neural, TestData);
[accu(4,:),prec(4,:),rec(4,:)] = eval_Accuracy_Precision_Recall(TestDataOutput, TestDataTargets);

accuracy = horzcat(accuracy, accu);
precision = horzcat(precision, prec);
recall = horzcat(recall, rec);

%fmeasure = calc_fmeasure(precision, recall);
%index_row = find(max(max(accuracy'))==max(accuracy'))
%index_column = find(max(max(accuracy))==max(accuracy))