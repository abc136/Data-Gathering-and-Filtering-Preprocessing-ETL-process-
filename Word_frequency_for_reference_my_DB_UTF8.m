%word_count_for_reference.
function [words,Text]=Word_frequency_for_reference_my_DB_UTF8()
clc;clear all;close all;
%tic
Text{1}='';   
for degree=1:5    
% str1='D:\Doctorat\Program_Code_Source\My_DB_UTF8\3.My_DB_UTF8_frequency\';
    str1='D:\Doctorat\Program_Code_Source\My_DB_UTF8\3.My_DB_UTF8_frequency-';
    str12='l-';
    %degree=3;
    str13='gram\';
    str1=[str1 str12 num2str(degree) str13];
    str2=').txt';
    str22='.txt';
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
    Text{1}=''; 
    disp(['topic ',num2str(j1)]);
for ii1=1:2:20
File_Path=strcat(str3,topic{j1},num2str(ii1),str2);  
%File_Path='D:\Doctorat\Program_Code_Source\Test-out.txt';
fid = fopen(File_Path, 'r', 'l', 'UTF-8');
Text{1}= strcat(Text{1}(1:end),fscanf(fid,'%c'));
%Text=fscanf(fid,'%c');
fclose(fid);
end
%end
%----------------
% words=strsplit(Text(1:end), {'\n',' ','\r','\r\n','  '}); 
% words = words(~cellfun('isempty',words));
[words]=feature_gram(Text,str12(1),degree);
%disp([num2str(length(words))]); %pour calculer le nombre de mot de chaque topic
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
words{i,4}=strcat(num2str(testnum),'%');  %pour calculer le %
end
%test100

%x=['Time word count = ',num2str(toc),' s'];
%disp(x);
%msgbox(num2str(toc));

File_Path2=strcat(str1,'all-frequency-of-',topic1{j1},str22);
fid = fopen(File_Path2, 'w', 'l', 'UTF-8');
for j=1:length(words)
fprintf(fid,'%s     ',(words{j,1}));
fprintf(fid,'%s     ',(num2str(words{j,3})));
fprintf(fid,'%s',words{j,4});
fprintf(fid,'%s\n',' ');
end
fclose(fid);
clear words;
end
%msgbox(num2str(toc));
%end
end
end