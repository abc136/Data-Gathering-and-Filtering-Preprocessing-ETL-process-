%word_count_for_test_docs.
function [words,Text]=Word_freq_my_DB_UTF8()
clc;clear all;close all;
%tic
%Text='';
for degree=2:5
    str1='D:\Doctorat\Program_Code_Source\My_DB_UTF8\3.My_DB_UTF8_frequency-';
    str12='w-';
    degree=1;
    str13='gram\';
    str1=[str1 str12 num2str(degree) str13];
    str2=').txt';
    str3='D:\Doctorat\Program_Code_Source\My_DB_UTF8\2.My_DB_UTF8_after_processing\';
    
    topic{1}='1.religion\religion (';
    topic{2}='2.sport\sport (';
    topic{3}='3.history\history (';
    topic{4}='4.technology\technology (';
    topic{5}='5.science\science (';
    topic{6}='6.law\law (';
    topic{7}='7.culture\culture (';
    topic{8}='8.philosophy\philosophy (';
    topic{9}='9.geography\geography (';
    topic{10}='10.economy\economy (';
 
for j1=1%:length(topic)
for ii1=1%2:2:20
disp(['topic ',num2str(j1),'-- Num ',num2str(ii1)]);
File_Path=[str3 topic{j1} num2str(ii1) str2];  
%File_Path='D:\Doctorat\Program_Code_Source\Test-out.txt';
fid = fopen(File_Path, 'r', 'l', 'UTF-8');
%Text= strcat(Text(1:end),fscanf(fid,'%c'));
Text{1}='';
Text{1}=fscanf(fid,'%c');
fclose(fid);
%end
%----------------
% words=strsplit(Text(1:end), {'\n',' ','\r','\r\n','  '}); 
% words = words(~cellfun('isempty',words));
[words]=feature_gram(Text,str12(1),degree);
%words = words(~cellfun('isempty',words));
%classement by alphabetic first and length second
words=sort(words);  %classement par lettre
words=words';
words(2,:) = num2cell(cellfun(@(x)length(x),words)); %calcul de taille de chaque mot
words=sortrows(words',2);  %classement par taille
words(:,3)=num2cell(ones(1,length(words))); %init
i=1;
length_words=length(words); %pour calculer le% aprés fin loop
len_words=length(words);
while i<len_words
    test=0;
    j=i+1;
    while (j<=(length(words)))&&(test==0)
        if strcmp(words{i,1},words{j,1})==true
         words{i,3}=words{i,3}+1;
         words{j,1}='';
         words{j,2}='';
         words{j,3}='';
         j=j+1;
        else 
        test=1;
        end  
        len_words=length(words);
    end
    i=j;
    len_words=length(words);
end
words(all(cellfun(@isempty,words),2), : ) = [];
words=sortrows(words,-3);  % 3 signifie que le classement selon la fréquence et le signe négative signifé descendand
%test100=0;
for i=1:length(words)
testnum=(words{i,3}*100/length_words);
%test100=test100+testnum;   %pour tester la somme s'il egal 100%
words{i,4}=[num2str(testnum) '%'];  %pour calculer le %
end
%test100

%x=['Time word count = ',num2str(toc),' s'];
%disp(x);
%msgbox(num2str(toc));

File_Path2=[str1 topic{j1} num2str(ii1) str2];
fid = fopen(File_Path2, 'w', 'l', 'UTF-8');
for j=1:length(words)
%    if (strcmp(words{j,1},b)==false) && (strcmp(words{j,1},c)==false)
        fprintf(fid,'%s     ',(words{j,1}));
        fprintf(fid,'%s     ',(num2str(words{j,3})));
        fprintf(fid,'%s',words{j,4});
 %   end
    fprintf(fid,'%s\n',' ');
end
fclose(fid);
%clear words;
end
%msgbox(num2str(toc));
end
end
end