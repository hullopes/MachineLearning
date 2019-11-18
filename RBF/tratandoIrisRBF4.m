%quarta tentativa - agora limitando as amostras para o treinamento
%validando para todas as amostras de testes
%implementando equações dos slides para classificação
%o número de neurônios da camada H é maior que os parâmetros de entrada
%considerando o vídeo https://www.youtube.com/watch?v=nOt_V7ndmLE
clear all; close all;

[v1,v2,v3,v4,labels] = textread('iris.txt','%f,%f,%f,%f,%s');
dadosI = [v1 v2 v3 v4];

nlabelsI = zeros(length(labels),3);

classes = [1 0 0;0 1 0;0 0 1];


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
h=5;%o número de neurônios da camada H - é maior que o número de atributos de entrada (4)
o=3;%número de saídas - neurônios da camada O = quantidade de classes = 3
%chutando os pesos iniciais - última coluna é o bias
Who = -0.01 + (0.01+0.01).*rand(o,h+1);%W entre Hidden e Output

%Who = [ 2.181105   2.978497  -1.593458  -1.786957  -1.868146  -0.092057; -1.044192  -1.333448   3.032104  -1.367466   1.697651  -0.166539;-1.142925  -1.638593  -1.427015   3.158314   0.164022   0.255263];

%aprendizado híbrido - slide 12
%%%%Passo 1
%centros e espalhamentos da primeira camada escondida
[centros,sigmas,err,espalhamento] = KMeansInit2(dadosI,h,1e-4);

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
  erron=0;
  erro=0;
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
         d4 = dados(a,:)-centros(4,:);
         d4quad = sum(d4.^2);
         resp(4,:) = exp(-(d4quad/(2*espalhamento(4)^2)));
         d5 = dados(a,:)-centros(5,:);
         d5quad = sum(d5.^2);
         resp(5,:) = exp(-(d5quad/(2*espalhamento(5)^2)));
         
         soma1 = (Who(1,1)*resp(1,:)) + (Who(1,2)*resp(2,:)) + (Who(1,3)*resp(3,:)) + (Who(1,4)*resp(4,:)) + (Who(1,5)*resp(5,:)) + Who(1,6);
         soma2 = (Who(2,1)*resp(1,:)) + (Who(2,2)*resp(2,:)) + (Who(2,3)*resp(3,:)) + (Who(2,4)*resp(4,:)) + (Who(2,5)*resp(5,:)) + Who(2,6);
         soma3 = (Who(3,1)*resp(1,:)) + (Who(3,2)*resp(2,:)) + (Who(3,3)*resp(3,:)) + (Who(3,4)*resp(4,:)) + (Who(3,5)*resp(5,:)) + Who(3,6);
         %usando o slide #17
         y1 = exp(soma1)/(sum([exp(soma1),exp(soma2),exp(soma3)]));
         y2 = exp(soma2)/(sum([exp(soma1),exp(soma2),exp(soma3)]));
         y3 = exp(soma3)/(sum([exp(soma1),exp(soma2),exp(soma3)]));
         
          erro = sum((nlabels(a,:)-[y1 y2 y3]).^2);
        erroQ = erroQ+erro;
        delta_h_o1 = n*(nlabels(a,1)-y1)*[resp',1];
        delta_h_o2 = n*(nlabels(a,2)-y2)*[resp',1];
        delta_h_o3 = n*(nlabels(a,3)-y3)*[resp',1];

        Who(1,:) = Who(1,:) + delta_h_o1;
        Who(2,:) = Who(2,:) + delta_h_o2; 
        Who(3,:) = Who(3,:) + delta_h_o3; 
   end
   
   erroQ = erroQ/length(dadosT)
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
         d4 = dadosV(i,:)-centros(4,:);
         d4quad = sum(d4.^2);
         resp(4,:) = exp(-(d4quad/(2*espalhamento(4)^2)));
         d5 = dadosV(i,:)-centros(5,:);
         d5quad = sum(d5.^2);
         resp(5,:) = exp(-(d5quad/(2*espalhamento(5)^2)));
         
         soma1 = (Who(1,1)*resp(1,:)) + (Who(1,2)*resp(2,:)) + (Who(1,3)*resp(3,:)) + (Who(1,4)*resp(4,:)) + (Who(1,5)*resp(5,:)) + Who(1,6);
         soma2 = (Who(2,1)*resp(1,:)) + (Who(2,2)*resp(2,:)) + (Who(2,3)*resp(3,:)) + (Who(2,4)*resp(4,:)) + (Who(2,5)*resp(5,:)) + Who(2,6);
         soma3 = (Who(3,1)*resp(1,:)) + (Who(3,2)*resp(2,:)) + (Who(3,3)*resp(3,:)) + (Who(3,4)*resp(4,:)) + (Who(3,5)*resp(5,:)) + Who(3,6);
         %usando o slide #17
         y1 = exp(soma1)/(sum([exp(soma1),exp(soma2),exp(soma3)]));
         y2 = exp(soma2)/(sum([exp(soma1),exp(soma2),exp(soma3)]));
         y3 = exp(soma3)/(sum([exp(soma1),exp(soma2),exp(soma3)]));
         
         %[y1 labelsV(i,1);y2 labelsV(i,2)];
         
         r = labelsV(i,:);%a label verdadeira
         
         t = [y1>0.5 y2>0.5 y3>0.5];
         
         if find(r==max(r))==find(t==max(t))
           acertos+=1;
         end;
end
acertos = acertos/length(dadosV);
disp([num2str(acertos*100) ' % de acertos']);


