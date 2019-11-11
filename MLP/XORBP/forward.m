
## fazendo o forward
function [output, net_h_p, f_net_h_p, net_o_p, f_net_o_p] = forward (Xp, Wih, Who)
  ## camada H
  net_h_p = Wih * [Xp, 1]';
  ## a soma dos produtos dos pesos para a entrada
  f_net_h_p = ativacao (net_h_p');
  ## a ativação
  
  ## camada O
  %net_o_p = Who * [net_h_p; 1];
  net_o_p = Who * [f_net_h_p'; 1];
  ## cria um novo vetor adicionando 1 para a coluna do teta
  f_net_o_p = ativacao (net_o_p);
  output = f_net_o_p;
end

