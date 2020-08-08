function [feature_result]=feature_gram(Text,word_lettre,degree)
%Note:Text must be a cell input
%cell_whitespace_input{1}=' ';
if word_lettre=='w'
    words=strsplit(Text{1}(1:end), {'\n',' ','\r','\r\n','  '}); 
    words = words(~cellfun('isempty',words));
    
    for i=1:(length(words)-degree+1)
        str_inter=words{1,i};
        if degree==1
            feature_result{i,1}=str_inter;
        elseif degree>=2
        for j=2:degree
            str_inter=[str_inter ' ' words{1,i+j-1}];
        end
        feature_result{i,1}=str_inter;
        end    
    end
    
elseif word_lettre=='l'
  %Text{1}=strrep(Text{1},{'\n','\r','\r\n'},' ');
  %this process to delete \n ...etc and make Text{1} very clean
    words=strsplit(Text{1}(1:end), {'\n',' ','\r','\r\n','  '}); 
    words = words(~cellfun('isempty',words));
    Text{1}='';
    for i=1:length(words)
        Text{1}=[Text{1} '-' words{1,i}];
    end
    %begin lettre Gram process
    for i=1:(length(Text{1})-degree+1)
        str_inter=Text{1}(i);
        if degree==1
            feature_result{i,1}=Text{1}(i);
        elseif degree>=2
        for j=2:degree
                str_inter=[str_inter Text{1}(i+j-1)];
        end
        feature_result{i,1}=str_inter;
        end
    end
end
feature_result = feature_result(~cellfun('isempty',feature_result));
end