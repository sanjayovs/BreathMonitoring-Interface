        function AnalyzeData(app)
            recData=extractBetween(char(app.recordedData),"NebMode","Sent DataFile");
            recDataCell=strsplit(recData{1},'\n');
            for i=2:length(recDataCell)-1
                app.expData(i-1,:)=str2double(strsplit(recDataCell{i},','));
            end
            writematrix(app.expData,app.filePathAndName);
            writematrix(app.logfileData,strcat(app.filePathAndName(1:end-4),'.log'));
            
        end


function ProcessDisplayData(app)
            CreateTimeSeriesPlot(app,1);
        end
        
        function CreateTimeSeriesPlot(app,plttype)
            xData=app.masterData(:,3);
            yData=app.masterData(:,4);
            powData=app.masterData(:,2);
            sampData=app.masterData(:,1)./app.actSampRate;
            if plttype==1
                plot(app.XTimeSeriesPlot,sampData,xData);
                ylabel(app.XTimeSeriesPlot,'X');
                plot(app.YTimeSeriesPlot,sampData,yData);
                ylabel(app.YTimeSeriesPlot,'Y');
                plot(app.PowerTimeSeriesPlot,sampData,powData);
            elseif plttype==2
                magData=sqrt(xData.^2+yData.^2);
                dirData=atan2(yData,xData);
                plot(app.XTimeSeriesPlot,sampData,magData);
                ylabel(app.XTimeSeriesPlot,'Mag.');
                plot(app.YTimeSeriesPlot,sampData,dirData);
                ylabel(app.YTimeSeriesPlot,'Dir.');
                plot(app.PowerTimeSeriesPlot,sampData,powData);
                
                
            end
            
        end



            function FileNamePathButtonPushed(app, event)
            filter = {'*.csv';'*.xls';};
            [file, path] = uiputfile(filter);
            app.filePathAndName=strcat(path,file);
            app.FileNameField.Value=app.filePathAndName;
            app.loadFilePathAndName=app.FileNameField.Value;
            
            end

   function LoadDataFilesButtonPushed(app, event)
            filter = {'*.csv';'*.xls';};
            [file, path] = uigetfile(filter);
            app.loadFilePathAndName=strcat(path,file);
            ReadExcelFunction(app)

            
            
        end


            function ProcessButtonPushed(app, event)
            if app.GraphPresetsButtonGroup.SelectedObject==app.Preset1Button
                    Preset1(app.masterData,app.actSampRate,app.loadFilePathAndName);
            elseif    app.GraphPresetsButtonGroup.SelectedObject==app.Preset2Button
                        Preset2(app.masterData,app.actSampRate,app.loadFilePathAndName);
            elseif    app.GraphPresetsButtonGroup.SelectedObject==app.Preset3Button
                        Preset3(app.masterData,app.actSampRate,app.loadFilePathAndName);
            elseif    app.GraphPresetsButtonGroup.SelectedObject==app.Preset4Button
                        Preset4()
            end
            
            
          
            end






                   function ReadExcelFunction(app)
            %% Can be moved to read excel function
            app.masterData=readmatrix(app.loadFilePathAndName);
            fileID=fopen(strcat(app.loadFilePathAndName(1:end-4),'.txt'),'r');
            formatSpec='%c';
            app.configData=fscanf(fileID,formatSpec);
            dummy1=extractBetween(app.configData,'Actual Scan Rate: ','Record Duration:');
            actScnRate=strsplit(dummy1{1},'\r');
            app.actSampRate=str2double(actScnRate);
            
            ProcessDisplayData(app);
            app.ProcessButton.Enable='on';
            app.GraphPresetsButtonGroup.Enable='on';
            app.GraphSelectionGroup.Enable='on';
            app.Preset1Button.Enable='on';
            app.Preset2Button.Enable='on';
            app.Preset3Button.Enable='on';
            
        end

