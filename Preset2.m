function Preset2(masterData,samplingRate,filePathName)
    fileName=filePathName(1:end-4);
    overlapPer=75;
    mvAvgWindow=1200;
    
    samplingRate=samplingRate(1);
    whos samplingRate
    %%

    mvAvgMag=movmean(sqrt(masterData(:,3).^2+masterData(:,4).^2),mvAvgWindow);
    
    mastMag=sqrt(masterData(:,3).^2+masterData(:,4).^2);
    specFigure=figure;

    % Spectrogram on Normal data
    titleStr='Spectrogram - Regular Data';
    spectrogram(mastMag(1:end-1),samplingRate,fix(samplingRate*overlapPer/100),samplingRate,samplingRate,'yaxis');
    hfig=gcf;
    hfig.Colormap = jet(256);
    caxis([-100 0]);
    title(titleStr);
    
    % Spectrogram of Moving Average
    titleStr='Spectrogram - Moving Average';
    specFigure2=figure;
    spectrogram(mvAvgMag(1:end-(mvAvgWindow/2)-1),samplingRate,fix(samplingRate*overlapPer/100),samplingRate,samplingRate,'yaxis');
    hfig.Colormap = jet(256);
    caxis([-100 0]);
    title(titleStr);
    saveas(specFigure,strcat(fileName,'_Spectro1'),'fig');
    saveas(specFigure,strcat(fileName,'_Spectro1'),'bmp');
    saveas(specFigure2,strcat(fileName,'_Spectro2'),'fig');
    saveas(specFigure2,strcat(fileName,'_Spectro2'),'bmp');

%     close([rawFig movAvgFig specFigure specFigure2])

    % Power Spectrum Analysis - pwelch
    titleStr='Power Spectral Analysis';
    specFigure3=figure;
    pwelch(mastMag,[],[],[],samplingRate)
    title(titleStr);
    saveas(specFigure2,strcat(fileName,'_Pwelch1'),'fig');
    saveas(specFigure2,strcat(fileName,'_Pwelch'),'bmp');


end