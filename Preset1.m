function Preset1(masterData,samplingRate,filePathName)
        fileName=filePathName(1:end-4);
        mvAvgWindow=1200;
        
        
        %% Time Series XYP
        titleStr='Time Series - XYP';
        rawFig=figure;
        subplot(311);plot(masterData(1:end-100,1)./samplingRate,masterData(1:end-100,3));grid on; grid minor;
        label('all',titleStr,'','X');
%         yl=ylim;
%         PatchBox(yl);
        subplot(312);plot(masterData(1:end-100,1)./samplingRate,masterData(1:end-100,4));grid on; grid minor;
        label('all','','','Y')
%         yl=ylim;
%         PatchBox(yl);
        subplot(313);plot(masterData(1:end-100,1)./samplingRate,masterData(1:end-100,2));grid on; grid minor;
        label('all','','Time (s)','Power')
%         yl=ylim;
%         PatchBox(yl);
        rawFig.Position=[0 0 1200 700];
        saveas(rawFig,strcat(fileName,'_TS_XYP'),'fig')
        saveas(rawFig,strcat(fileName,'_TS_XYP'),'bmp')
        
        
        %% Time Series MDP

        titleStr='Time Series - MDP';
        rawFig=figure;
        
        mag=sqrt(masterData(1:end-100,3).^2+masterData(1:end-100,4).^2);
        dir=atan2(masterData(1:end-100,4),masterData(1:end-100,3));
        subplot(311);plot(masterData(1:end-100,1)./samplingRate,mag);grid on; grid minor;
        label('all',titleStr,'','X');
%         yl=ylim;
%         PatchBox(yl);
        subplot(312);plot(masterData(1:end-100,1)./samplingRate,dir);grid on; grid minor;
        label('all','','','Y')
%         yl=ylim;
%         PatchBox(yl);
        subplot(313);plot(masterData(1:end-100,1)./samplingRate,masterData(1:end-100,2));grid on; grid minor;
        label('all','','Time (s)','Power')
%         yl=ylim;
%         PatchBox(yl);
        rawFig.Position=[0 0 1200 700];
        saveas(rawFig,strcat(fileName,'_TS_MDP'),'fig')
        saveas(rawFig,strcat(fileName,'_TS_MDP'),'bmp')
        


%         %% Moving Average 
        titleStr='Time Series - Moving Average';
        mvAvgTs=masterData(:,1);
        mvAvgX=movmean(masterData(:,3),mvAvgWindow);
        mvAvgY=movmean(masterData(:,4),mvAvgWindow);
        mvAvgPow=movmean(masterData(:,2),mvAvgWindow);
        mvAvgMag=movmean(sqrt(masterData(:,3).^2+masterData(:,4).^2),mvAvgWindow);
        mvAvgDir=movmean(atan2(masterData(:,3),masterData(:,4)),mvAvgWindow);
        movAvgFig=figure;subplot(511);plot(mvAvgTs./samplingRate,mvAvgX);grid on; grid minor;label('all',titleStr,'','X')
%         yl=ylim;
%         PatchBox(yl);
        subplot(512);plot(mvAvgTs./samplingRate,mvAvgY);grid on; grid minor;label('all','','','Y')
%         yl=ylim;
%         PatchBox(yl);
        subplot(513);plot(mvAvgTs./samplingRate,mvAvgPow);grid on; grid minor;label('all','','Time (s)','Pow')
%         yl=ylim;
%         PatchBox(yl);
        subplot(514);plot(mvAvgTs./samplingRate,mvAvgMag);grid on; grid minor;label('all','','Time (s)','Mag')
%         yl=ylim;
%         PatchBox(yl);
        subplot(515);plot(mvAvgTs./samplingRate,mvAvgDir);grid on; grid minor;label('all','','Time (s)','Dir')
%         yl=ylim;
%         PatchBox(yl);
        movAvgFig.Position=[0 0 1200 700];
        saveas(movAvgFig,strcat(fileName,'_MovAvgData'),'fig')
        saveas(movAvgFig,strcat(fileName,'_MovAvgData'),'bmp')
end