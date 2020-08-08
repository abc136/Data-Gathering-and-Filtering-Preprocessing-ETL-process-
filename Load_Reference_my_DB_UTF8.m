function [words]=Load_Reference_my_DB_UTF8(degree)

 %str1='D:\Doctorat\Program_Code_Source\My_DB_UTF8\3.My_DB_UTF8_frequency\all-frequency-of-';
    str1='D:\Doctorat\Program_Code_Source\My_DB_UTF8\3.My_DB_UTF8_frequency-';
    str12='w-';
    %degree=1;
    str13='gram\all-frequency-of-';
    str1=[str1 str12 num2str(degree) str13];
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
    
File_Path{1,1}=strcat(str1,topic1{1},str2);
File_Path{1,2}=strcat(str1,topic1{2},str2);
File_Path{1,3}=strcat(str1,topic1{3},str2);
File_Path{1,4}=strcat(str1,topic1{4},str2);
File_Path{1,5}=strcat(str1,topic1{5},str2);
File_Path{1,6}=strcat(str1,topic1{6},str2);
% File_Path{1,7}=strcat(str1,topic1{7},str2);
% File_Path{1,8}=strcat(str1,topic1{8},str2);
% File_Path{1,9}=strcat(str1,topic1{9},str2);
% File_Path{1,10}=strcat(str1,topic1{10},str2);
for j=1:length(topic1)
[Text]=Read_UTF8_File(File_Path{1,j});
words{1,j}=strsplit(Text(1:end), {'\n','     ','% '}); 
% for i=2:3:(length(words{1,j})-2)
%     words{1,j}{1,i}='';
% end
words{1,j}=words{1,j}';
words{1,j}(all(cellfun(@isempty,words{1,j}),2), : ) = [];
for i=1:3:length(words{1,j})
    
    words{1,j}{i,3}=num2str(words{1,j}{i+1,1});
    words{1,j}{i,2}=num2str(words{1,j}{i+2,1});
    
    words{1,j}{i+1,1}='';
    words{1,j}{i+2,1}='';
end
words{1,j}(all(cellfun(@isempty,words{1,j}),2), : ) = [];
end
end
%End load