Ts = datetime();
Ts.Format = 'uuuu/MM/dd HH:mm:ss.SSS';
file_name = "0.101401354";
timeStr = string(Ts);
timeSTR = strrep(timeSTR, "/ .:", "_");
file_name = strcat(file_name, "___", timeSTR);
file_name = strcat(dataFolder, "/", file_name, ".mat");