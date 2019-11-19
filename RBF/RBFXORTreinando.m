%tratando o XOR com RBF
%Classifica com treinamento
clear all; close all;
Xt = [0 0;0 1;1 0;1 1];
Rt = [0;1;1;0];

I = size(Xt,2);%entradas
H = 4;% neurônios da camada H
O = 1;% neurônios da camada O
n = 0.1;%taxa de aprendizagem

%W = [-1 1 1 -1];%pesos
W = -0.01 + (0.01+0.01).*rand(O,H);%W chutado entre Hidden e Output
centros = Xt;% como são 4 centros, eles são as próprias entradas.
%S = [1 1 1 1];
limiar = 1e-4;
erroQ = 10*limiar;
erros = [];
while erroQ > limiar
      %espalhamentos -> 0.5 é 1/P, sendo P a quantidade de vizinhos necessários, que são 2
      S1 = sqrt(0.5*sum((centros(1,:)-centros(4,:)).^2));
      S2 = sqrt(0.5*sum((centros(2,:)-centros(3,:)).^2));
      S3 = sqrt(0.5*sum((centros(3,:)-centros(2,:)).^2));
      S4 = sqrt(0.5*sum((centros(4,:)-centros(1,:)).^2));
      %computando as RBFs
      phi1(1) = exp(-(norm(Xt(1,:)-centros(1,:)))/(2*S1^2));
      phi1(2) = exp(-(norm(Xt(2,:)-centros(1,:)))/(2*S1^2));
      phi1(3) = exp(-(norm(Xt(3,:)-centros(1,:)))/(2*S1^2));
      phi1(4) = exp(-(norm(Xt(4,:)-centros(1,:)))/(2*S1^2));

      phi2(1) = exp(-(norm(Xt(1,:)-centros(2,:)))/(2*S2^2));
      phi2(2) = exp(-(norm(Xt(2,:)-centros(2,:)))/(2*S2^2));
      phi2(3) = exp(-(norm(Xt(3,:)-centros(2,:)))/(2*S2^2));
      phi2(4) = exp(-(norm(Xt(4,:)-centros(2,:)))/(2*S2^2));

      phi3(1) = exp(-(norm(Xt(1,:)-centros(3,:)))/(2*S3^2));
      phi3(2) = exp(-(norm(Xt(2,:)-centros(3,:)))/(2*S3^2));
      phi3(3) = exp(-(norm(Xt(3,:)-centros(3,:)))/(2*S3^2));
      phi3(4) = exp(-(norm(Xt(4,:)-centros(3,:)))/(2*S3^2));

      phi4(1) = exp(-(norm(Xt(1,:)-centros(4,:)))/(2*S4^2));
      phi4(2) = exp(-(norm(Xt(2,:)-centros(4,:)))/(2*S4^2));
      phi4(3) = exp(-(norm(Xt(3,:)-centros(4,:)))/(2*S4^2));
      phi4(4) = exp(-(norm(Xt(4,:)-centros(4,:)))/(2*S4^2));
      
      phiB = 1;

      %phiW = (phi1*W(1))+(phi2*W(2))+(phi3*W(3))+(phi4*W(4)+(phiB*W(5)));
      phiW = (phi1*W(1))+(phi2*W(2))+(phi3*W(3))+(phi4*W(4));
      O = phiW>0;%a saída, pois se for > 0, pertence à classe 1
      phi = [phi1;phi2;phi3;phi4];
      erro = (phiW'-Rt);%testar!
      erroQ = sum(erro.^2);
      erros(end+1) = erroQ;
      %W(1) = pinv(phi1'*phi1)*phi1'.*phiW(1);%ajustando o peso, testar!!%gradiente !!
      %W(1) = sum(pinv(phi1'*phi1)*phi1'.*O(1));%acho que é este aqui para cada H
      W = (inv(phi'*phi)*phi*Rt)';%atualiza W de uma só vez
end

%testando
disp(['[' num2str(Xt(1,1)) ',' num2str(Xt(1,2)) '] -> Rt=' num2str(Rt(1)) ' - classificado como ' num2str(O(1))]);

disp(['[' num2str(Xt(2,1)) ',' num2str(Xt(2,2)) '] -> Rt=' num2str(Rt(2)) ' - classificado como ' num2str(O(2))]);

disp(['[' num2str(Xt(3,1)) ',' num2str(Xt(3,2)) '] -> Rt=' num2str(Rt(3)) ' - classificado como ' num2str(O(3))]);

disp(['[' num2str(Xt(4,1)) ',' num2str(Xt(4,2)) '] -> Rt=' num2str(Rt(4)) ' - classificado como ' num2str(O(4))]);