function Avg = getAvgEval(evals)
   Avg = struct;
   Avg.accuracy = 0;
   
   Avg.precision = 0;
   Avg.recall = 0;
   Avg.f_measure = 0;
   Avg.accuracy = 0;
   
   
   len = length(evals);
for i=1:len
   Avg.accuracy = Avg.accuracy + evals{i}.accuracy;
    
   Avg.precision = Avg.precision + evals{i}.precision;
   Avg.recall = Avg.recall + evals{i}.recall;
   Avg.f_measure = Avg.f_measure + evals{i}.f_measure;
   
end

   Avg.accuracy = Avg.accuracy / len;
   
   Avg.precision = Avg.precision / len;
   Avg.recall = Avg.recall / len;
   Avg.f_measure = Avg.f_measure / len;
   

end