% Número de archivos por tipo
numArchivos = 20;
fs=16000;

% Colores disponibles
tam = {'peque', 'grande'};

% Inicializar matrices para almacenar características y etiquetas
caracteristicas = [];
etiquetas = [];

% Recorrer los colores
for c = 1:numel(tam)
    ta = tam{c};
    
    % Leer los archivos de audio del color actual
    for i = 1:numArchivos
        % Construir el nombre del archivo
        nombreArchivo = sprintf('%s%d.wav', ta, i);
        
        % Cargar el archivo de audio
        [audio, fs] = audioread(nombreArchivo);
        
        % Extraer características MFCC del archivo de audio
        mfccFeatures = mfcc(audio, fs);
        
        % Agregar las características y etiquetas a las matrices
        caracteristicas = [caracteristicas; mfccFeatures];
        etiquetas = [etiquetas; repmat(c, size(mfccFeatures, 1), 1)];
    end
end

% Entrenar el clasificador SVM
svm_modelo = fitcecoc(caracteristicas, etiquetas);

% Guardar el modelo entrenado
save('modelo_tam.mat', 'svm_modelo');
clc
