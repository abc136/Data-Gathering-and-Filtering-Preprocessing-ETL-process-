function [words]=Word_TfIDF_for_reference_my_DB_UTF8()
clc;clear all;close all;

    str1='D:\Doctorat\Program_Code_Source\My_DB_UTF8\3.My_DB_UTF8_tfidf-w-3gram\';
    str2=').txt';
    str22='.txt';
    str3='D:\Doctorat\Program_Code_Source\My_DB_UTF8\2.My_DB_UTF8_after_processing\';
    str12='w-';
    degree=3;
    
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
    
N=200;
for j1=1:10
    Text{1}=''; 
for ii1=1:2:20
%disp(['topic ',num2str(j1),'-- Num ',num2str(ii1)]);
File_Path=strcat(str3,topic{j1},num2str(ii1),str2);  
fid = fopen(File_Path, 'r', 'l', 'UTF-8');
Text{1}= strcat(Text{1}(1:end),fscanf(fid,'%c'));
fclose(fid);
end
%words{1,j1}=(strsplit(Text(1:end), {'\n',' ','\r','\r\n','  '}))';
[words{1,j1}]=feature_gram(Text,str12(1),degree);
end

%reduce size of words
for j1=1:10
        for k=1:250
          words3{1,j1}{k,1}=words{1,j1}{k,1};
        end
end
clear words;
words=words3;
% end reducing size of words

words1=words;
%Variants of TF weight
%tf=0;
for j1=1:10

  disp(['tf topic : ',num2str(j1)]); 
    k=1;
       while ~isempty(words{1,j1})
            a=[];  b=[];
            words2{1,j1}{k,1}=words{1,j1}{1,1};
            [a,b]=ismember(words{1,j1},words{1,j1}{1,1});
            
            %tf1 : binary                                   :    {0,1} 
               %tf(i,k)=a;
            %tf2 : raw frequency                       :    f{t,d} 
               tf{1,j1}{k,1}=(sum(a)/length(words1{1,j1}));
            %tf3 : log normalization                  :    1 + log(f{t,d}) 
               %tf(i,k)=1+log(sum(a)/length(words1{i,1}));
            %tf4 : double normalization "0.5"    :    0.5 + 0.5*f{t,d}/maxt
               %tf(i,k)=0.5+0.5*(sum(a)/maxt);     % where maxt is the maximum term raw frequency in d
            %tf5 : double normalization K         :    k + (1-k)*f{t,d}/maxt
              %tf(i,k)=k+(1-k)*(sum(a)/maxt);      % where maxt is the maximum term raw frequency in d
            
              k=k+1; 
            for j=1:length(b)
                if b(j)==1
                    words{1,j1}{j,1}='';
                end
            end
            words{1,j1}(all(cellfun(@isempty,words{1,j1}),2), : ) = [];
            
        end

end
clear words1;
clear words;
words=words2;
%clc

%Variants of IDF weight
%init du matrice IDF
for j1=1:10
    for jj=1:size(tf{1,j1},1)
    df{1,j1}{jj,1}=num2str(log(N));
    end
end
%end init
%begin process IDF
for j1=1:10

disp(['idf topic : ',num2str(j1)]);
    j=1;
    while ~isempty(words{1,j1})
        kvect=[];  bvect=[]; nt=1;
        %for k=(i+1):N
%          if ii1<=(20-1)
%              kk=1+1;
%          else
%              kk=1;
%          end
                     
                         for jj1=j1:10
%                             [a,b]=ismember(words{1,j1}{1,1},words{1,jj1});
%                             if a==1
%                                kvect=[kvect 1];
%                                bvect=[bvect b];
%                             end
                                [a,b]=ind2sub(size(words{1,jj1}),find(cellfun(@(x)strcmp(x,words{1,j1}{1,1}),words{1,jj1})));
                             %cette long instruction pour vérifier le
                             %nombre de fois combien words{ii1,j1}{1,1}
                             %existe dans le corpus
                                 if ~isempty(b)
                                    kvect=[kvect 1];
                                    bvect=[bvect a];  % a : represente l'index ou se trouve les mots
                                 end                           
                         end
                    
                     nt=length(kvect);
                     for ii=1:length(kvect)
                            %idf1 : unary 
                                %df(kvect(ii),j)=1;
                            %idf2 : inverse document frequency 
                                  df{kvect(ii),j1}{j,1}=num2str(log(N/nt)); 
                            %idf3 : inverse document frequency smooth 
                                %df(kvect(ii),j)=log(1+N/nt); 
                            %idf4 : inverse document frequency max  
                                %df(kvect(ii),j)=log(1+maxt/nt);    % where maxt is the maximum term raw frequency in d
                            %idf5 : probabilistic inverse document frequency 
                                %df(kvect(ii),j)=log((N-nt)/nt); 
                             
                             words{kvect(ii),j1}{bvect(ii),1}='';
                             words{kvect(ii),j1}(all(cellfun(@isempty,words{kvect(ii),j1}),2), : ) = [];
                      end
    j=j+1;                                                        
    end

end
words=words2;
clear words2;
%Recommended TF-IDF weighting schemes
for j1=1:10

%     tfidf_sum=0;
    for j=1:length(tf{1,j1})
     %document term weight
        
             %tf2*idf2                    
               % words{1,j1}{j,2}=tf(1,j)*df(1,j);
               words{1,j1}{j,2}='';
                words{1,j1}{j,2}=num2str((tf{1,j1}{j,1})*str2double(df{1,j1}{j,1}));
               % tfidf_sum=tfidf_sum+words{1,j1}{j,2};
             
             %tf3*idf1
             %tf3*idf2
        
      %query term weight
              %tf4*idf2
              %tf1*idf3
              %tf3*idf2
    end

%     for j=1:length(words{1,j1})
%         % words{1,j1}{j,3}=words{1,j1}{j,2}*100/tfidf_sum;
%         words{1,j1}{j,3}=0;
%     end
                    words{1,j1}=sortrows(words{1,j1},-2); %classement  
    %save all results

                    File_Path=strcat(str1,'all-frequency-of-',topic1{j1},str22); 
                    fid = fopen(File_Path, 'w', 'l', 'UTF-8');
                    for j=1:length(words{1,j1})
                    fprintf(fid,'%s   --  ',strtrim(words{1,j1}{j,1}));
                    fprintf(fid,'%s',strtrim(num2str(words{1,j1}{j,2})));
                    %fprintf(fid,'%s',num2str(words{1,j1}{j,3}));
                    fprintf(fid,'%s\n','');
                    end
                    fclose(fid);
    

end
end