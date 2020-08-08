clc;clear all;close all;
str1='D:\Doctorat\Program_Code_Source\My_DB_UTF8\1.My_DB_UTF8_original_pour_segments\';
    str2=').txt';
    str22='.txt';
    str3='D:\Doctorat\Program_Code_Source\My_DB_UTF8\2.My_DB_UTF8_original_per_phrase_some_characters\'; %changer path!!!
    
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
for j=1:length(topic1)  %parcourir les topics
k=1;    

%j=1;
    
for i=2:2:20 %parcourir les docs de tests
disp(['topic ',num2str(j),'-- Num ',num2str(i)]);
%Read files
File_Path=strcat(str1,topic{j},num2str(i),str2);
[Text]=Read_UTF8_File(File_Path);

%Tokenization if we want tokenize a text into "."
%phrase{i,j}=strsplit(Text(1:end), {'.'}); 

%Tokenization into arabic phrases: "." "\n"  ":"  "fasila 3arabia" "ta3agob 3arabia" "istifham 3arabia" "point virgule arabic"
phrase{i,j}=strsplit(Text(1:end), {'.' ':' '\n' char(1548) char(0033) char(1567) char(1563)}); 

%Paragraph Tokenization if we want tokenize a text into paragraphs
%phrase{i,j}=strsplit(Text(1:end), {'\n'}); %delete "%" when you want to use tokenization for paragraphs.

phrase_intermidiare=strsplit(Text(1:end), {'\n'}); 
b={'.' ':' char(1548) char(0033) char(1567) char(1563)};
kk=1;
for s1=1:length(phrase_intermidiare)
    for s2=1:length(phrase_intermidiare{1,s1})
      if ismember(phrase_intermidiare{1,s1}(s2),b)==true
        ss(kk)=phrase_intermidiare{1,s1}(s2);
        kk=kk+1;
      end
    end
        ss(kk)='.';   %je remplace la fin d'une phrase ou paragraph par point (car ya pas compatibilité en matalb pour déltecter la séparation en terme de \n)
        kk=kk+1;
end
        
% for s=1:length(Text(1:end))
%     if ismember(Text(s),b)==true
%         ss(kk)=Text(s);
%         kk=kk+1;
% %     elseif strcmp(Text(s),'\n')
% %         ss(kk)='.';
% %         kk=kk+1;
%     end
% end



for jj=1:length(phrase{i,j})
File_Path2=strcat(str3,topic1{j},'\1 (',num2str(k),')',str22);

%phrase{i,j}{1,jj}=strtrim(phrase{i,j}{1,jj}); % pour le cas on a rien !! supprimer automatiquement.
if ~isempty(strtrim(phrase{i,j}{1,jj})) % pour le cas on a rien !! supprimer automatiquement (c à dire faire skip ci tout)
fid = fopen(File_Path2, 'w', 'l', 'UTF-8');
fprintf(fid,'%s',strtrim(phrase{i,j}{1,jj}));
fprintf(fid,'%s',ss(jj));
fclose(fid);
k=k+1;
end;


end


end
end

% File_Path2=strcat(str3,topic1{j},num2str(i),str22);
% fid = fopen(File_Path2, 'w', 'l', 'UTF-8');
% for j=1:length(words)
% fprintf(fid,'%s     ',strtrim(words{j,1}));
% fprintf(fid,'%s     ',strtrim(num2str(words{j,3})));
% fprintf(fid,'%s',words{j,4});
% fprintf(fid,'%s\n',' ');
% end
% fclose(fid);