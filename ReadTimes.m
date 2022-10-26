function [T1,T2,T3,T4]=ReadTimes()
        FID_File=fopen(strcat(pwd,'\IPConfigFile.txt'));
        FID_Text=textscan(FID_File,'%s');
        T1=str2num(string(FID_Text{1}{3}))
        T2=str2num(string(FID_Text{1}{4}))
        T3=str2num(string(FID_Text{1}{5}))
        T4=str2num(string(FID_Text{1}{6}))
        fclose(FID_File);
        

end