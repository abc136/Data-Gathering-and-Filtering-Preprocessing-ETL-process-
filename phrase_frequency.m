%word_count_for_test_docs.
%function [words,Text]=phrase_frequency()
clc;clear all;close all;
%tic
%Text='';
    str1='D:\Doctorat\Program_Code_Source\My_DB_UTF8\2.My_DB_UTF8_original_per_phrase_some_characters_after_preprocessing\';
    str2='.txt';
    str3='D:\Doctorat\Program_Code_Source\My_DB_UTF8\2.My_DB_UTF8_original_per_phrase_some_characters_frequency\';
    
    topic1{1}='1.religion';
    topic1{2}='2.sport';
    topic1{3}='3.history';
    topic1{4}='4.technology';
    topic1{5}='5.science';
    topic1{6}='6.law';
    topic1{7}='7.culture';
    topic1{8}='8.philosophy';
    topic1{9}='9.geography';
    topic1{10}='10.economy';  
 
for j1=1:10
kk=1;
File_Path2=strcat(str1,topic1{j1});
D=dir([File_Path2, '\*.txt']);
Num=length(D(not([D.isdir])));
for ii1=1:Num
disp(['topic ',num2str(j1),'-- Num ',num2str(ii1)]);
File_Path=strcat(str1,topic1{j1},'\',num2str(ii1),str2);  
%File_Path='D:\Doctorat\Program_Code_Source\Test-out.txt';
fid = fopen(File_Path, 'r', 'l', 'UTF-8');
%Text= strcat(Text(1:end),fscanf(fid,'%c'));
Text='';
Text=fscanf(fid,'%c');
fclose(fid);
%end
%----------------
clear words;
words=strsplit(Text(1:end), {'\n',' ','\r','\r\n','  '}); 
words = words(~cellfun('isempty',words));
%classement by alphabetic first and length second
words=sort(words);  %classement par lettre
words(2,:) = num2cell(cellfun(@(x)length(x),words)); %calcul de taille de chaque mot
words=sortrows(words',2);  %classement par taille
words(:,3)=num2cell(ones(1,size(words,1))); %init
i=1;
length_words=size(words,1); %pour calculer le% aprés fin loop
len_words=size(words,1);

while (i<len_words)  
    test=0;
    if i<len_words
     j=i+1;
    end
    while (j<=(size(words,1)))&&(test==0)
        if strcmp(words{i,1},words{j,1})==true
         words{i,3}=words{i,3}+1;
         words{j,1}='';
         words{j,2}='';
         words{j,3}='';
         j=j+1;
        else 
        test=1;
        end  
        len_words=size(words,1);
    end
    i=j;
    len_words=size(words,1);
end
words(all(cellfun(@isempty,words),2), : ) = [];
words=sortrows(words,-3);  % 3 signifie que le classement selon la fréquence et le signe négative signifé descendand
%test100=0;

for i=1:size(words,1)
testnum=(words{i,3}*100/length_words);
%test100=test100+testnum;   %pour tester la somme s'il egal 100%
words{i,4}=strcat(num2str(testnum),'%');  %pour calculer le %
end

%test100

%x=['Time word count = ',num2str(toc),' s'];
%disp(x);
%msgbox(num2str(toc));

File_Path2=strcat(str3,topic1{j1},'\',num2str(kk),str2);
kk=kk+1;
fid = fopen(File_Path2, 'w', 'l', 'UTF-8');
for j=1:size(words,1)

fprintf(fid,'%s     ',strtrim(words{j,1}));
fprintf(fid,'%s     ',strtrim(num2str(words{j,3})));
fprintf(fid,'%s',words{j,4});
fprintf(fid,'%s\n',' ');

end
fclose(fid);

%clear words;
end
%msgbox(num2str(toc));
end
%end