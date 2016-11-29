function [name x y] = ...
findBestTraining (meanAccuracyGDX, meanAccuracyLM, meanaccuracyGD, meanAccuracyGDA, meanAccuracyGDX2, meanAccuracyLM2, meanaccuracyGD2, meanAccuracyGDA2) 

maxNum = 0;
check = 0;

[M, I] = max(meanAccuracyGDX(:));
if (M > maxNum)
	maxNum = M;
	maxI = I;
	name = 'GDX';
end

[M, I] = max(meanAccuracyLM(:));
if(M > maxNum)
	maxNum = M;
	maxI = I;
	name = 'LM';
end

[M, I] = max(meanAccuracyGD(:));
if (M > maxNum)
	maxNum = M;
	maxI = I;
	name = 'GD';
end

[M, I] = max(meanAccuracyGDA(:));
if (M > maxNum)
	maxNum = M;
	maxI = I;
	name = 'GDA';
end

[M, I] = max(meanAccuracyGDX2(:));
if (M > maxNum)
	maxNum = M;
	maxI = I;
	name = 'GDX2';
	check = 2;
end

[M, I] = max(meanAccuracyLM2(:));
if(M > maxNum)
	maxNum = M;
	maxI = I;
	name = 'LM2';
	check = 2;
end

[M, I] = max(meanAccuracyGD2(:));
if (M > maxNum)
	maxNum = M;
	maxI = I;
	name = 'GD2';
	check = 2;
end

[M, I] = max(meanAccuracyGDA2(:));
if (M > maxNum)
	maxNum = M;
	maxI = I;
	name = 'GDA2';
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