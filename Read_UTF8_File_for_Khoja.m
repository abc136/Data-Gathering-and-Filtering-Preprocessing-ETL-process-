function [Text]=Read_UTF8_File_for_Khoja(File_Path)
if ~exist(File_Path,'file')
    error('Error. \n Input file does not exist.');
else
fid = fopen(File_Path, 'r', 'l', 'UTF-8');
Text= fscanf(fid,'%c');
fclose(fid);
end

%save all phrases into "Text-in.txt"
if ~exist('D:\Doctorat\Program_Code_Source\Test-in.txt','file')
    error('Error. \n Input file does not exist.');
else
fid = fopen('D:\Doctorat\Program_Code_Source\Test-in.txt', 'w', 'l', 'UTF-8');
fprintf(fid,'%s\r\n',Text);
fclose(fid);
end

end

%     fid=fopen(File_Path,'r','n','UTF-8');
%     Text=textscan(fid,'%c','Delimiter','\n'); % Text Structure : Text{1,1}{n,1}   // n :ligne number.
%     fclose(fid); 
%     Nb_letters=length(Text); 