function [BestEpochsNoValidation] = findBestEpochsNoValidation(meanaccuracyNoValidation, meanepochsNoValidation);

BestEpochsNoValidation = meanepochsNoValidation(find(meanaccuracyNoValidation == max(meanaccuracyNoValidation)));

