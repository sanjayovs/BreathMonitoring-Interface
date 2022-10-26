function Preset3(masterData,samplingRate,filePathName)

fileName=filePathName(1:end-4);
        %% Time Series XYP
        titleStr='3D - XYP';
        rawFig=figure;
        
        plot3(masterData(1:end-100,3),masterData(1:end-100,4),masterData(1:end-100,2),'.');grid on; grid minor;
        
        label('all',titleStr,'','');
        xlabel('X');ylabel('Y');zlabel('Power');
        saveas(rawFig,strcat(fileName,'_3D_XYP'),'fig')
        saveas(rawFig,strcat(fileName,'_3D_XYP'),'bmp')
        
        
        
                %% Time Series MDP
        titleStr='3D - MDP';
        rawFig=figure;
        mag=sqrt(masterData(1:end-100,3).^2+masterData(1:end-100,4).^2);
        dir=atan2(masterData(1:end-100,4),masterData(1:end-100,3));
        plot3(mag,dir,masterData(1:end-100,2),'.');grid on; grid minor;
        
        label('all',titleStr,'','');
        xlabel('Magnitude');ylabel('Direction');zlabel('Power');
        saveas(rawFig,strcat(fileName,'_3D_MDP'),'fig')
        saveas(rawFig,strcat(fileName,'_3D_MDP'),'bmp')
        
  




end