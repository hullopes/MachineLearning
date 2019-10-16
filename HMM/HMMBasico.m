#ref https://github.com/luisguiserrano/hmm/blob/master/Simple%20HMM.ipynb
clear all; close all;
# estados
#s stands for Sunny
#r stands for Rainy
#h stands for Happy
#g stands for Grumpy

# Matriz de transição -> prioris aprendidas nos dados
# [ss sr; rs rr]
A = [0.8 0.2;0.4 0.6];

# prob iniciais - pi -> avaliação das prioris baseada nos dados de aprendizagem
# [p_s p_r]; %-> p_s = prob(sunny) p_r = prob(rainy)
pis = [2/3 1/3];

# Probabilidades de Emissão -> matriz B de probabilidades de observação
# aqui ao invés das caixas de bolas dos slides, temos o estado happy ou grumpy
# sh = Sunny - Happy sg = Sunny - Grumpy rh = Rainy - Happy rg = Rainy - Grumpy
# ou seja, Ter sol e ele estar feliz, ter sol e ele estar mal humorado
# [sh sg; rh rg]
B = [0.8 0.2; 0.4 0.6];

#sequência de observação
# happy happy grumpy grumpy grumpy happy
humor = ['H', 'H', 'G', 'G', 'G', 'H'];
probabilidades = zeros(length(humor),2);
clima = [];

#a ideia aqui é, baseado no humor do cabra, decidir o clima naquele instante T
#usando algoritmo de Viterbi para encontrar o melhor caminho entre os estados internos
#é um problema do tipo 1 (slides)
#calculando a probabilidade de entrada
if humor(1) == 'H'
    probabilidades(1,:) = [pis(1)*B(1,1), pis(2)*B(2,1)];
else
    probabilidades(1,:) = [pis(1)*B(1,2), pis(2)*B(2,2)];
end

%agora temos o estado inicial, isto é, o instante t
%seguindo a ideia de Markov, para sabermos o estado t+1, só precisamos conhecer t
%e os parâmetros lambda={B,pis (pisão nos slides),A)    

for i=2:length(humor)
    %obtendo prob(t-1)
    yesterday_sunny = probabilidades(i-1,1);
    yesterday_rainy = probabilidades(i-1,2);
    
    if humor(i) == 'H'
        today_sunny = max(yesterday_sunny*A(1,1)*B(1,1), yesterday_rainy*A(2,1)*B(1,1));
        today_rainy = max(yesterday_sunny*A(1,2)*B(2,1), yesterday_rainy*A(2,2)*B(2,1));
    else
        today_sunny = max(yesterday_sunny*A(1,1)*B(1,2), yesterday_rainy*A(2,1)*B(1,2));
        today_rainy = max(yesterday_sunny*A(1,2)*B(2,2), yesterday_rainy*A(2,2)*B(2,2));
    end
    probabilidades(i,:) = [today_sunny, today_rainy];
end

for p=1:length(probabilidades)
    if probabilidades(p,1) > probabilidades(p,2)
        weather(end+1) = 'S';
    else
        weather(end+1) = 'R';
    end
end   
