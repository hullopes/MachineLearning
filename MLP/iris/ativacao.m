function result = ativacao (input,k)
  result = 1 ./ (1 + exp (-input));%sigm�ide
##        yi = zeros(1,k);
##        er = zeros(1,k); %c�lculo do erro
##        
##        for i=1:k
##          yi(i) = exp(input(i))/sum(exp(input));%softmax segundo slide #13
##        end
##        result = yi;
  %result = exp(os(i))/sum(exp(os));%softmax segundo slide #13
end

