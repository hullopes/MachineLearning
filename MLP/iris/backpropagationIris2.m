## fazendo o BP
function [Wih, Who,cont] = backpropagationIris2 (dados, rotulos, eta, limiar, Wih, Who)
  erroQuadrado = 2 * limiar;
  cont = 0;
  while erroQuadrado > limiar
     eQ=0;    ids = randperm(size(dados,1));%lista randômica
    dados = dados(ids,:);%ordenando com ids
    rotulos = rotulos(ids,:);
    for a = 1:length (dados)
      Xp = dados (a, :);%% obtendo a amostra
            
      %% obtendo a saí­da da net para a amostra Xp atual
      [output, net_h_p, f_net_h_p, net_o_p, f_net_o_p] = forward (Xp, Wih, Who);
      
      %erro = (output' - rotulos(a,:)).^2;
      %eQ = eQ+sum(erro);
      erroQ = sum(rotulos(a,:) - output');
      erro = rotulos(a,:) - output';
      %erro = 1/2*(rotulos (a) - output)^2;
      eQ = eQ + sum (erroQ .^ 2);
      
      
      %delta_o_p = erro * df_net(f_net_o_p);
      delta_o_p = erro .* df_net(f_net_o_p)';
      
      w_o_kj = f_net_h_p;
      
      %delta_h_p = df_net (f_net_h_p) .* (delta_o_p * w_o_kj);
      delta_h_p = df_net (f_net_h_p) .* (delta_o_p'.*w_o_kj);
      delta_h_p = df_net(f_net_h_p).*(delta_o_p.*w_o_kj);
      ## atualiza os pesos

      %Who = Who + eta * (delta_o_p * [f_net_h_p, 1]);
      Who = Who + eta * (delta_o_p' .* [f_net_h_p, 1]);
      Wih = Wih + eta * (delta_h_p' * [Xp, 1]);
      
      
      
    end
    erroQuadrado = eQ / length (dados)
    %eQ / length (dados)
    if cont > 100000
      break;
    end  
    cont = cont+1;%contando as iterações
  end
end

