clear all; close all; clc;

 


delete('train_all.txt');
addpath('Libsvm/matlab');   % Libsvm package is used 
cc = power(2,-5); 

%  KeyWordExtract();
%  wordfrequency();


%data read%

system('type regular_train_bug.txt cve_train_bug.txt > train_all.txt');

number_class = 2;
clabel= [1 2];
data = dlmread('train_all.txt');

%data read%

%cross validation 

ts_num_max = 5000;
no_of_fold=10;
data_without_classlevel = data(:, 2:end);
data_classlevel = data(:, 1);
[row, colum] = size(data_without_classlevel);

for kk=1:no_of_fold 
    
    tr_idx = [];        
    ts_idx = [];
    
	for jj = 1:number_class,
        
        idx_label = find(data_classlevel == clabel(jj));
        num = length(idx_label);
        rng(kk+jj);
        idx_rand = randperm(num);
        tr_num=size(idx_label,1)-ceil(size(idx_label,1)/no_of_fold);
        if num > tr_num + ts_num_max
            tr_idx = [tr_idx; idx_label(idx_rand(1:tr_num))];
            ts_idx = [ts_idx; idx_label(idx_rand(tr_num+1:tr_num+ts_num_max))];
        else
            tr_idx = [tr_idx; idx_label(idx_rand(1:tr_num))];
            ts_idx = [ts_idx; idx_label(idx_rand(tr_num+1:end))];
        end    
    end
    tr_fea = zeros(length(tr_idx), colum);
    tr_label = zeros(length(tr_idx), 1);
    ts_fea = zeros(length(ts_idx), colum);
    ts_label = zeros(length(ts_idx), 1);
        
     
    tr_fea = data_without_classlevel(tr_idx,:);
    tr_label = data_classlevel(tr_idx);
    ts_fea = data_without_classlevel(ts_idx,:);
    ts_label = data_classlevel(ts_idx);

%cross validation 

%Classification

% % % %     decision tree
    newtraining_feature =  tr_fea;
    newts_fea = ts_fea;

    model = fitctree(newtraining_feature, tr_label);
    pred_val = predict(model, newts_fea);
    

% % % %     decision tre


%Classification

    accuracy = sum(eq(pred_val,ts_label(:,1)))/size(ts_label,1);
    EVAL = EvalMetric(ts_label,pred_val);

    evals{kk} = EVAL;
    accuracies(kk)= accuracy;

    fid = fopen('result_new.txt', 'a');
    fprintf('Iter---> %d : accurecy: %f \n', kk, accuracy);
    fprintf(fid, 'Iter---> %d : accurecy: %f \n', kk, accuracy);
    fprintf('Iter---> %d : True Positive(TP): %f \n', kk, EVAL.tp);
    fprintf('Iter---> %d : True Negative(TN): %f \n', kk, EVAL.tn);
    fprintf('Iter---> %d : Precision: %f \n', kk,EVAL.precision);
    fprintf('Iter---> %d : Recall: %f \n', kk, EVAL.recall);
    fprintf('Iter---> %d : F-measure: %f \n', kk, EVAL.f_measure);
    fclose(fid);
end

Avg = getAvgEval(evals);
fid = fopen('result_new.txt', 'a');

fprintf('Average accurecy: %f\n', mean(accuracies));
fprintf(fid, 'Average accurecy: %f\n', mean(accuracies));

fclose(fid);

fclose('all');