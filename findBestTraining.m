function [name neuronsFirstLevel neuronsSecondLevel] = ...
findBestTraining (meanAccuracyGDX, meanAccuracyLM, meanAccuracyGD, meanAccuracyGDA, meanAccuracyGDX2, meanAccuracyLM2, meanaccuracyGD2, meanAccuracyGDA2) 

maxNum = 0;
check = 0;

[M, I] = max(meanAccuracyGDX(:));
if (M > maxNum)
	maxNum = M;
	maxI = I;
	name = 'traingdx';
end

[M, I] = max(meanAccuracyLM(:));
if(M > maxNum)
	maxNum = M;
	maxI = I;
	name = 'trainlm';
end

[M, I] = max(meanAccuracyGD(:));
if (M > maxNum)
	maxNum = M;
	maxI = I;
	name = 'traingd';
end

[M, I] = max(meanAccuracyGDA(:));
if (M > maxNum)
	maxNum = M;
	maxI = I;
	name = 'traingda';
end

[M, I] = max(meanAccuracyGDX2(:));
if (M > maxNum)
	maxNum = M;
	maxI = I;
	name = 'traingdx';
	check = 2;
end

[M, I] = max(meanAccuracyLM2(:));
if(M > maxNum)
	maxNum = M;
	maxI = I;
	name = 'trainlm';
	check = 2;
end

[M, I] = max(meanAccuracyGD2(:));
if (M > maxNum)
	maxNum = M;
	maxI = I;
	name = 'traingd';
	check = 2;
end

[M, I] = max(meanAccuracyGDA2(:));
if (M > maxNum)
	maxNum = M;
	maxI = I;
	name = 'traingda';
	check = 2;
end

if (check == 2)
	[x, y] = ind2sub(size(meanAccuracyGD2), maxI);
    neuronsFirstLevel = x*5;
    neuronsSecondLevel = y*5;
else
	x = I;
	y = 0;
    neuronsFirstLevel = x*5;
    neuronsSecondLevel = 0;
end