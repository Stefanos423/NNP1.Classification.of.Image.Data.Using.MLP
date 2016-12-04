function [accuracy precision recall] = step3(TestData, TestDataTargets, TrainData, TrainDataTargets)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
accuracy = [];
precision = [];
recall = [];
for i = 5:5:30
    neural = newff(TrainData, TrainDataTargets, i);
    neural.divideParam.trainRatio=0.8;
    neural.divideParam.valRatio=0.2;
    neural.divideParam.testRatio=0;
    neural.trainParam.epochs=1000;
    neural = train(neural, TrainData, TrainDataTargets);
    TestDataOutput = sim(neural, TestData);
    [accu(i,:),prec(i,:),rec(i,:)] = eval_Accuracy_Precision_Recall(TestDataOutput, TestDataTargets);
end
 accuracy = horzcat(accuracy, accu);
 precision = horzcat(precision, prec);
 recall = horzcat(recall, rec);
 
 %We will now delete all empty rows and columns
 accuracy(~any(accuracy,2), :) = [];
 accuracy(:, ~any(accuracy,1)) = [];
 
 precision(~any(precision,2), :) = [];
 precision(:, ~any(precision, 1)) = []; 
 
 recall(~any(recall,2), :) = [];
 recall(:, ~any(recall,1)) = [];
 
 fmeasure = calc_fmeasure1(precision, recall);
 for i = 1:6
     if (fmeasure(i) < 0.8)
         accuracy(i) = 0;
     end
 end
 
 %visualing the results
 horzAxis = 5:5:30;
 figure();
 plot(horzAxis, accuracy);
 title('Variable numbers of Neurons on the first Hidden Level');
 xlabel('Number of Neurons');
 ylabel('Calculated Accuracy');

