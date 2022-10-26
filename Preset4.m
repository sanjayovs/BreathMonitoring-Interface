function Preset4()

[fileList,path]=uigetfile({'*.csv';'*.xls';},'Select the INPUT DATA FILE(s)','MultiSelect','on');
titleStr1='';
titleStr2='';
clrs={'r','b','g','y','m','c'};
rawFig1=figure;
rawFig2=figure;
legendList={};

for i=1:length(fileList)
    currentFile=strcat(path, fileList{i});
    masterData=readmatrix(currentFile);
    figure(rawFig1);
    plot3(masterData(1:end-100,3),masterData(1:end-100,4),masterData(1:end-100,2),strcat('.',clrs{i}));grid on; grid minor;hold on;

    mag=sqrt(masterData(1:end-100,3).^2+masterData(1:end-100,4).^2);
    dir=atan2(masterData(1:end-100,4),masterData(1:end-100,3));
    figure(rawFig2);
    plot3(mag,dir,masterData(1:end-100,2),strcat('.',clrs{i}));grid on; grid minor;hold on;
    
    currentLegend=strrep(fileList{i}(1:end-4),'_',',');
    legendList{end+1}=currentLegend;
    
    
end

figure(rawFig1);
label('all',titleStr1,'','');
xlabel('X');ylabel('Y');zlabel('Power');
legend(legendList);

figure(rawFig2);
label('all',titleStr1,'','');
xlabel('Magnitude');ylabel('Direction');zlabel('Power');
legend(legendList);
[fileName, path]=uiputfile('Enter File Name')
saveas(rawFig1,strcat(path,fileName(1:end-7),'_XYP'),'fig')
saveas(rawFig1,strcat(path,fileName(1:end-7),'_XYP'),'bmp')


saveas(rawFig1,strcat(path,fileName(1:end-7),'_MDP'),'fig')
saveas(rawFig1,strcat(path,fileName(1:end-7),'_MDP'),'bmp')

end