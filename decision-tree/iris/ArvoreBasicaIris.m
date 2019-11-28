clear all; close all;

[v1,v2,v3,v4,labels] = textread('iris.txt','%f,%f,%f,%f,%s');
dados = [v1 v2 v3 v4];

arvore = [5.45 2.8 6.15 3.1]; %valores de decisão

%classificando pela sépala width e lenght
acertos = 0;
for i=1:length(dados)
  rt = {};
  if dados(i,1) < arvore(1)
    if dados(i,2) >= arvore(2)
      rt = 'Iris-setosa';
    else
      rt = 'Iris-versicolor';
    end
  else
    if dados(i,1) < arvore(3)
      if dados(i,2) >= arvore(4)
        rt = 'Iris-setosa';
      else
        rt = 'Iris-versicolor';
      end
    else
      rt = 'Iris-virginica';  
    end
  end
  acertos = acertos + strcmp(rt,labels(i));
end
