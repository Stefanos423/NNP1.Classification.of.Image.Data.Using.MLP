function [Validation epoch] = findBestValidation(meanaccuracyValidation, meanepochValidation)

Validation = 0.65 + (0.05 * find(meanaccuracyValidation == max(meanaccuracyValidation))); 
epoch = meanepochValidation(find(meanaccuracyValidation == max(meanaccuracyValidation)));