function [accuracy, precision, recall] = weightDecayV2(TestData, TestDataTargets, TrainData, TrainDataTargets)

neural = newff(TrainData, TrainDataTargets, [30]);
neural.divideParam.trainRatio = 0.8;
neural.divideParam.valRatio = 0.2;
neural.divideParam.testRatio = 0;
neural.layers{2}.transferFcn = 'tansig';
%neural.trainParam.lr = max_learn_rate;
neural.trainParam.epochs = 1;
neural.trainFcn = 'trainlm';



lamda = 0.3;
neural = newff(TrainData,TrainDataTargets,30);
neural.trainParam.epochs=1;
d = 0.01;

for k = 1:20
    wb(:,k) = getwb(neural);
    neural = train(neural, TrainData, TrainDataTargets);
    TestDataOutput = sim(neural, TestData);
    wb(:,k+1) = wb(:,k)-lamda*wb(:,k);
    [m,n] = size(wb);
    if k == 1
        count(k) = m;
    end
    count(k+1) = m;
    for i=1:m
        if (wb(i,k+1) < d)
            wb(i,k+1) = 0;
            count(k+1) = count(k+1)-1;
        end
    end
    error(k) = sum(sum((TestDataTargets - TestDataOutput).^2, 2)) / ...
         (size(TestDataOutput,1) * size(TestDataOutput,2));
    neural = setwb(neural,wb(:,k+1));
    [accuracy(k), precision(k,:), recall(k,:)] = eval_Accuracy_Precision_Recall(TestDataOutput,TestDataTargets);
    
end

iterations = 1:21;
figure();
subplot(2,1,1)
plot(iterations, count);
xlabel('Number of iterations');
ylabel('NUmber of nonzero weights');
iterations = 1:20;
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