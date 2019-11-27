clear all; close all;

%dados
dsEmprego = [1 0 0 1 0 0 0 0 0 0];
estados  = [{'Solteiro'},{'Casado'},{'Divorciado'}];
dsEstado = [1 2 1 2 3 2 3 1 2 3];
dsRenda   = [9500 8000 7000 12000 9000 6000 4000 8500 7500 8000];
dsCredito = [1 0 0 1 1 0 0 1 0 0];%o resultado de interesse

%a árvore estática
%dado que as regras são conhecidas

for i=1:length(dsEmprego)
  saida = 0;%inicializada em falso.
  if dsEmprego(i)==1
    saida = 1;
  else
    if dsEstado(i)~=2
        if dsRenda(i)>8000
          saida = 1;
        end
    end  
  end
  disp({'A pessoa ' num2str(i) ' - empregado? ->' num2str(dsEmprego(i)) ' ' estados(dsEstado(i)) ' renda = R$ ' num2str(dsRenda(i)) ' - esperado ' num2str(dsCredito(i)) ' - Predito :' num2str(saida)});
end
