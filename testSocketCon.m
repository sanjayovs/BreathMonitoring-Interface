clc;
clear all;
close all;

ClientConnection=tcpserver("192.168.137.124",9000);

while ~ClientConnection.Connected
    pause(0.1);
end


if ClientConnection.Connected
    ComsDataWrite(ClientConnection,"ServerHere!");
    pause(0.2);
    rcvdData=ComsDataRead(ClientConnection);
    if rcvdData=="acknowledging"
        disp('Test Successful');
    end
end


function stringData = ComsDataRead(CC)
    stringData=char(read(CC,CC.NumBytesAvailable));
end



function ComsDataWrite(ClientConnection,sendString)
    write(ClientConnection,sendString);
end