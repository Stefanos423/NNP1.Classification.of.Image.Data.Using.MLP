function [fmeasure] = calc_fmeasure1(precision, recall)
fmeasure1 = [];
% for i = 1:6
 %    for j = 0:5
  %       averageprec(i,j + 1) = ( precision(i, 5*j + 1) + precision(i, 5*j + 2) + precision(i, 5*j + 3) + precision(i, 5*j + 4) + precision(i, 5*j + 5) ) /5;
   %  end
% end

for i = 1:6
	averageprec(i,1) = ( precision(i,1) + precision(i,2) + precision(i,3) + precision(i,4) + precision(i,5) ) /5;
end

%  for i = 1:6
%     for j = 0:5
%         averagerec(i,j + 1) = (recall(i, 5*j + 1) + recall(i, 5*j + 2) + recall(i, 5*j + 3) + recall(i, 5*j + 4) + recall(i, 5*j + 5) ) /5;
%     end
%  end

for i = 1:6
	averagerec(i,1) = (recall(i,1) + recall(i,2) + recall(i,3) + recall(i,4) + recall(i,5) ) /5;
end
 fmeasure = averageprec.*averagerec;
 fmeasure = fmeasure./(averageprec + averagerec);
 fmeasure = 2 * fmeasure;