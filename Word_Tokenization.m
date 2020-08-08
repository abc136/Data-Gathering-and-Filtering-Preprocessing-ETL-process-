function [Tokens,Nb_Tokens]=Word_Tokenization(Text)
Tokens=strsplit(Text(1:end), {' ', ',', ';', ':', '_', char([1548]), char([1563]), char([1600]), '-', '.'});  % 1548=Arabic_Fasila voir "The Unicode Standard 8.0"
Nb_Tokens=length(Tokens);    % nombre de mot
end