function retval = CalculaGanho (c1, c2, eTotal)
    [uc1,uc2,rc1,rc2]=contaInstancias(c1,c2);
    %entropia para os conjuntos da coluna Wind (coluna 5)
    e = zeros(size(uc1));%1 zero para cada categoria do conjunto da coluna
    g = eTotal;
    se = 0;
    for i=1:length(rc1)
      for c=1:size(rc1,2)
        p = sum(rc1(i,c))/sum(rc1(i,:));
        l2 = log2(p); if isinf(l2) l2=0; end %tratando o -inf para log2 de zero
        e(i) = e(i) + (-p*l2);
      end
      se = se + (sum(rc1(i,:))/sum(sum(rc1)))*e(i);
    end

    %ganho de informação, segundo equação 9.3
    retval = eTotal - se;
end
