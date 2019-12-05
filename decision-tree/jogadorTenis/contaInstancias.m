function [uc1,uc2,rc1,rc2] = contaInstancias (col1, col2)
##  rotulos = unique(labels);
##  contagem =zeros(size(rotulos));
##  
##  for l=1:length(rotulos)
##      for i=1:length(dados)
##        contagem(l)+=isequal(labels(i),rotulos(l));
##      end
##  end
  %contagem da col1 em relação à col2
  uc1 = unique(col1);%tipos únicos da coluna 1
  uc2 = unique(col2);%tipos únicos da coluna 2
  rc1 = zeros(length(uc1),length(uc2));
  rc2 = zeros(size(uc2));
  
  for l=1:length(col1)
    for i=1:length(uc1)
      for c=1:length(uc2)
        if isequal(uc1(i),col1(l))
          rc1(i,c)+=isequal(col2(l),uc2(c));
        end  
      end
    end
  end  
  for l=1:length(uc2)
      for i=1:length(col2)
        rc2(l)+=isequal(col2(i),uc2(l));
      end
  end
  
end
