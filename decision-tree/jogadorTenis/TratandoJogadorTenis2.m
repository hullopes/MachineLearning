clear all; close all;
% pkg load io;
ds = csv2cell('play_tennis.csv');
%contagem e rótulos
[uc1,uc2,rc1,rc2]=contaInstancias(ds(2:end,5),ds(2:end,6));

%entropia total
eTotal = 0;
for i=1:length(rc2)
  p = sum(rc2(i,:))/sum(sum(rc2));
  eTotal = eTotal+ (-p*log2(p));
end

maiorGanho = 0;
maiorGanhoI= 0;
for ii=2:5
    [uc1,uc2,rc1,rc2]=contaInstancias(ds(2:end,ii),ds(2:end,6));
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

    %ganho para o wind
    ganho = eTotal - se;
    
    if ganho > maiorGanho
      maiorGanho = ganho
      maiorGanhoI= ii;
    end  

end