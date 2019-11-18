%quarta tentativa - agora limitando as amostras para o treinamento
%validando para todas as amostras de testes
%implementando a atualização dos centros e do espalhamento
clear all; close all;

[v1,v2,v3,v4,labels] = textread('iris.txt','%f,%f,%f,%f,%s');
dadosI = [v1 v2 v3 v4];

nlabelsI = zeros(length(labels),2);

classes = [0 0;1 0;0 1];


%alterando as labels para números, conforme vetor classes
for i=1:length(labels)
  if ismember('Iris-setosa',labels(i))==1
    nlabelsI(i,:) = classes(1,:);
  elseif ismember('Iris-versicolor',labels(i))==1
    nlabelsI(i,:) = classes(2,:);
  else
    nlabelsI(i,:) = classes(3,:);
  end
end

limiteT = 30;
rangeT = [1:limiteT 51:51+limiteT-1 101:101+limiteT-1];
dadosT = dadosI(rangeT,:);
labelsT= nlabelsI(rangeT,:);

limiteV = 20;
rangeV = [31:limiteT+limiteV 81:81+limiteV-1 131:131+limiteV-1];
dadosV = dadosI(rangeV,:);
labelsV= nlabelsI(rangeV,:);


n = 0.12;
h=3;%número de clusters, ou o número de neurônios da camada H
o=2;%número de saídas - neurônios da camada O
%chutando os pesos iniciais - última coluna é o bias
Who = -0.01 + (0.01+0.01).*rand(o,h+1);%W entre Hidden e Output

%Who com acerto
%Who = [ -0.851257   1.386992  -4.858578   4.162226;0.025432  -1.248337   5.548713  -3.908919];
%Who = [  -0.96053   1.41182  -5.31746   4.58267; 0.14745  -1.24920   6.06317  -4.39496];
%Who = [ -0.90276   1.41651  -5.00813   4.32980;0.10296  -1.27981   5.78696  -4.15554];%deu 91% de acerto
%aprendizado híbrido - slide 12
%%%%Passo 1
%centros e espalhamentos da primeira camada escondida
[centros,sigmas,erro,espalhamento] = KMeansInit(dadosI,h,1e-4);

%%%%Passo 2
%pesos da segunda camada
S = espalhamento./2;%dica do slide 12 (rbf) - metade da distância do cabra mais distante
limiar = 11e-2;
erroQ = 2*limiar;
erros = [];
cont = 0;
while erroQ > limiar
  cont+=1;
  erroQ=0;
  for a=1:length(dadosT)
         ids = randperm(size(dadosT,1));%lista randômica
         dados = dadosT(ids,:);%ordenando com ids
         nlabels = labelsT(ids,:);
        %o mesmo que norm(dados(a,:)-centros(1,:)) -> a norma do vetor
         d1 = dados(a,:)-centros(1,:);
         d1quad = sum(d1.^2);
         resp(1,:) = exp(-(d1quad/(2*espalhamento(1)^2)));
         d2 = dados(a,:)-centros(2,:);
         d2quad = sum(d2.^2);
         resp(2,:) = exp(-(d2quad/(2*espalhamento(2)^2)));
         d3 = dados(a,:)-centros(3,:);
         d3quad = sum(d3.^2);
         resp(3,:) = exp(-(d3quad/(2*espalhamento(3)^2)));
         
         y1 = (Who(1,1)*resp(1,:)) + (Who(1,2)*resp(2,:)) + (Who(1,3)*resp(3,:)) + Who(1,4);
         y2 = (Who(2,1)*resp(1,:)) + (Who(2,2)*resp(2,:)) + (Who(2,3)*resp(3,:)) + Who(2,4);
         
         %erro % slide 14
        erro = sum((nlabels(a,:)-[y1 y2]).^2);
        erroQ = erroQ+erro;
        delta_h_o1 = n*(nlabels(a,1)-y1)*[resp',1];
        delta_h_o2 = n*(nlabels(a,2)-y2)*[resp',1];

        Who(1,:) = Who(1,:) + delta_h_o1;
        Who(2,:) = Who(2,:) + delta_h_o2; 
   end
   erroQ = erroQ/length(dados)
   erros(end+1) = erroQ;
   if cont>1000
     break;
   end
    
end

%validando%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

acertos = 0;
for i=1:length(dadosV)
  
         d1 = dadosV(i,:)-centros(1,:);
         d1quad = sum(d1.^2);
         resp(1,:) = exp(-(d1quad/(2*espalhamento(1)^2)));
         d2 = dadosV(i,:)-centros(2,:);
         d2quad = sum(d2.^2);
         resp(2,:) = exp(-(d2quad/(2*espalhamento(2)^2)));
         d3 = dadosV(i,:)-centros(3,:);
         d3quad = sum(d3.^2);
         resp(3,:) = exp(-(d3quad/(2*espalhamento(3)^2)));
         
         y1 = (Who(1,1)*resp(1,:)) + (Who(1,2)*resp(2,:)) + (Who(1,3)*resp(3,:)) + Who(1,4);
         y2 = (Who(2,1)*resp(1,:)) + (Who(2,2)*resp(2,:)) + (Who(2,3)*resp(3,:)) + Who(2,4);
         
         %[y1 labelsV(i,1);y2 labelsV(i,2)];
         
         t = [y1>0.5 y2>0.5];
         
         if sum(t==labelsV(i,:))==2
           acertos+=1;
         end;
end
acertos = acertos/length(dadosV);
disp([num2str(acertos*100) ' % de acertos']);


