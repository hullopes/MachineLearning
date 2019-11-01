%baseado em https://juliocprocha.blog/2017/07/27/perceptron-para-classificacao-passo-a-passo/comment-page-1/?unapproved=582&moderation-hash=c38f7746832818ab9313d145b5a492b0#comment-582
clear all; close all;
cores = {['xr'],['+g']};
function p=perda(y)
  if y>=0
    p=2;
  else
    p=1;
  end
endfunction

function [xreta,yreta]=reta(w1,w2)
  yreta = [-1:0.001:1];
  xreta = yreta/(w1/w2);
  yreta = sort(yreta,'descend');
endfunction

x=[0.3 -0.6 -0.1 0.1];
y=[0.7 0.3 -0.8 -0.45];
classe=[2 1 1 2];%alterados do problema original para o controle de cores

w1 = 0.8; w2 = -0.5;
n=0.5; %nepna =  taxa de aprendizado

%plot inicial
[xreta,yreta] = reta(w1,w2);
plot(xreta,yreta); hold on;
plot(x,y,'ob'); hold off;
title('Fase inicial');
legend({['Reta W'] ['Pontos sem classificação']});



for i=1:length(x)
  
  %calcula a saída
  output = (x(i)*w1)+(y(i)*w2);
  %avaliamos a perda para saber se acertou ou errou
  p = perda(output);
  if p!=classe(i)
    %errou, precisa ajustar os pesos
    %medir o errou
    e = classe(i)-p;% o erro é a diferença entre o que queremos com o que calculamos
    w1 = w1+n*e*x(i);
    w2 = w2+n*e*y(i);
    
    %plotando após o ajuste
    figure();
    [xreta,yreta] = reta(w1,w2);
    plot(xreta,yreta); hold on;
    plot(x,y,'ob'); hold off;
    title(['Fase Ajustando W- ' num2str(i)]);
    legend({['Reta W'] ['Pontos sem classificação']});
    
  end
  
end
gr1  = []; gr2 = [];

%colocando cada amostra em um grupo
for i=1:length(x)  
  %calcula a saída
  output = (x(i)*w1)+(y(i)*w2);
  %avaliamos a perda para saber se acertou ou errou
  p = perda(output);
  if p==1
    gr1(end+1,:) = [x(i) y(i)];
  else
    gr2(end+1,:) = [x(i) y(i)];
  end
  
end
    figure();
    plot(xreta,yreta); hold on;
    plot(x,y,'ob');
    plot(gr1(:,1),gr1(:,2),cores(1))
    plot(gr2(:,1),gr2(:,2),cores(2))
    title(['Fase Final']);
    legend({['Reta W'] ['Pontos sem classificação'] ['Grupo 1'] ['Grupo 2']},'location','northwest');