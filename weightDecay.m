function [accuracy, precision, recall] = weightDecay(b_activation_function, max_learn_rate, b_train, TestData, ...
    TestDataTargets, TrainData, TrainDataTargets)

l = 0.2;
d = 0.04;

    neural = newff(TrainData, TrainDataTargets, [30]);
    neural.divideParam.trainRatio = 0.8;
    neural.divideParam.valRatio = 0.2;
    neural.divideParam.testRatio = 0;
    neural.layers{2}.transferFcn = b_activation_function;
    %neural.trainParam.lr = max_learn_rate;
    neural.trainParam.epochs = 1;
    neural.trainFcn = b_train;
    neural = train(neural, TrainData, TrainDataTargets);

for k = 1:200
    t = getwb(neural); 
    [neural, tr] = train(neural, TrainData, TrainDataTargets);
    new_t = getwb(neural);
    new_t = new_t - l*t;
    thresh = new_t > d;
    new_t = new_t.*thresh;   
    non_zero = find(new_t);
    number_of_non_zero(k) = length(non_zero);
	TestDataOutput_wg = sim(neural, TestData);
    error(k) = sum(sum((TestDataTargets - TestDataOutput_wg).^2, 2)) / ...
         (size(TestDataOutput_wg,1) * size(TestDataOutput_wg,2));
    neural = setwb(neural, new_t);
	[accuracy(k), precision(k,:), recall(k,:)] = eval_Accuracy_Precision_Recall(TestDataOutput_wg,TestDataTargets);
    
end

iterations = 1:200;
figure();
subplot(2,1,1)
plot(iterations, number_of_non_zero);
xlabel('Number of iterations');
ylabel('NUmber of nonzero weights');
subplot(2,1,2)
plot(iterations, error);
xlabel('Number of iterations');
ylabel('Error');
figure();
plot(accuracy);
xlabel('Number of iterations');
ylabel('Accuracy');
title('Accuracy Weight Decay');
end
