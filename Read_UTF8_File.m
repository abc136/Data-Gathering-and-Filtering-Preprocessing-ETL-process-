function [Text,Nb_letters]=Read_UTF8_File(File_Path)
if ~exist(File_Path,'file')
    error('Error. \n Input file does not exist.');
else
fid = fopen(File_Path, 'r', 'l', 'UTF-8');
Text= fscanf(fid,'%c');
fclose(fid);
Nb_letters=length(Text);
end
end

%     fid=fopen(File_Path,'r','n','UTF-8');
%     Text=textscan(fid,'%c','Delimiter','\n'); % Text Structure : Text{1,1}{n,1}   // n :ligne number.
%     fclose(fid); 
%     Nb_letters=length(Text); 