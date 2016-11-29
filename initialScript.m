%load dataSet.mat
X = sum(TrainDataTargets, 2);
b = bar(X);
title('Number of segements in each category before preprocessing');

%We will keep only the amount of rows where all
%characteristics appear
minimum = min(X);
index_1 = find(TrainDataTargets(1,:), minimum);
index_2 = find(TrainDataTargets(2,:), minimum);
index_3 = find(TrainDataTargets(3,:), minimum);
index_4 = find(TrainDataTargets(4,:), minimum);
index_5 = find(TrainDataTargets(5,:), minimum);
indexes = [index_1 index_2 index_3 index_4 index_5];

permutation = randperm(size(indexes, 2));
%permutation = randperm(535);
indexes = indexes(permutation);
myTrainData = TrainData(:, indexes);
myTrainDataTargets = TrainDataTargets(:, indexes);

%removing unimportant characteristics
[myTrainData, PS] = removeconstantrows(myTrainData);
myTestData = removeconstantrows('apply', TestData, PS);

%normalizing the values and using processpca
[myTrainData, PS] = mapstd(myTrainData);
myTestData = mapstd('apply', myTestData, PS);
[myTrainData, PS] = processpca(myTrainData, 0.0098);
myTestData = processpca('apply', myTestData, PS);

figure();
X = sum(myTrainDataTargets, 2);
b = bar(X);
title('Number of segements in each category after preprocessing');

%We will now create neural networks with a variable
%number of hidden levels, train, test and evaluation
%ratios

%First we will create a neural network of 1 hidden
%level and 5 neurons and gradually raise the number
%neurons to evaluate its performance. This will be
%performed through a function to facilitate the
%cooperative nature of this project
[accuracy1 precision1 recall1] = step3(myTestData, TestDataTargets, myTrainData, myTrainDataTargets);

%We are now going to create a new neural network of
%2 hidden levels with 5 neurons each and steadily
%increment the neurons in every level by 5 in each step
[accuracy2 precision2 recall2] = step3b(myTestData, TestDataTargets, myTrainData, myTrainDataTargets);

%We are now going to try different training techniques
%for 1 hidden level and 2 hidden levels respectively
[accuracyGDX precisionGDX recallGDX] = step4(myTestData, TestDataTargets, myTrainData, myTrainDataTargets, 1);
[accuracyLM precisionLM recallLM] = step4(myTestData, TestDataTargets, myTrainData, myTrainDataTargets, 2);
[accuracyGD precisionGD recallGD] = step4(myTestData, TestDataTargets, myTrainData, myTrainDataTargets, 3);
[accuracyGDA precisionGDA recallGDA] = step4(myTestData, TestDataTargets, myTrainData, myTrainDataTargets, 4);

[accuracyGDX2 precisionGDX2 recallGDX2] = step4b(myTestData, TestDataTargets, myTrainData, myTrainDataTargets, 1);
[accuracyLM2 precisionLM2 recallLM2] = step4b(myTestData, TestDataTargets, myTrainData, myTrainDataTargets, 2);
[accuracyGD2 precisionGD2 recallGD2] = step4b(myTestData, TestDataTargets, myTrainData, myTrainDataTargets, 3);
[accuracyGDA2 precisionGDA2 recallGDA2] = step4b(myTestData, TestDataTargets, myTrainData, myTrainDataTargets, 4);

%In the next few lines code we are going to try to
%find the training algortihm that results in the
%best accuracy. Because the results are varied depending
%on the random initialisations, we are going to run
%all the above code 4 more times
meanAccuracy1 = accuracy1;
meanAccuracy2 = accuracy2;

meanAccuracyGDX = accuracyGDX;
meanAccuracyLM = accuracyLM;
meanAccuracyGD = accuracyGD;
meanAccuracyGDA = accuracyGDA;
meanAccuracyGDX2 = accuracyGDX2;
meanAccuracyLM2 = accuracyLM2;
meanAccuracyGD2 = accuracyGD2;
meanAccuracyGDA2 = accuracyGDA2;

for i = 1:4
    [accuracy1 precision1 recall1] = step3(myTestData, TestDataTargets, myTrainData, myTrainDataTargets);
    meanAccuracy1 = meanAccuracy1 + accuracy1;
    
    [accuracy2 precision2 recall2] = step3b(myTestData, TestDataTargets, myTrainData, myTrainDataTargets);
    meanAccuracy2 = meanAccuracy2 + accuracy2;
    
    [accuracyGDX precisionGDX recallGDX] = step4(myTestData, TestDataTargets, myTrainData, myTrainDataTargets, 1);
    [accuracyLM precisionLM recallLM] = step4(myTestData, TestDataTargets, myTrainData, myTrainDataTargets, 2);
    [accuracyGD precisionGD recallGD] = step4(myTestData, TestDataTargets, myTrainData, myTrainDataTargets, 3);
    [accuracyGDA precisionGDA recallGDA] = step4(myTestData, TestDataTargets, myTrainData, myTrainDataTargets, 4);
    meanAccuracyGDX = meanAccuracyGDX + accuracyGDX;
    meanAccuracyLM = meanAccuracyLM + accuracyLM;
    meanAccuracyGD = meanAccuracyGD + accuracyGD;
    meanAccuracyGDA = meanAccuracyGDA + accuracyGDA;
    
    [accuracyGDX2 precisionGDX2 recallGDX2] = step4b(myTestData, TestDataTargets, myTrainData, myTrainDataTargets, 1);
    [accuracyLM2 precisionLM2 recallLM2] = step4b(myTestData, TestDataTargets, myTrainData, myTrainDataTargets, 2);
    [accuracyGD2 precisionGD2 recallGD2] = step4b(myTestData, TestDataTargets, myTrainData, myTrainDataTargets, 3);
    [accuracyGDA2 precisionGDA2 recallGDA2] = step4b(myTestData, TestDataTargets, myTrainData, myTrainDataTargets, 4);
    meanAccuracyGDX2 = meanAccuracyGDX2 + accuracyGDX2;
    meanAccuracyLM2 = meanAccuracyLM2 + accuracyLM2;
    meanAccuracyGD2 = meanAccuracyGD2 + accuracyGD2;
    meanAccuracyGDA2 = meanAccuracyGDA2 + accuracyGDA2;
end

meanAccuracy1 = meanAccuracy1/5;
meanAccuracy2 = meanAccuracy2/5;
meanAccuracyGDX = meanAccuracyGDX/5;
meanAccuracyLM = meanAccuracyLM/5;
meanAccuracyGD = meanAccuracyGD/5;
meanAccuracyGDA = meanAccuracyGDA/5;
meanAccuracyGDX2 = meanAccuracyGDX2/5;
meanAccuracyLM2 = meanAccuracyLM2/5;
meanAccuracyGD2 = meanAccuracyGD2/5;
meanAccuracyGDA2 = meanAccuracyGDA2/5;

findBestTraining(meanAccuracyGDX, meanAccuracyLM, meanaccuracyGD,...
    meanAccuracyGDA, meanAccuracyGDX2, meanAccuracyLM2, meanAccuracyGD2, meanAccuracyGDA2)