clear all; close all;

[v1,v2,v3,v4,labels] = textread('iris.txt','%f,%f,%f,%f,%s');
dados = [v1 v2 v3 v4];

nlabels = zeros(length(labels),2);

classes = [0 0;1 0;0 1];

%alterando as labels para números, conforme vetor classes
for i=1:length(labels)
  if ismember('Iris-setosa',labels(i))==1
    nlabels(i,:) = classes(1,:);
  elseif ismember('Iris-versicolor',labels(i))==1
    nlabels(i,:) = classes(2,:);
  else
    nlabels(i,:) = classes(3,:);
  end
end


teta = 0.1;%learning rate

tamI = 4;
tamH = 2;
tamO = 2;

%o último parâmetro de cada matriz é o teta
Wih = -0.5 + (0.5+0.5).*rand(tamH,size(dados,2)+1);%W entre Input e Hidden
Who = -0.5 + (0.5+0.5).*rand(tamO,tamH+1);%W entre Hidden e Output

%[output, net_h_p, f_net_h_p, net_o_p, f_net_o_p] = forward (dados(1,:), Wih, Who);
[WihB,WhoB,rodadas] = backpropagationIris2(dados,nlabels,teta,1e-4,Wih,Who);

%pesos já ajustados e que convergem
%Wih = [ -0.124844,  -1.909076,   2.464894,   0.953096,  -0.058733;-1.564151,  -1.656641,   2.686407,   2.911765,  -2.628773];
%Who =  [18.3245, -17.2794, -5.6453; -5.2879, 18.8289, -8.5789];

[output,~] = forward (dados(1,:), WihB, WhoB);
[output,nlabels(1,:)']
[output,~] = forward (dados(51,:), WihB, WhoB);
[output,nlabels(51,:)']

[output,~] = forward (dados(150,:), WihB, WhoB);
[output,nlabels(150,:)']