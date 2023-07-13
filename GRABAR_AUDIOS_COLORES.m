num_datos = 20; % Número de datos a grabar

disp('Habla la palabra "rojo" y presiona Enter cuando termines.');
fs_rojo = 16000; % Frecuencia de muestreo para la grabación
datos_rojo = cell(num_datos, 1);

for i = 1:num_datos
    fprintf('Grabando muestra %d de %d...\n', i, num_datos);
    recObj = audiorecorder(fs_rojo, 16, 1);
    recordblocking(recObj, 3); % Grabar durante 3 segundos
    
    datos_rojo{i} = getaudiodata(recObj);
end

% Grabación de los datos de entrenamiento para la palabra "azul"
disp('Habla la palabra "azul" y presiona Enter cuando termines.');
fs_azul = 16000; % Frecuencia de muestreo para la grabación
datos_azul = cell(num_datos, 1);

for i = 1:num_datos
    fprintf('Grabando muestra %d de %d...\n', i, num_datos);
    recObj = audiorecorder(fs_azul, 16, 1);
    recordblocking(recObj, 3); % Grabar durante 3 segundos
    datos_azul{i} = getaudiodata(recObj);
end

% Grabación de los datos de entrenamiento para la palabra "verde"
disp('Habla la palabra "verde" y presiona Enter cuando termines.');
fs_verde = 16000; % Frecuencia de muestreo para la grabación
datos_verde = cell(num_datos, 1);

for i = 1:num_datos
    fprintf('Grabando muestra %d de %d...\n', i, num_datos);
    recObj = audiorecorder(fs_verde, 16, 1);
    recordblocking(recObj, 3); % Grabar durante 3 segundos
    datos_verde{i} = getaudiodata(recObj);
end

% Guardar los archivos de audio
for i = 1:num_datos
    archivo_rojo = sprintf('rojo%d.wav', i);
    audiowrite(archivo_rojo, datos_rojo{i}, fs_rojo);
    
    archivo_azul = sprintf('azul%d.wav', i);
    audiowrite(archivo_azul, datos_azul{i}, fs_azul);
    
    archivo_verde = sprintf('verde%d.wav', i);
    audiowrite(archivo_verde, datos_verde{i}, fs_verde);
end
