clc; clear; close all;

I = imread('celulas2.jpg'); 
IG = rgb2gray(I); 
IGeq = histeq(IG); 

% % Mostrar cambios previos a la imágen: Original, Escala de grises y ecualización

figure(); 
subplot(1,3,1), imshow(I), title('Imagen Original'); 
subplot(1,3,2), imshow(IG), title('Imagen Esacala de grises'); 
subplot(1,3,3), imshow(IGeq), title('Imagen ecualizada');

% SE = strel(forma, parámetro); 

se1 = strel('line', 10, 45); 
se2 = strel('disk', 15); 
J1 = imdilate(IG, se1); 

% Dilatación 
J2 = imerode(IG, se1); 

% Erosión 
J3 = imopen(IG, se2); 

% Apertura 
J4 = imclose(IG, se2); 

% Cierre 
figure(); 
subplot(2,2,1), imshow(J1), title('Diltación'); 
subplot(2,2,2), imshow(J2), title('Erosión'); 
subplot(2,2,3), imshow(J3), title('Apertura'); 
subplot(2,2,4), imshow(J4), title('Cierre'); 

BW = imbinarize(J1, 0.07); % Binarizar la imagen 

% Los parámetros de imbinarize pueden cambiar según la imagen, modificar hasta obtener buen resultado 

BW = imfill(BW, 'holes'); % Rellenar los agujeros 
figure, imshow(BW), title('Imágen con umbral de 0.07'); 
C = bwlabel(BW); C1 = max(max(C)); disp('La cantidad de células son: '), disp(C1); 

% ==================
P = regionprops(C, "all");
centro = P.Centroid; Diametro = mean([P.MajorAxisLength P.MinorAxisLength],2); 
Radio = Diametro/2; figure(2); viscircles(centro, Radio); 
Caja = P.BoundingBox; Corte = imcrop(I, Caja); 
figure();
imshow(Corte);