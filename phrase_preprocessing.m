clc;clear all;close all;

javaaddpath(fullfile('D:\Doctorat\Program_Code_Source\','','finalstemrootar2.jar'));
%javaaddpath(fullfile('D:\Doctorat\Program_Code_Source\','','finalstemrootar.jar'));


%Begin Preprocessing
%nb_words_total=0;
    str1='D:\Doctorat\Program_Code_Source\My_DB_UTF8\2.My_DB_UTF8_original_per_phrase_some_characters\';
    str2='.txt';
    str3='D:\Doctorat\Program_Code_Source\My_DB_UTF8\2.My_DB_UTF8_original_per_phrase_some_characters_after_preprocessing\';
    
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
for j=1:10  %parcourir les topics
    k=1;
    %j=1;
    

%nb_words_per_topic=0;

File_Path2=strcat(str1,topic1{j});
D=dir([File_Path2, '\*.txt']); %cette instruction s'ocupe de compter combien de fichiers txt dans un chemin.
Num=length(D(not([D.isdir])));
for i=1:Num %parcourir les docs qui exist
File_Path=strcat(str1,topic1{j},'\1 (',num2str(i),')',str2);
[Text]=Read_UTF8_File(File_Path);

%Ligne Tokenization
[Ligne_Tokens,Nb_Ligne_Tokens]=Ligne_Tokenization(Text);

%Delete all type of Noise
%[~,Ligne_Tokens]=Delete_all_Noise4(Ligne_Tokens,Nb_Ligne_Tokens); %déja filté

%Delete stopword
[~,Ligne_Tokens]=Delete_all_StopWords(Ligne_Tokens,Nb_Ligne_Tokens);

%Arabic Stemming/Root
%Khoja_ArStemRoot();   %root based stemmer.
fina.main('') %stem current phrase inside inter text file and save in inter text file also.

%save results
File_Path2='D:\Doctorat\Program_Code_Source\Test-out.txt';
[Text]=Read_UTF8_File(File_Path2);
%nb_words_per_topic=nb_words_per_topic+length(strsplit(Text, {' '}));
%nb_words_total=nb_words_total+length(strsplit(Text, {' '}));
if ~isempty(Text)
disp(['topic: ',num2str(j),' -- doc: ',num2str(k),' -- Taille: ',num2str(length(strsplit(Text, {' '})))]);
File_Path2=strcat(str3,topic1{j},'\',num2str(k),str2);
k=k+1;
fid = fopen(File_Path2, 'w', 'l', 'UTF-8');
fprintf(fid,'%s',Text);
fclose(fid);
end
clear Text;
end
%disp(['--------']);
%disp(['nb_words_of_topic= ',num2str(j),' is: ',num2str(nb_words_per_topic)]);
%disp(['--------']);
end
%disp(['**********']);
%disp(['nb_of_words_of_Corpus_is= ',num2str(nb_words_total)]);