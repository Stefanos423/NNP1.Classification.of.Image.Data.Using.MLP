function [accuracy precision recall] = step3(TestData, TestDataTargets, TrainData, TrainDataTargets)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
accuracy = [];
precision = [];
recall = [];
for i = 5:5:30
    for j = 5:5:30
    neural = newff(TrainData, TrainDataTargets, [i j]);
    neural.divideParam.trainRatio=0.8;
    neural.divideParam.valRatio=0.2;
    neural.divideParam.testRatio=0;
    neural.trainParam.epochs=1000;
    neural = train(neural, TrainData, TrainDataTargets);
    TestDataOutput = sim(neural, TestData);
    [accu(j,:),prec(j,:),rec(j,:)] = eval_Accuracy_Precision_Recall(TestDataOutput, TestDataTargets);
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
 horzAxis = 5:5:30;
 vertAxis = 5:5:30;
 figure();
 contour3(horzAxis, vertAxis, accuracy);
 title('Variable numbers of Neurons on the first and second Hidden Levels');
 xlabel('Number of Neurons on the first Hidden Level');
 ylabel('Number of Neurons on the second Hidden Level');
 zlabel('Number of Neurons on the third Hidden Level');
 colormap(jet);
