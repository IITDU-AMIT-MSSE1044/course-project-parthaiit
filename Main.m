clear all; close all; clc;

delete('train_all.txt');
addpath('Libsvm/matlab');   % Libsvm package is used 
cc = power(2,-5); 

%  KeyWordExtract();
%  wordfrequency();


%data read%

system('type regular_train_bug.txt cve_train_bug.txt > train_all.txt');

nclass = 2;
clabel = [1 2];
data = dlmread('train_all.txt');

%data read%

%cross validation 

ts_num_max = 5000;
no_of_fold=10;
xa = data(:, 2:end);
Sapp = data(:, 1);
[m, dim] = size(xa);

for kk=1:no_of_fold 
    
    tr_idx = [];        
    ts_idx = [];
    
	for jj = 1:nclass,
        
        idx_label = find(Sapp == clabel(jj));
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
    tr_fea = zeros(length(tr_idx), dim);
    tr_label = zeros(length(tr_idx), 1);
    ts_fea = zeros(length(ts_idx), dim);
    ts_label = zeros(length(ts_idx), 1);
        
     
    tr_fea = xa(tr_idx,:);
    tr_label = Sapp(tr_idx);
    ts_fea = xa(ts_idx,:);
    ts_label = Sapp(ts_idx);

%cross validation 

%Classification

% % % %     decision tree
    newtr_fea =  tr_fea;
    newts_fea = ts_fea;

    model = fitctree(newtr_fea, tr_label);
    pred_val = predict(model, newts_fea);
    
% % % %     decision tree

% % %     SVM

%     tr_fea=tr_fea(:, selectedFeatures);
%     ts_fea=ts_fea(:, selectedFeatures);
    

     % feature normalization
%     f_min = min(tr_fea);    f_max = max(tr_fea);    f_tmp = f_max-f_min;
%     r = 1./ (f_max - f_min);    r(f_tmp < 1e-10) = 1;
% %     tr_fea = (tr_fea - repmat(f_min,length(tr_label),1)).*repmat(r,length(tr_label),1);
%     
%     c_chosen(1) = 1;
%     options = [ '-s 0 -t 0 ' '-g ' num2str(power(2, -7)) ' -c ' num2str(cc(c_chosen(1)))];      % Libsvm parameter setting (linear SVM is used)
%     model = svmtrain(double(tr_label), sparse(newtr_fea), options);                                      
%     clear tr_fea;
%     
% %      ts_fea = (ts_fea - repmat(f_min,length(ts_label),1)).*repmat(r,length(ts_label),1);     % normalize the test feature    
%         [C, Acc, d2p] = svmpredict(double(ts_label), sparse(newts_fea), model);                % svm test 
%         clear ts_fea;
%         pred_val=C;
%     
% % %     SVM     


%Classification

    accuracy = sum(eq(pred_val,ts_label(:,1)))/size(ts_label,1);
    EVAL = EvalMetric(ts_label,pred_val);

    evals{kk} = EVAL;
    accuracies(kk)= accuracy;

    fid = fopen('result_new.txt', 'a');
    fprintf('Iter---> %d : accu: %f \n', kk, accuracy);
    fprintf(fid, 'Iter---> %d : accu: %f \n', kk, accuracy);
    fclose(fid);
end

Avg = getAvgEval(evals);
fid = fopen('result_new.txt', 'a');
fprintf('avg accu: %f\n', mean(accuracies));
fprintf(fid, 'avg accu: %f\n', mean(accuracies));
fclose(fid);

fclose('all');