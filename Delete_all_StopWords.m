function [Nb_StopWords,Ligne_Tokens]=Delete_all_StopWords(Ligne_Tokens,Nb_Ligne_Tokens)
   %Load all StopWords 
    for i=1:11
     StopList_File_Path=strcat('D:\Doctorat\Program_Code_Source\StopWordsList\',num2str(i),'Gram StopWords.txt');
     fid = fopen(StopList_File_Path, 'r', 'l', 'UTF-8');
     TextStopList{1,i} = fscanf(fid,'%c');
     fclose(fid);
    end
   %End Load.
 Nb_StopWords=0;  
for i=1:Nb_Ligne_Tokens   
    phrase=strsplit(Ligne_Tokens{1,i}, {' '});
    new_phrase='';
    isStopWord='';
    for j=1:length(phrase)   
        %Begin Search phrase{1,j} is stop word or no             
         if (length(phrase{1,j})>=2)&&(length(phrase{1,j})<=10)
         isStopWord=strfind(TextStopList{1,length(phrase{1,j})},phrase{1,j});
         elseif (length(phrase{1,j})>11)
         isStopWord=[]; %forcément c'est pas un stopword car dépasse 10 lettre 
         elseif (length(phrase{1,j})<=1)
         isStopWord=1; %forcément c'est un stopword car il est moins de 2 lettre !!
         end
            if length(isStopWord)>=1  % so is stop word ,so delete it.
                phrase{1,j}='';         % so delete it.
                Nb_StopWords=Nb_StopWords+1;  
            else 
                new_phrase=strcat([new_phrase ' ' phrase{1,j}]);  % add to stem later
            end  
        %End Search phrase{1,j} is stop word or no
    end
    Ligne_Tokens{1,i}=new_phrase;    
end
%save all phrases into "Text-in.txt"
if ~exist('D:\Doctorat\Program_Code_Source\Test-in.txt','file')
    error('Error. \n Input file does not exist.');
else
fid = fopen('D:\Doctorat\Program_Code_Source\Test-in.txt', 'w', 'l', 'UTF-8');
for i=1:(Nb_Ligne_Tokens-1)
fprintf(fid,'%s\r\n',Ligne_Tokens{1,i});
end
fprintf(fid,'%s',Ligne_Tokens{1,Nb_Ligne_Tokens});
fclose(fid);
end
end
%1 Remarque : indexer selon les lettres !!
%2 Remarque : classer selon most-used