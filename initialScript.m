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