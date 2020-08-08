clc;clear all;close all;
%Begin Preprocessing
nb_words_total=0;
for j=1:10  %parcourir les topics
    %j=1;
    str1='D:\Doctorat\Program_Code_Source\My_DB_UTF8\1.My_DB_UTF8_original\';
    str2=').txt';
    str3='D:\Doctorat\Program_Code_Source\My_DB_UTF8\2.My_DB_UTF8_after_processing_without_stemming\';
    
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
    
nb_words_per_topic=0;
for i=1:20 %parcourir les docs
File_Path=strcat(str1,topic{j},num2str(i),str2);
[Text]=Read_UTF8_File(File_Path);

%Ligne Tokenization
[Ligne_Tokens,Nb_Ligne_Tokens]=Ligne_Tokenization(Text);

%Delete all type of Noise
[Nb_Noise_Letters,Ligne_Tokens]=Delete_all_Noise4(Ligne_Tokens,Nb_Ligne_Tokens);

%Delete stopword
[Nb_StopWords,Ligne_Tokens]=Delete_all_StopWords(Ligne_Tokens,Nb_Ligne_Tokens);

%Arabic Stemming/Root
Khoja_ArStemRoot();   %root based stemmer.

%save results
File_Path2='D:\Doctorat\Program_Code_Source\Test-in.txt';
[Text]=Read_UTF8_File(File_Path2);
nb_words_per_topic=nb_words_per_topic+length(strsplit(Text, {' '}));
nb_words_total=nb_words_total+length(strsplit(Text, {' '}));
disp(['topic: ',num2str(j),' -- doc: ',num2str(i),' -- Taille: ',num2str(length(strsplit(Text, {' '})))]);
File_Path2=strcat(str3,topic{j},num2str(i),str2);
fid = fopen(File_Path2, 'w', 'l', 'UTF-8');
fprintf(fid,'%s',Text);
fclose(fid);
end
disp(['--------']);
disp(['nb_words_of_topic= ',num2str(j),' is: ',num2str(nb_words_per_topic)]);
disp(['--------']);
end
disp(['**********']);
disp(['nb_of_words_of_Corpus_is= ',num2str(nb_words_total)]);