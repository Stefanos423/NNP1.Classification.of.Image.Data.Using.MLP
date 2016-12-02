function [accuracy precision recall] = step4b(TestData, TestDataTargets, TrainData, TrainDataTargets, trainingMethod)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
accuracy = [];
precision = [];
recall = [];
for j = 5:5:30
    for i = 5:5:30
         neural = newff(TrainData, TrainDataTargets, [j i]);
         if (trainingMethod == 1)
            neural.trainFcn = 'traingdx';
            [neural, tr] = train(neural, TrainData, TrainDataTargets);
            TestDataOutput = sim(neural, TestData);
            [accu(i,:),prec(i,:),rec(i,:)] = eval_Accuracy_Precision_Recall(TestDataOutput, TestDataTargets);
        elseif (trainingMethod == 2)
            neural.trainFcn = 'trainlm';
            [neural, tr] = train(neural, TrainData, TrainDataTargets);
            TestDataOutput = sim(neural, TestData);
            [accu(i,:),prec(i,:),rec(i,:)] = eval_Accuracy_Precision_Recall(TestDataOutput, TestDataTargets);
        elseif (trainingMethod == 3)
            neural.trainFcn = 'traingd';
            [neural, tr] = train(neural, TrainData, TrainDataTargets);
            TestDataOutput = sim(neural, TestData);
            [accu(i,:),prec(i,:),rec(i,:)] = eval_Accuracy_Precision_Recall(TestDataOutput, TestDataTargets);
        elseif (trainingMethod == 4)
            neural.trainFcn = 'traingda';
            [neural, tr] = train(neural, TrainData, TrainDataTargets);
            TestDataOutput = sim(neural, TestData);
            [accu(i,:),prec(i,:),rec(i,:)] = eval_Accuracy_Precision_Recall(TestDataOutput, TestDataTargets);
        else 
            message = 'Invalid Training Parameter. Please provide a parameter with value between 1 and 4';
            disp(message);
        end
    end
    accuracy = horzcat(accuracy, accu);
    precision = horzcat(precision, prec);
    recall = horzcat(recall, rec);
end

 
 %We will now delete all empty rows and columns
 accuracy(~any(accuracy,2), :) = [];
 accuracy(:, ~any(accuracy,1)) = [];
 
 precision(~any(precision,2), :) = [];
 precision(:, ~any(precision, 1)) = []; 
 
 recall(~any(recall,2), :) = [];
 recall(:, ~any(recall,1)) = [];
 
 %visualing the results
 