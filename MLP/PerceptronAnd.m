%Perceptron aprendendo a operação Booleana And
clear all; close all; clc;
x1 = [0 0 1 1];
x2 = [0 1 0 1];
r  = [0 0 0 1]; %os rótulos de saída

x0 = 1; 
W   = [-1.5 1 1];
Wor = [-0.5 1 1];



y = []; yor=[];
for i=1:length(x1)
  y(end+1)   = (x1(i)*W(2))+(x2(i)*W(3))+(W(1)*x0);
  yor(end+1) = (x1(i)*Wor(2))+(x2(i)*Wor(3))+(Wor(1)*x0);
end

disp('Resultados para a tabela verdade do operador AND');
for i=1:length(y)
  if(y(i)>=0)
    disp(['x1 = ' num2str(x1(i)) ' AND x2 = ' num2str(x2(i)) ' - Classe 1']);
  else
    disp(['x1 = ' num2str(x1(i)) ' AND x2 = ' num2str(x2(i)) ' - Classe 2']);
  end
end

disp('Resultados para a tabela verdade do operador OR');
for i=1:length(yor)
  if(yor(i)>=0)
    disp(['x1 = ' num2str(x1(i)) ' OR x2 = ' num2str(x2(i)) ' - Classe 1']);
  else
    disp(['x1 = ' num2str(x1(i)) ' OR x2 = ' num2str(x2(i)) ' - Classe 2']);
  end
end