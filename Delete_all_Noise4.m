function [Nb_Noise_Letters,Ligne_Tokens]=Delete_all_Noise4(Ligne_Tokens,Nb_Ligne_Tokens)
%tic
% charger tab_lettre par les lettres arabe de base; voir "The Unicode
% Standard 8.0".
%tab_lettre = [char([1569:1594]),char([1601:1610]),char(1617)]; ancient tab_lettre
%chargement suivant most used arabic letter in quran
tab_lettre = [' ',char(1575),char(1604),char(1606),char(1605),char(1608),char(1610),char(1607),char(1585),char(1576),char(1578),char(1603),char(1593),char(1571),char(1601),char(1602),char(1587),char(1583),char(1574),char(1584),char(1581),char(1580),char(1609),char(1582),char(1577),char(1588),char(1589),char(1590),char(1569),char(1586),char(1570),char(1579),char(1591),char(1594),char(1574),char(1592),char(1572),char(1617)];
%Suppression de {ponctuations,chiffres_de_tous_les_langues(romain,arabe,....),lettre_de_tous_les_langues(sauf de la lang arab),
%diacritiques,carateres_specaiux,...etc.}
Nb_Noise_Letters=0;
for k=1:Nb_Ligne_Tokens                 %passage phrase par phrase
        len_phrase_old=length(Ligne_Tokens{1,k});  %pour calculer ultérieurement combient de lettre a été supprimer
        for i=1:length(Ligne_Tokens{1,k})              %passage lettre par lettre de ma phrase
            if ismember(Ligne_Tokens{1,k}(i),tab_lettre)==0  % si n'appartient pas dans notre tab_lettre de la langue arabe.
                Ligne_Tokens{1,k}(i)=' ';
            end
        end
        Ligne_Tokens{1,k}=regexprep(strtrim(Ligne_Tokens{1,k}), '\s+', ' ');  %delete all extra white sapces like this : 'aaa  aa a     aa    aa'
       Nb_Noise_Letters=Nb_Noise_Letters+((len_phrase_old)-length(Ligne_Tokens{1,k}));  %pour calculer le nombre de lettres insignificatifs.
end
%msgbox(num2str(toc));
end