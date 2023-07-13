% Grabación de los datos de entrenamiento para la palabra "rojo"
disp('Habla la palabra "pequeño" y presiona Enter cuando termines.');
fs_peq = 16000; % Frecuencia de muestreo para la grabación
numero_datos=20;
datos_peq = cell(numero_datos, 1);

for i = 1:numero_datos
    fprintf('Grabando muestra %d de %d...\n', i,numero_datos);
    recObj = audiorecorder(fs_peq, 16, 1);
    recordblocking(recObj, 3); % Grabar durante 3 segundos
    
    datos_peq{i} = getaudiodata(recObj);
end

disp('Habla la palabra "grande" y presiona Enter cuando termines.');
fs_gran = 16000; % Frecuencia de muestreo para la grabación
datos_gran = cell(numero_datos, 1);

for i = 1:numero_datos
    fprintf('Grabando muestra %d de %d...\n', i,numero_datos);
    recObj = audiorecorder(fs_gran, 16, 1);
    recordblocking(recObj, 3); % Grabar durante 3 segundos
    
    datos_gran{i} = getaudiodata(recObj);
end






% Guardar los archivos de audio
for i = 1:numero_datos
    archivo_peq = sprintf('peque%d.wav', i);
    audiowrite(archivo_peq, datos_peq{i}, fs_peq);
    
    archivo_gran = sprintf('grande%d.wav', i);
    audiowrite(archivo_gran, datos_gran{i}, fs_gran);
    
end



