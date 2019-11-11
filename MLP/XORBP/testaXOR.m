clear all; close all;

%criando o modelo

x1 = [0 0 1 1]';
x2 = [0 1 0 1]';

X = [x1 x2];
r  = [0; 1; 1; 0]; %os rótulos de saída
teta = 0.1;%learning rate

tamI = 4;
tamH = 2;
tamO = 1;

%o último parâmetro de cada matriz é o teta
Wih = -0.5 + (0.5+0.5).*rand(tamH,size(X,2)+1);%W entre Input e Hidden
Who = -0.5 + (0.5+0.5).*rand(tamO,tamH+1);%W entre Hidden e Output

[WihB,WhoB,rodadas] = backpropagation2(X,r,teta,1e-7,Wih,Who);
rodadas
[output,~] = forward ([0 0], WihB, WhoB)
[output,~] = forward ([0 1], WihB, WhoB)
[output,~] = forward ([1 0], WihB, WhoB)
[output,~] = forward ([1 1], WihB, WhoB)