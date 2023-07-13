% Cargar la imagen
%
close all
clear all

disp('Iniciando reconocimiento de voz.');

%%nombresPalabras = {'rojo_grande', 'rojo_pequeno', 'azul_grande', 'azul_pequeno', 'verde_grande', 'verde_pequeno'};

fs_grabado=16000;
load('modelo_colores.mat', 'svm_modelo');

% Paso 2: Grabar una palabra
disp('POR FAVOR , INDIQUE EL COLOR:');

    
recorder = audiorecorder(fs_grabado, 16, 1);
recordblocking(recorder, 3); % Grabar durante 3 segundos
audio_grabado = getaudiodata(recorder);

% Paso 3: Preprocesar la palabra grabada
audio_grabado = resample(audio_grabado, fs_grabado, recorder.SampleRate); % Re-muestreo a la frecuencia de muestreo utilizada durante el entrenamiento
caracteristicas_grabadas = mfcc(audio_grabado, fs_grabado);

% Paso 4: Clasificar la palabra grabada usando el modelo
etiquetas_predichas = predict(svm_modelo, caracteristicas_grabadas);

% Paso 5: Determinar la palabra clasificada
[etiqueta, ~] = mode(etiquetas_predichas); % Obtener la etiqueta más común de las predicciones
palabras = {'rojo', 'verde', 'azul'};
if etiqueta >= 1 && etiqueta <= numel(palabras)
    palabra_clasificada = palabras{etiqueta};
else
    palabra_clasificada = 'desconocido';
end

% Paso 6: Mostrar la palabra clasificada
disp(['COLOR : ' palabra_clasificada]);




fs_grabado=16000;
load('modelo_tam.mat', 'svm_modelo');

% Paso 2: Grabar una palabra
disp('POR FAVOR INDIQUE EL TAMAÑO:');

    
recorder = audiorecorder(fs_grabado, 16, 1);
recordblocking(recorder, 3); % Grabar durante 3 segundos
audio_grabado = getaudiodata(recorder);

% Paso 3: Preprocesar la palabra grabada
audio_grabado = resample(audio_grabado, fs_grabado, recorder.SampleRate); % Re-muestreo a la frecuencia de muestreo utilizada durante el entrenamiento
caracteristicas_grabadas = mfcc(audio_grabado, fs_grabado);

% Paso 4: Clasificar la palabra grabada usando el modelo
etiquetas_predichas = predict(svm_modelo, caracteristicas_grabadas);

% Paso 5: Determinar la palabra clasificada
[etiquetat, ~] = mode(etiquetas_predichas); % Obtener la etiqueta más común de las predicciones
palabras = {'pequeño', 'grande'};
if etiquetat >= 1 && etiquetat <= numel(palabras)
    palabra_clasificada = palabras{etiquetat};
else
    palabra_clasificada = 'desconocido';
end

% Paso 6: Mostrar la palabra clasificada
disp(['TAMAÑO: ' palabra_clasificada]);




        if etiqueta==1 && etiquetat==2
            indicePalabra=1 %ROJO GRANDE
            
        elseif etiqueta==1 && etiquetat==1
            indicePalabra=2 %ROJO PEQUEÑO
            
        elseif etiqueta==2 && etiquetat==2
            indicePalabra=5 %VERDE GRANDE
            
        elseif etiqueta==2 && etiquetat==1
            indicePalabra=6 %VERDE PEQUEÑO
            
        elseif etiqueta==3 && etiquetat==2
            indicePalabra=3 %AZUL GRNADE
            
        elseif etiqueta==3 && etiquetat==1
            indicePalabra=4 %AZUL PEQUEÑO
        
            
        else 
        end
        



videoObj = videoinput('winvideo',2);
imgin = getsnapshot(videoObj);
x = 180; % Coordenada x del punto superior izquierdo
y = 220; % Coordenada y del punto superior izquierdo
width = 300; % Ancho del área
height = 120; % Alto del área

img = imgin(y:y+height-1, x:x+width-1, :);
divisionWidth = round(width / 3)-1;
x=0;
y=0;
parte1imagen = [];
parte2imagen = [];
parte3imagen = [];
for i=1:3
    % Recortar cada parte dividida
    parte = img(:, (i-1)*divisionWidth+1:i*divisionWidth, :);
    
    % Guardar la parte dividida en la variable correspondiente
    if i == 1
        parte1imagen = parte;
    elseif i == 2
        parte2imagen = parte;
    elseif i == 3
        parte3imagen = parte;
    end
end


% Separar los canales y obtener el área y centroide de cada componente
[img_azul1, img_rojo1, img_verde1, area_azul1, area_rojo1, area_verde1] = separar_canales(parte1imagen);


figure;
    subplot(2, 3, 1);
    imshow(img);
    title('Imagen original');
    % Inicializar las variables para almacenar las partes divididas

% Mostrar las imágenes resultantes

subplot(2, 3, 2);
imshow(img);
title('Imagen original');

% Dibujar rectángulos en cada división y guardar las partes divididas
hold on
for i = 1:3
    rect = [(x+1) + (i-1)*divisionWidth, y+1, divisionWidth, height-1];
    rectangle('Position', rect, 'LineWidth', 1, 'EdgeColor', 'g');
    

end

hold off;

subplot(2, 3, 3);
imshow(img_azul1);

title(['Azul (Área: ' num2str(area_azul1)]);
subplot(2, 3, 4);
imshow(img_rojo1);
title(['Rojo (Área: ' num2str(area_rojo1) ]);
subplot(2, 3, 5);
imshow(img_verde1);
title(['Verde (Área: ' num2str(area_verde1) ]);

% Separar los canales y obtener el área y centroide de cada componente
[img_azul2, img_rojo2, img_verde2, area_azul2, area_rojo2, area_verde2] = separar_canales(parte2imagen);

figure;
    subplot(2, 3, 1);
    imshow(img);
    title('Imagen original');
    % Inicializar las variables para almacenar las partes divididas

% Mostrar las imágenes resultantes

subplot(2, 3, 2);
imshow(img);
title('Imagen original');

% Dibujar rectángulos en cada división y guardar las partes divididas
hold on
for i = 1:3
    rect = [(x+1) + (i-1)*divisionWidth, y+1, divisionWidth, height-1];
    rectangle('Position', rect, 'LineWidth', 1, 'EdgeColor', 'y');
    

end

hold off;

subplot(2, 3, 3);
imshow(img_azul2);

title(['Azul (Área: ' num2str(area_azul2)]);
subplot(2, 3, 4);
imshow(img_rojo2);
title(['Rojo (Área: ' num2str(area_rojo2) ]);
subplot(2, 3, 5);
imshow(img_verde2);
title(['Verde (Área: ' num2str(area_verde2) ]);


% Separar los canales y obtener el área y centroide de cada componente
[img_azul3, img_rojo3, img_verde3, area_azul3, area_rojo3, area_verde3] = separar_canales(parte3imagen);


figure;
    subplot(2, 3, 1);
    imshow(img);
    title('Imagen original');
    % Inicializar las variables para almacenar las partes divididas
      
% Mostrar las imágenes resultantes

subplot(2, 3, 2);
imshow(img);
title('Imagen original');

% Dibujar rectángulos en cada división y guardar las partes divididas
hold on
for i = 1:3
    rect = [(x+1) + (i-1)*divisionWidth, y+1, divisionWidth, height-1];
    rectangle('Position', rect, 'LineWidth', 1, 'EdgeColor', 'r');
    

end

hold off;

subplot(2, 3, 3);
imshow(img_azul3);

title(['Azul (Área: ' num2str(area_azul3)]);
subplot(2, 3, 4);
imshow(img_rojo3);
title(['Rojo (Área: ' num2str(area_rojo3) ]);
subplot(2, 3, 5);
imshow(img_verde3);
title(['Verde (Área: ' num2str(area_verde3) ]);

% Código para area_azul1
if area_azul1 >= 100 && area_azul1 <= 600
    p1_tam = 1;
    color1 = 1;
elseif area_azul1 >= 900 && area_azul1 <= 1800
    p1_tam = 2;
    color1 = 1;

% Código para area_rojo1
elseif area_rojo1 >= 150 && area_rojo1 <= 600
    p1_tam = 1;
    color1 = 2;
elseif area_rojo1 >= 900 && area_rojo1 <= 1800
    p1_tam = 2;
    color1 = 2;

% Código para area_verde1
elseif area_verde1 >= 200 && area_verde1 <= 600
    p1_tam = 1;
    color1 = 3;
elseif area_verde1 >= 900 && area_verde1 <= 1800
    p1_tam = 2;
    color1 = 3;
else
    p1_tam = 0;
    color1 = 0;
end

% Código para area_azul2
if area_azul2 >= 100 && area_azul2 <= 600
    p2_tam = 1;
    color2 = 1;
elseif area_azul2 >= 900 && area_azul2 <= 1800
    p2_tam = 2;
    color2 = 1;


% Código para area_rojo2
elseif area_rojo2 >= 150 && area_rojo2 <= 600
    p2_tam = 1;
    color2 = 2;
elseif area_rojo2 >= 900 && area_rojo2 <= 1800
    p2_tam = 2;
    color2 = 2;


% Código para area_verde2
elseif area_verde2 >= 200 && area_verde2 <= 600
    p2_tam = 1;
    color2 = 3;
elseif area_verde2 >= 900 && area_verde2 <= 1800
    p2_tam = 2;
    color2 = 3;
else
    p2_tam = 0;
    color2 = 0;
end

% Código para area_azul3
if area_azul3 >= 100 && area_azul3 <=600
    p3_tam = 1;
    color3 = 1;
elseif area_azul3 >= 900 && area_azul3 <= 1800
    p3_tam = 2;
    color3 = 1;

 % Código para area_rojo3
elseif area_rojo3 >= 150 && area_rojo3 <= 600
    p3_tam = 1;
    color3 = 2;
elseif area_rojo3 >= 900 && area_rojo3 <= 1800
    p3_tam = 2;
    color3 = 2;


% Código para area_verde3
elseif area_verde3 >= 200 && area_verde3 <= 600
    p3_tam = 1;
    color3 = 3;
elseif area_verde3 >= 700 && area_verde3 <= 1250
    p3_tam = 2;
    color3 = 3;
else
    p3_tam = 0;
    color3 = 0;
end

texto=''
nombresPalabras = {'rojo_grande', 'rojo_pequeno', 'azul_grande', 'azul_pequeno', 'verde_grande', 'verde_pequeno'};

if indicePalabra == 1
    
    if color1==2 && p1_tam==2
        texto='@3'
    
    elseif color2==2 && p2_tam==2
            texto='@2'
    elseif color3==2 && p3_tam==2
            texto='@1'
    
    else
        disp('NO HAY UN CUBO ROJO GRANDE');
    end 
    
elseif indicePalabra == 2
    
     if color1==2 && p1_tam==1
        texto='@3'
    
    elseif color2==2 && p2_tam==1
            texto='@2'
    elseif color3==2 && p3_tam==1
            texto='@1'
    
    
    else
        disp('NO HAY UN CUBO ROJO PEQUEÑO');
    end 
   
elseif indicePalabra == 3 

    if color1==1 && p1_tam==2
        texto='@3'
    
    elseif color2==1 && p2_tam==2
            texto='@2'
    elseif color3==1 && p3_tam==2
            texto='@1'
    else
        disp('NO HAY UN CUBO AZUL GRANDE');
    end 
    
elseif indicePalabra == 4
    
       if color1==1 && p1_tam==1
        texto='@3'
    
    elseif color2==1 && p2_tam==1
            texto='@2'
    elseif color3==1 && p3_tam==1
            texto='@1'
        
    else
        disp('NO HAY UN CUBO AZUL PEQUEÑO');
    end 
    
    
    
elseif indicePalabra == 5
    
   if color1==3 && p1_tam==2
        texto='@3'
    
    elseif color2==3 && p2_tam==2
            texto='@2'
    elseif color3==3 && p3_tam==2
            texto='@1'
    else
        disp('NO HAY UN CUBO VERDE GRANDE');
    end 
    
elseif indicePalabra == 6
    
       if color1==3 && p1_tam==1
        texto='@3'
    
    elseif color2==3 && p2_tam==1
            texto='@2'
    elseif color3==3 && p3_tam==1
            texto='@1'
   
        
        else
        disp('NO HAY UN CUBO VERDE PEQUEÑO');
        end 
    
else
   % texto = 'Valor de indicepalabra no válido';
end



% Crear una instancia del objeto para comunicación serial
delete(instrfind({'Port'},{'COM11'}));
s = serial('COM11'); % Reemplaza 'COM1' con el nombre del puerto serie adecuado

% Configurar los parámetros de comunicación
set(s, 'BaudRate', 9600); % Velocidad de transmisión
set(s, 'DataBits', 8); % Bits de datos
set(s, 'StopBits', 1); % Bits de parada
set(s, 'Parity', 'none'); % Paridad
set(s, 'Timeout', 1); % Tiempo de espera


% Abrir el puerto serie
fopen(s);

% Enviar el texto correspondiente a través del puerto serie


for k=1:10
    pause(0.3)
fprintf(s, texto);

% Cerrar el puerto serie


end
texto

fclose(s);



