clear all; close all;

%criando o modelo

x1 = [0 0 1 1]';
x2 = [0 1 0 1]';

X = [x1 x2];
r  = [0; 1; 1; 0]; %os rótulos de saída
teta = 0.12;%learning rate

tamI = 4;
tamH = 2;
tamO = 1;

%o último parâmetro de cada matriz é o teta
Wih = -0.5 + (0.5+0.5).*rand(tamH,size(X,2)+1);%W entre Input e Hidden
Who = -0.5 + (0.5+0.5).*rand(tamO,tamH+1);%W entre Hidden e Output

%Who = [0.15875, -0.043838, -0.014375];%pesos que convergem
%Wih = [0.11545, 0.12197, 0.42544; -0.040643, 0.20039, -0.014375];
%Who = [0.064560, 0.17998, -0.10476];
%Wih = [-0.34522, -0.11992, 0.021075; 0.45505, 0.22241, -0.10950];

Who = [13, 13,-8];%convergem rápido
Wih = [3, -3, -1; -3, 3, -1];%convergem rápido

[WihB,WhoB,rodadas] = backpropagation2(X,r,teta,1e-3,Wih,Who);
rodadas
[output,~] = forward ([0 0], WihB, WhoB)
[output,~] = forward ([0 1], WihB, WhoB)
[output,~] = forward ([1 0], WihB, WhoB)
[output,~] = forward ([1 1], WihB, WhoB)