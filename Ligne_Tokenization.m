function [Ligne_Tokens,Nb_Ligne_Tokens]=Ligne_Tokenization(Text)
Ligne_Tokens=strsplit(Text(1:end), {'\n\r','\n'});
% for i=2:length(Ligne_Tokens)
%    if length(Ligne_Tokens{1,i})==0;
%        for j=(i+1):length(Ligne_Tokens)
%           if Ligne_Tokens{1,j}~='';  
%               str=Ligne_Tokens{1,j};
%               Ligne_Tokens{1,j}='';
%               break;
%           end
%        end
%        Ligne_Tokens{1,i}=str;
%     end
% end

% for i=1:length(Ligne_Tokens)
%     if isempty(Ligne_Tokens(1,i))
%         Ligne_Tokens(1,i)=[];
%     end
% end
%Ligne_Tokens = Ligne_Tokens(~cellfun('isempty',Ligne_Tokens));
Nb_Ligne_Tokens=length(Ligne_Tokens);   % nombre de ligne
%remarque : n'oublier pas de supprimer le case vide !!
end