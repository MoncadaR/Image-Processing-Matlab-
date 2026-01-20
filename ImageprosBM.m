%Ejercicio 8 
%Cargue el marco 17 de la imagen de resonancia magnética mri.tiff. Convierta la imagen a clase Intensidad y doble formato. 
% Realice las siguientes operaciones de Vecindad deslizante:
%1. Promediando sobre un bloque deslizante de 3 por 3, mean2 usando la herramienta "nlfilter" x
%2. Diferenciación (diferenciación espacial) usando la función, F (inline)
%F = inline('2*x(2,2)-sum(x(1:3,1))/3-sum(x(1:3,3))/3 - x(1,2) - x(3,2)');
%3. Detección de límites verticales usando un diferenciador vertical de 3 por 2
%F = inline('sum(x(1:3,2))-sum(x(1:3,1))');
%4. Realice una matriz de imagen 2 x 2 que contenga los resultados e incluya la imagen original

clc;
clear;
clear vars;

[I,map] = imread('mri.tif',17);

if isempty(map) == 0
    I= ind2gray(I,map);
end

I = im2double(I);

I_prom = nlfilter(I, [3 3], 'mean2'); %promedio 


F = inline('2*x(2,2)-sum(x(1:3,1))/3-sum(x(1:3,3))/3-x(1,2)-x(3,2)');
I_dif = nlfilter(I,[3,3],F);  %Diferencial 

F1 = inline('sum(x(1:3,2))-sum(x(1:3,1))');
I_ver = nlfilter(I,[3 2],F1); %Verticales


I_prom = mat2gray(I_prom); 
I_ver = mat2gray(I_ver);           %Reeescalar
I_dif = mat2gray(I_dif);

BW_IZ = im2bw(I_ver,0.8);
BW_DER = ~im2bw(I_ver, 0.68);

subplot(2,2,1);
imshow(I);
title('Oringial')

subplot(2,2,2);
imshow(I_prom);
title('Promedio');

subplot(2,2,3);
imshow(I_dif);
title('Diferenciada');

subplot(2,2,4);
imshow(I_ver);
title('Verticales');
