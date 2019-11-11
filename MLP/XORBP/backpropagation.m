## fazendo o BP
function [Wih, Who] = backpropagation (dados, rotulos, eta, limiar, Wih, Who)
  erroQuadrado = 2 * limiar;
  cont = 0;
  while erroQuadrado > limiar
     eQ=0;    ids = randperm(size(dados,1));%lista randômica
    dados = dados(ids,:);%ordenando com ids
    rotulos = rotulos(ids);
    for a = 1:length (dados)
      Xp = dados (a, :);
      ## obtendo a amostra
      
      ## obtendo a saÃ­da da net para a amostra Xp atual
      [output, net_h_p, f_net_h_p, net_o_p, f_net_o_p] = forward (Xp, Wih, Who);
      erro = rotulos (a) - output;
      %erro = 1/2*(rotulos (a) - output)^2;
      eQ = eQ + sum (erro ^ 2);
      ## treinando
      
      ## para os pesos da camada O
      ## delta_o_p = delta_p * fwd$df_o_dnet_o_pk
      delta_o_p = erro * df_net(f_net_o_p);
      ## atualiza os pesos entre H e O
      ## Who = Who - eta * delta_o_p; 
      ## para os pesos da camada H
      w_o_kj = Who(1:2);
      %w_o_kj = f_net_h_p;
      %w_o_kj = net_h_p;
      ## exluindo a Ãºltima coluna, que Ã© do teta
      
      %w.length = ncol(model$layers$output)-1
		  %delta_h_p = fwd$df_h_dnet_h_pj * 
			%(delta_o_p %*% model$layers$output[,1:w.length])
      delta_h_p = df_net (f_net_h_p) .* (delta_o_p * w_o_kj);
      ## atualiza os pesos
      Who = Who + eta * (delta_o_p * [f_net_h_p, 1]);
      Wih = Wih + eta * (delta_h_p' * [Xp, 1]);
    end
    erroQuadrado = eQ / length (dados)
    if cont > 50000
      break;
    end  
    cont = cont+1;%contando as iterações
  end
end

