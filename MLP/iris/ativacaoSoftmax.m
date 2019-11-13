function result = ativacaoSoftmax (input,k)
  %result = 1 ./ (1 + exp (-input));%sigmóide
        yi = zeros(1,k);        
        for i=1:k
          yi(i) = exp(input(i))/sum(exp(input));%softmax segundo slide #13
        end
        result = yi;
  %result = exp(os(i))/sum(exp(os));%softmax segundo slide #13
end

