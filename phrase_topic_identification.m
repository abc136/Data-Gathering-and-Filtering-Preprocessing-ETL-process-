function [topic_is]=phrase_topic_identification(filename,topic1,words,NO_ref)
%clear all;clc;close all
% load test doc
[Text]=Read_UTF8_File(filename);
words_test=strsplit(Text(1:end), {'\n','% ','     '}); 
for i=2:3:(length(words_test)-2)
    words_test{1,i}='';
end
words_test=words_test';
words_test(all(cellfun(@isempty,words_test),2), : ) = [];
for i=2:2:length(words_test)
    words_test{i-1,2}=num2str(words_test{i,1});
    words_test{i,1}='';
end
words_test(all(cellfun(@isempty,words_test),2), : ) = [];
%End load
%Begin Topic identification
%     if NO_test==1000
%         NO_test=length(words_test);
%     end
%     if length(words_test)<NO_test
%         NO_test=length(words_test);
%     end
    for i=1:size(words_test,1)
        for j=1:length(topic1)
         topic_count_index2(i,j)=0;
         topic_count_index3(i,j)=0;
        end
    end
topic_is{1}='nothing';
topic_is{2}='nothing';
%topic_is{3}='nothing';
for i=1:size(words_test,1) %(length(words_test))
%init
%               resultat{i,1}='';
%               resultat{i,2}=0; 
%               resultat{i,3}=''; 
%end init
 for k=1:length(topic1)   %parcourir tous les topic
        for j=1:NO_ref %length(words{1,k})  %NO_ref %  %length(words{1,k})
                    if  strcmp(words_test{i,1},words{1,k}{j,1})==true
                         %topic_count_index2(i,k)=str2num(words{1,k}{j,2}); %2eme methode
                         topic_count_index2(i,k)=str2num(words_test{i,2}); %2eme methode
                         topic_count_index3(i,k)=1;  %3eme methode
%                           if (resultat{i,2}>j+4)  || (resultat{i,2}==0)     %ça veut dire que le mot i n'a pas grand d'importance à celui de topic précédent!!
%                             %  topic_count_index1(i,k)=str2num(words_test{i,2}); %1eme methode
%                           resultat{i,1}=topic1{k};
%                           resultat{i,2}=j; %prend le Rank
%                           resultat{i,3}=words{1,k}{j,2}; %prend le%
%                         %  resultat{i,4}=words{1,k}{j,2}; %prend le % pour donner évaluation automatique
%                           elseif resultat{i,2}==j+8
%                               if  str2double(resultat{i,3})<str2double(words{1,k}{j,2})
%                                   resultat{i,1}=topic1{k};
%                                   resultat{i,3}=words{1,k}{j,2}; %prend le%
%                                %   resultat{i,4}=words{1,k}{j,2}; %prend le % pour donner évaluation automatique
%                               end
%                           end
                           break;
                    end
        end
 end             
end
%end Topic identification

% for i=1:10
%     topic_count(i)=0;
% end
% for i=1:NO_test  %pour donner évaluation automatique
%      for j=1:10
%          if strcmp(resultat{i,1},topic1{j})==true
%              topic_count(j)=topic_count(j)+((NO_test+1)-i);
%              break;
%          end
%      end
% end                           
% [M,I] = max(topic_count);
% topic_is{1}=topic1{I};                          
%End Topic decision

% 1eme methode c'est ma méthode
% for j=1:10
%     topic_count_index_sum1(j)=0;
%     for i=1:NO_test
%         topic_count_index_sum1(j)=topic_count_index_sum1(j)+topic_count_index1(i,j);
%     end
% end
% [M,I] = max(topic_count_index_sum1);
% topic_is{1}=topic1{I};
% end 1eme methode

%2eme methode
for j=1:length(topic1)
    topic_count_index_sum2(j)=0;
    for i=1:size(words_test,1)
        topic_count_index_sum2(j)=topic_count_index_sum2(j)+topic_count_index2(i,j);
    end
end
[M,I] = max(topic_count_index_sum2);
topic_is{1}=topic1{I};
%end 2eme methode

%3eme methode
for j=1:length(topic1)
    topic_count_index_sum3(j)=0;
    for i=1:size(words_test,1)
        topic_count_index_sum3(j)=topic_count_index_sum3(j)+topic_count_index3(i,j);
    end
end
[M,I] = max(topic_count_index_sum3);
topic_is{2}=topic1{I};
%end 3eme methode