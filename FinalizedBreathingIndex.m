
function [Resp_Rate, LungCapacity, Quality, FinalQI, mvAvgPow1,mvmax1,imvmax1,mvmin1,imvmin1]=FinalizedBreathingIndex(fileName,mvAvgWindow,t_end)

masterData=readmatrix(fileName);
% masterData=masterData(1:t_end*1000,:);
% masterData=masterData(1:end,:);
TimeDuration=str2num(t_end)


%%
mvAvgX=movmean(masterData(:,3),mvAvgWindow);
mvAvgY=movmean(masterData(:,2),mvAvgWindow);
mvAvgPow=movmean(masterData(:,4),mvAvgWindow);
mvAvgPow1=mvAvgPow;
mvAvgMag=movmean(sqrt(masterData(:,3).^2+masterData(:,2).^2),mvAvgWindow);
mvAvgDir=movmean(atan2(masterData(:,2),masterData(:,3)),mvAvgWindow);

%% Local Max and Min
% figure;

x= mvAvgPow;
tmpmax = movmax(x,2500);
imvmax = find(x==tmpmax);
imvmax1=imvmax;
mvmax = x(imvmax);
mvmax1=mvmax;
% plot((1:length(x))/1000,x,'-k',imvmax/1000,mvmax,'or');hold on

tmpmin = movmin(x,2500);
imvmin = find(x==tmpmin);
imvmin1=imvmin;
mvmin = x(imvmin);
mvmin1=mvmin;
% plot((1:length(x))/1000,x,'-k',imvmin/1000,mvmin,'ob');hold on; label('all','','','Pow'); grid on; grid minor

length(imvmin)

    i=1; 
    length(imvmax)
    while (i<=length(imvmax) )

        if imvmax(1) > imvmin(1)
                if i<length(imvmin)            
                    if  imvmax(i)>imvmin(i+1)
                        imvmin(i)=[];
                        i=1;
                        continue
                    end
                end
                    if imvmax(i)< imvmin(i)
                        imvmax(i)=[];
                        i=1;
                        continue
                    end                    
                    if i==length(imvmax)
                    break
                    end
        i=i+1;

        end
         if imvmin(1) > imvmax(1)
                    if imvmax(i)>imvmin(i) 
                       imvmin(i)=[];
                       i=1;
                       continue
                    end
                if i<length(imvmax)
                    if imvmax(i+1)< imvmin(i) 
                       %imvmax(i+1)=[];
                       imvmax(i)=[];
                       i=1;
                       continue
                    end                    
                end
                    if i==length(imvmin)
                       break
                    end
        i=i+1;

        end 
    end
  
if length(imvmax)>=length(imvmin)      
    if imvmin(1) > imvmax(1)
    
            for i=1:length(imvmin)-1
                Inhalationn(i)=imvmax(i+1)-imvmin(i);
                InhalationVol(i)=trapz(mvAvgPow(imvmin(i):imvmax(i+1)));
                Exhalationn(i)=imvmin(i)-imvmax(i); 
                ExhalationVol(i)=trapz(mvAvgPow(imvmax(i):imvmin(i)));
            end
    end


    if imvmin(1) < imvmax(1)
                i=1:length(imvmax)-1;
                Inhalationn(i)=imvmax(i)-imvmin(i);
                InhalationVol(i)=trapz(mvAvgPow(imvmin(i):imvmax(i)));
                Exhalationn(i)=imvmin(i+1)-imvmax(i); 
                ExhalationVol(i)=trapz(mvAvgPow(imvmax(i):imvmin(i+1)));
    end



else
      if imvmin(1) > imvmax(1)
    
            for i=1:length(imvmin)-1
                Inhalationn(i)=imvmax(i)-imvmin(i+1);
                InhalationVol(i)=trapz(mvAvgPow(imvmin(i+1):imvmax(i)));
                Exhalationn(i)=imvmin(i)-imvmax(i); 
                ExhalationVol(i)=trapz(mvAvgPow(imvmax(i):imvmin(i)));
            end
    end


    if imvmin(1) < imvmax(1)
                i=1:length(imvmax)-1;
                Inhalationn(i)=imvmax(i)-imvmin(i+1);
                InhalationVol(i)=trapz(mvAvgPow(imvmin(i):imvmax(i)));
                Exhalationn(i)=imvmin(i+1)-imvmax(i); 
                ExhalationVol(i)=trapz(mvAvgPow(imvmax(i):imvmin(i+1)));
    end


end
    


Inhalation.Duration=sum(Inhalationn); 
Exhalation.Duration=sum(Exhalationn); 

Inhalation.Volume=sum(InhalationVol);
Exhalation.Volume=sum(ExhalationVol);

Resp_Rate=0.5*(length(imvmax)+length(imvmin))*60/TimeDuration;

Vel_x=diff(mvAvgX);
Vel_y=diff(mvAvgY);
MagnitudeParameters.Vel=sqrt(Vel_x.^2+Vel_y.^2);

accel_x=diff(diff(mvAvgX));
accel_y=diff(diff(mvAvgY));
MagnitudeParameters.accel=sqrt(accel_x.^2+accel_y.^2);


dif_of_accel_x=diff(diff(diff(mvAvgX)));
dif_of_accel_y=diff(diff(diff(mvAvgY)));
MagnitudeParameters.dif_of_accel=sqrt(dif_of_accel_x.^2+dif_of_accel_y.^2);

%%%%%
% figure;
% h1=histogram(mvAvgPow, 'Normalization', 'Probability');
% p=h1.Values;
% entropy = -sum(p.*log2(p));
%%%%%
exvol0.real=ExhalationVol(1); 
exvol0.Normalized=ExhalationVol(1)/sum(ExhalationVol);  % FEV1

LungCapacity=((Exhalation.Volume)./length(ExhalationVol))*5*10^-4;
if LungCapacity>=6
    LungCapacity_Qual=1;
else
    LungCapacity_Qual=LungCapacity/6;
end


if Resp_Rate>=12 && Resp_Rate<=20
    Quality = 1;
else
    if Resp_Rate>20
        Quality = 1- (Resp_Rate-20)./20;
    else
        Quality = 1-(12-Resp_Rate)./12;
    end
end
QualityThreshold1 = 0.7;
QualityThreshold2 = 0.5;
if LungCapacity_Qual<0.6
    if Quality <QualityThreshold1 && Quality>QualityThreshold2
        FinalQI=2;
    elseif Quality <=QualityThreshold2
        FinalQI=3;
    else
        FinalQI=1;
    end
else
    FinalQI=1;
end
end

