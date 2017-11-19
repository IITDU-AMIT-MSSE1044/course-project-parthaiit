clc
close all
clear all
%  delete('train.txt');
delete('regular_train_bug.txt');
Paragraph=lower(fileread('regular_output_bug.txt'));

% Paragraph=lower(fileread('output1.txt'));

AlphabetFlag=Paragraph>=97 & Paragraph<=122;  % finding alphabets

DelimFlag=find(AlphabetFlag==0); % considering non-alphabets delimiters
WordLength=[DelimFlag(1), diff(DelimFlag)];
Paragraph(DelimFlag)=[]; % setting delimiters to white space
Words=mat2cell(Paragraph, 1, WordLength-1); % cut the paragraph into words


% %%% stop words removal 
stopwords_cellstring={'a', 'about', 'above', 'above', 'across', 'after', ...
    'afterwards', 'again', 'against', 'all', 'almost', 'alone', 'along', ...
    'already', 'also','although','always','am','among', 'amongst', 'amoungst', ...
    'amount',  'an', 'and', 'another', 'any','anyhow','anyone','anything','anyway', ...
    'anywhere', 'are', 'around', 'as',  'at', 'back','be','became', 'because','become',...
    'becomes', 'becoming', 'been', 'before', 'beforehand', 'behind', 'being', 'below',...
    'beside', 'besides', 'between', 'beyond', 'bill', 'both', 'bottom','but', 'by',...
    'call', 'can', 'cannot', 'cant', 'co', 'con', 'could', 'couldnt', 'cry', 'de',...
    'describe', 'detail', 'do', 'done', 'down', 'due', 'during', 'each', 'eg', 'eight',...
    'either', 'eleven','else', 'elsewhere', 'empty', 'enough', 'etc', 'even', 'ever', ...
    'every', 'everyone', 'everything', 'everywhere', 'except', 'few', 'fifteen', 'fify',...
    'fill', 'find', 'fire', 'first', 'five', 'for', 'former', 'formerly', 'forty', 'found',...
    'four', 'from', 'front', 'full', 'further', 'get', 'give', 'go', 'had', 'has', 'hasnt',...
    'have', 'he', 'hence', 'her', 'here', 'hereafter', 'hereby', 'herein', 'hereupon', ...
    'hers', 'herself', 'him', 'himself', 'his', 'how', 'however', 'hundred', 'ie', 'if',...
    'in', 'inc', 'indeed', 'interest', 'into', 'is', 'it', 'its', 'itself', 'keep', 'last',...
    'latter', 'latterly', 'least', 'less', 'ltd', 'made', 'many', 'may', 'me', 'meanwhile',...
    'might', 'mill', 'mine', 'more', 'moreover', 'most', 'mostly', 'move', 'much', 'must',...
    'my', 'myself', 'name', 'namely', 'neither', 'never', 'nevertheless', 'next', 'nine',...
    'no', 'nobody', 'none', 'noone', 'nor', 'not', 'nothing', 'now', 'nowhere', 'of', 'off',...
    'often', 'on', 'once', 'one', 'only', 'onto', 'or', 'other', 'others', 'otherwise',...
    'our', 'ours', 'ourselves', 'out', 'over', 'own','part', 'per', 'perhaps', 'please',...
    'put', 'rather', 're', 'same', 'see', 'seem', 'seemed', 'seeming', 'seems', 'serious',...
    'several', 'she', 'should', 'show', 'side', 'since', 'sincere', 'six', 'sixty', 'so',...
    'some', 'somehow', 'someone', 'something', 'sometime', 'sometimes', 'somewhere', ...
    'still', 'such', 'system', 'take', 'ten', 'than', 'that', 'the', 'their', 'them',...
    'themselves', 'then', 'thence', 'there', 'thereafter', 'thereby', 'therefore', ...
    'therein', 'thereupon', 'these', 'they', 'thickv', 'thin', 'third', 'this', 'those',...
    'though', 'three', 'through', 'throughout', 'thru', 'thus', 'to', 'together', 'too',...
    'top', 'toward', 'towards', 'twelve', 'twenty', 'two', 'un', 'under', 'until', 'up',...
    'upon', 'us', 'very', 'via', 'was', 'we', 'well', 'were', 'what', 'whatever', 'when',...
    'whence', 'whenever', 'where', 'whereafter', 'whereas', 'whereby', 'wherein',...
    'whereupon', 'wherever', 'whether', 'which', 'while', 'whither', 'who', 'whoever',...
    'whole', 'whom', 'whose', 'why', 'will', 'with', 'within', 'without', 'would', 'yet',...
    'you', 'your', 'yours', 'yourself', 'yourselves', 'the'};
% 
% for i=1:size(Words,2);
%     
%  
% 
%     
% % split1 = regexp(Words,'\s','Split');
out_str1 = Words(~ismember(Words,stopwords_cellstring));
% out_str{i} = ~ismember(split1,stopwords_cellstring);
% 
% end 
% %%% stop words removal 


[SortWords, Ia, Ic]=unique(out_str1);  %finding unique words and their subscript

Bincounts = histc(Ic,1:size(Ia, 1));%finding their occurence
[SortBincounts, IndBincounts]=sort(Bincounts, 'descend');% finding their frequency

FreqWords=SortWords(IndBincounts); % sorting words according to their frequency
FreqWords(1)=[];SortBincounts(1)=[]; % dealing with remaining white space

FreqWords = FreqWords(1:1000);
 


fid  = fopen('regular_output_bug.txt','r');
count = 1; 
while 1 
   tline = fgetl(fid);
    if ~ischar(tline)
       break;
   end
    tline = lower(tline);
   tline = regexp(tline,'\s','Split');
   n = length(FreqWords);
    counts = zeros(1, n);
   for j=1:size(tline,2)
%    counts(j) = sum(strcmpi(tline, FreqWords{j}));
 [aa,bb] = ismember(tline{j}, FreqWords);
  if aa>0
      
  counts(bb) = sum(ismember(tline{j}, FreqWords));
  
  end
 
   end
   
% 
   [nrows,ncols] = size(FreqWords);
   
%    fid1 = fopen('train.txt','a');
   
   fid1 = fopen('regular_train_bug.txt','a');
   fprintf(fid1,'1\t' );
   
for  i = 1:ncols
    fprintf(fid1,'%d\t' ,counts(i));
end
   fprintf(fid1,'\n' );
fclose(fid1);
end
fclose(fid);








% for cve bug

 
delete('cve_train_bug.txt');
Paragraph=lower(fileread('regular_output_bug.txt'));

% Paragraph=lower(fileread('output1.txt'));

AlphabetFlag=Paragraph>=97 & Paragraph<=122;  % finding alphabets

DelimFlag=find(AlphabetFlag==0); % considering non-alphabets delimiters
WordLength=[DelimFlag(1), diff(DelimFlag)];
Paragraph(DelimFlag)=[]; % setting delimiters to white space
Words=mat2cell(Paragraph, 1, WordLength-1); % cut the paragraph into words


% %%% stop words removal 
stopwords_cellstring={'a', 'about', 'above', 'above', 'across', 'after', ...
    'afterwards', 'again', 'against', 'all', 'almost', 'alone', 'along', ...
    'already', 'also','although','always','am','among', 'amongst', 'amoungst', ...
    'amount',  'an', 'and', 'another', 'any','anyhow','anyone','anything','anyway', ...
    'anywhere', 'are', 'around', 'as',  'at', 'back','be','became', 'because','become',...
    'becomes', 'becoming', 'been', 'before', 'beforehand', 'behind', 'being', 'below',...
    'beside', 'besides', 'between', 'beyond', 'bill', 'both', 'bottom','but', 'by',...
    'call', 'can', 'cannot', 'cant', 'co', 'con', 'could', 'couldnt', 'cry', 'de',...
    'describe', 'detail', 'do', 'done', 'down', 'due', 'during', 'each', 'eg', 'eight',...
    'either', 'eleven','else', 'elsewhere', 'empty', 'enough', 'etc', 'even', 'ever', ...
    'every', 'everyone', 'everything', 'everywhere', 'except', 'few', 'fifteen', 'fify',...
    'fill', 'find', 'fire', 'first', 'five', 'for', 'former', 'formerly', 'forty', 'found',...
    'four', 'from', 'front', 'full', 'further', 'get', 'give', 'go', 'had', 'has', 'hasnt',...
    'have', 'he', 'hence', 'her', 'here', 'hereafter', 'hereby', 'herein', 'hereupon', ...
    'hers', 'herself', 'him', 'himself', 'his', 'how', 'however', 'hundred', 'ie', 'if',...
    'in', 'inc', 'indeed', 'interest', 'into', 'is', 'it', 'its', 'itself', 'keep', 'last',...
    'latter', 'latterly', 'least', 'less', 'ltd', 'made', 'many', 'may', 'me', 'meanwhile',...
    'might', 'mill', 'mine', 'more', 'moreover', 'most', 'mostly', 'move', 'much', 'must',...
    'my', 'myself', 'name', 'namely', 'neither', 'never', 'nevertheless', 'next', 'nine',...
    'no', 'nobody', 'none', 'noone', 'nor', 'not', 'nothing', 'now', 'nowhere', 'of', 'off',...
    'often', 'on', 'once', 'one', 'only', 'onto', 'or', 'other', 'others', 'otherwise',...
    'our', 'ours', 'ourselves', 'out', 'over', 'own','part', 'per', 'perhaps', 'please',...
    'put', 'rather', 're', 'same', 'see', 'seem', 'seemed', 'seeming', 'seems', 'serious',...
    'several', 'she', 'should', 'show', 'side', 'since', 'sincere', 'six', 'sixty', 'so',...
    'some', 'somehow', 'someone', 'something', 'sometime', 'sometimes', 'somewhere', ...
    'still', 'such', 'system', 'take', 'ten', 'than', 'that', 'the', 'their', 'them',...
    'themselves', 'then', 'thence', 'there', 'thereafter', 'thereby', 'therefore', ...
    'therein', 'thereupon', 'these', 'they', 'thickv', 'thin', 'third', 'this', 'those',...
    'though', 'three', 'through', 'throughout', 'thru', 'thus', 'to', 'together', 'too',...
    'top', 'toward', 'towards', 'twelve', 'twenty', 'two', 'un', 'under', 'until', 'up',...
    'upon', 'us', 'very', 'via', 'was', 'we', 'well', 'were', 'what', 'whatever', 'when',...
    'whence', 'whenever', 'where', 'whereafter', 'whereas', 'whereby', 'wherein',...
    'whereupon', 'wherever', 'whether', 'which', 'while', 'whither', 'who', 'whoever',...
    'whole', 'whom', 'whose', 'why', 'will', 'with', 'within', 'without', 'would', 'yet',...
    'you', 'your', 'yours', 'yourself', 'yourselves', 'the'};
% 
% for i=1:size(Words,2);
%     
%  
% 
%     
% % split1 = regexp(Words,'\s','Split');
out_str1 = Words(~ismember(Words,stopwords_cellstring));
% out_str{i} = ~ismember(split1,stopwords_cellstring);
% 
% end 
% %%% stop words removal 


[SortWords, Ia, Ic]=unique(out_str1);  %finding unique words and their subscript

Bincounts = histc(Ic,1:size(Ia, 1));%finding their occurence
[SortBincounts, IndBincounts]=sort(Bincounts, 'descend');% finding their frequency

FreqWords=SortWords(IndBincounts); % sorting words according to their frequency
FreqWords(1)=[];SortBincounts(1)=[]; % dealing with remaining white space

FreqWords = FreqWords(1:1000);
 


fid  = fopen('cve_output_bug.txt','r');
count = 1; 
while 1 
   tline = fgetl(fid);
    if ~ischar(tline)
       break;
   end
    tline = lower(tline);
   tline = regexp(tline,'\s','Split');
   n = length(FreqWords);
    counts = zeros(1, n);
   for j=1:size(tline,2)
%    counts(j) = sum(strcmpi(tline, FreqWords{j}));
 [aa,bb] = ismember(tline{j}, FreqWords);
  if aa>0
      
  counts(bb) = sum(ismember(tline{j}, FreqWords));
  
  end
 
   end
   
% 
   [nrows,ncols] = size(FreqWords);
   
%    fid1 = fopen('train.txt','a');
   
   fid1 = fopen('cve_train_bug.txt','a');
   fprintf(fid1,'2\t' );
   
for  i = 1:ncols
    fprintf(fid1,'%d\t' ,counts(i));
end
   fprintf(fid1,'\n' );
fclose(fid1);
end
fclose(fid);




 