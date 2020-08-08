clc;clear all;close all;
%Begin Preprocessing
for j=1:1
    str1='D:\Doctorat\Program_Code_Source\osac-uft8\osac-uft8-original\';
    str2=').txt';
    str3='D:\Doctorat\Program_Code_Source\osac-uft8\osac-utf8-after-preprocessing\';
    
    topic{1}='economy\economy (';
    topic{2}='educational and family, and woman\educational and family, and woman (';
    topic{3}='health\health (';
    topic{4}='sport\sport (';
    topic{5}='law\law (';
    topic{6}='orbit\orbit (';
    topic{7}='stories\stories (';
    topic{8}='recipes and food\recipes and food (';
    topic{9}='religion and fatwas legitimacy\religion and fatwas legitimacy (';
    topic{10}='history\history (';

for i=302:557
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
disp(['doc ',num2str(j),'-- Num ',num2str(i-301)]);
%save results
File_Path2='D:\Doctorat\Program_Code_Source\Test-out.txt';
[Text]=Read_UTF8_File(File_Path2);
File_Path2=strcat(str3,topic{j},num2str(i),str2);
fid = fopen(File_Path2, 'w', 'l', 'UTF-8');
fprintf(fid,'%s',Text);
fclose(fid);
end
end