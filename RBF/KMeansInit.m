function [centros,sigmas,erro,espalhamento] = KMeansInit(dados,k,limiar)
  d = size(dados,2);%obtendo as dimens�es da amostra(colunas)
  %indice inicial dos centros
  od = sort(dados);
  %chutando k centróides para inicializar
  mm = [ceil((length(od)/(k*2))):ceil((length(od)/k)):length(od)];
  Mi = dados(mm,:);%vetor de m�dias Mis, sendo 1 para cada k
  dados(isnan(dados))=0;%removendo algum poss�vel NaN
  %hist�rico dos ajustes das centr�ides
  erro =[];  
  er = limiar*10;
  
  espalhamento = zeros(1,k);
  
  %crit�rio de parada da clusteriza��o, erro das dist�ncias ser menor que o limiar
  while er>limiar
      grupo1 = [];
      grupo2 = [];
      grupo3 = [];
      %clusteriza��o
      for i=1:length(dados)
        distancia = zeros(1,k);
        for ki=1:k %varrendo para cada cluster
          distancia(ki) = calculaDist(dados(i,:),Mi(ki,:));
        end  
        id = find(distancia(:)==min(distancia));%pegando o id da menor dist�ncia  
        %impedindo que, em caso de empate, tenhamos 2 valores
        %if length(id)>1
        %    id = id(1);
        %end    
        if id==1
            grupo1(end+1,:) = dados(i,:);
        else if id==2
            grupo2(end+1,:) = dados(i,:);
          else
            grupo3(end+1,:) = dados(i,:);
          end
        end    
        
      end
      %atualizando as centr�ides      
       Minovo(1,:) = mean(grupo1);      
       Minovo(2,:) = mean(grupo2);
       Minovo(3,:) = mean(grupo3);
     
      
      %calculando a média do erro das centróides para cada k
      total = 0;
      for i=1:k
        total = calculaDist(Minovo(i,:),Mi(i,:));
      end
      er = total/k;%média
      erro(end+1) = er;
      Mi = Minovo;
  end
  centros = Mi;
  
  %de posse das médias, calcular os sigmas para cada média
  sigmas =  zeros(d,d,k);
  for g=1:k
      %calculando a covariância
      for i=1:d
        co = 0;
        for j=1:d
          cNorm = dados(:,i)-centros(g,i);
          dNorm = dados(:,j)-centros(g,j);
          prodCD = cNorm.*dNorm;
          co = sum(prodCD)/(length(dados)-1);
          sigmas(i,j,g) = co;
        end
      end
  end
  
  %calcular o espalhamento conforme dica do slide 7 (rbf), 
  %metade da dist�ncia da inst�ncia mais distante
  %grupo 1
  maiorD1 = -1000;
  for i=1:length(grupo1)
    d = calculaDist(grupo1(i,:),centros(1,:));
    if d>maiorD1
      maiorD1 = d;
    end
  end
  %grupo 2
  maiorD2 = -1000;
  for i=1:length(grupo2)
    d = calculaDist(grupo2(i,:),centros(2,:));
    if d>maiorD2
      maiorD2 = d;
    end
  end
  %grupo 3
  maiorD3 = -1000;
  for i=1:length(grupo3)
    d = calculaDist(grupo3(i,:),centros(1,:));
    if d>maiorD3
      maiorD3 = d;
    end
  end
  espalhamento = [maiorD1, maiorD2, maiorD3];
end
