clc;clear all;close all;
[words]=Load_Reference_my_DB_UTF8(1);
str1='D:\Doctorat\Program_Code_Source\My_DB_UTF8\2.My_DB_UTF8_original_per_pharaphs_frequency\';
str2='.txt';
     
    topic1{1}='1.religion';
    topic1{2}='2.sport';
    topic1{3}='3.history';
    topic1{4}='4.technology';
    topic1{5}='5.science';
    topic1{6}='6.law';
    %topic1{7}='7.culture';
    %topic1{8}='8.philosophy';
    %topic1{9}='9.geography';
    %topic1{10}='10.economy';  
         
%NO_test_vect=[0];  %Nombre de mots de test docs   (length(words_test))
NO_ref_vect=[10,20,50,100,200,300,500];  %Nombre de mots clés Optimle de reference docs
% for h=1:10
%     disp([num2str(h)]);
    

for  y=1:length(NO_ref_vect)    
disp(['Nb words from refrence topic=',num2str(NO_ref_vect(y))]);
Nb_doc_test=0;
for j=1:length(topic1) %parcourir tous les topic
    Nb_doc(j)=0;
File_Path2=strcat(str1,topic1{j});
D=dir([File_Path2, '\*.txt']);
Num=length(D(not([D.isdir])));
for ii=1:Num  %parcourir les docs de test du topic
File_Path=strcat(str1,topic1{j},'\',num2str(ii),str2);
%disp([File_Path,num2str(j),num2str(ii)]);
%topic id for phrases.
[Text]=Read_UTF8_File(File_Path);
if length(strsplit(Text(1:end), {'\n'}))>=10
[topic_is]=phrase_topic_identification(File_Path,topic1,words,NO_ref_vect(y));
%disp([num2str(ii),'-',topic1{j},'-',num2str(length(strsplit(Text(1:end), {'\n'}))),'-',topic_is]);
%disp([num2str(Nb_doc(j)),'  ',num2str(Nb_doc_test)]);
%disp([topic_is]);
Nb_doc(j)=Nb_doc(j)+1;
Nb_doc_test=Nb_doc_test+1;
% disp([num2str(j),'-',topic1{j},'  ',num2str(Nb_doc(j)),'/',num2str((imax(j)-imin(j))+1),' -- ',topic_is{1},' - ',topic_is{2},' - ',topic_is{3}]);
for u=1%:2
result{u}{Nb_doc(j),j}=topic_is{u};  %prend le resultat de chaque decision
end
end

end
end
disp(['**********************************']);
for u=1%:2
    c(u)=0;
    for j=1:length(topic1)
        c1=0;
        for ii=1:Nb_doc(j)
            if strcmp(result{u}{ii,j},topic1{j})==true
                c(u)=c(u)+1;
                c1=c1+1;
                %disp([num2str(result{u}{ii,j}),'  ',num2str(topic1{j})]);
                %disp([c(u)]);                
            end
        end
        %disp(['Result ',num2str(Nb_doc(j)),'   =',num2str(c1*100/Nb_doc(j)),' %']); %le % de chaque topic
    end
end
for u=1%:2
disp(['Result ',num2str(u),'=',num2str(c(u)*100/Nb_doc_test),' %']);
end

%save results{u} topic identification
% for u=1:3
% File_Path=strcat(str1,'-','x=',num2str(NO_test_vect(x)),'y=',num2str(NO_ref_vect(y)),' -- ',num2str(c(u)*100/Nb_doc_test),' %.txt');
% fid = fopen(File_Path, 'a', 'l', 'UTF-8');
% for j=1:10
% fprintf(fid,'%s\n','****************************');
% fprintf(fid,'%s\n',topic1{j});
% fprintf(fid,'%s\n','****************************');
% for ii=1:Nb_doc(j)
% fprintf(fid,'%s\n',result{u}{ii,j});
% end
% end
% fclose(fid);
% end;

end

% end