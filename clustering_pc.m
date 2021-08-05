function [centroids] = clustering_pc(points, NC)
  [nrPoints, D] = size(points); 
  dimensions(1:NC) = floor(nrPoints / NC);# dimensiune minima clustere
  incrementPoz = mod(nrPoints, NC);       # clustere cu dimensiune != minima
  if incrementPoz > 0 
    dimensions(1:incrementPoz)++;         # vector cu dimensiuni finale clustere
  endif
  for i = 1 : NC                          # initializare clustere
    for j = 1 : dimensions(i)
      clusters(j,:,i) = points(i + (j-1) * NC,:);
    endfor
      centroids(:,:,i) = mean(clusters(1:dimensions(i),:,i));
  endfor
  centroids = squeeze(centroids)';
  ok = 1;         # verific daca centroizii au fost modificati
  list = [];      # lista de indici
  while ok        % recalculez centroizii pana valorile lor raman nemodificate
      for p = 1 : nrPoints
        for k = 1 : NC               # formez o matrice de distante euclidiene
          delta(k,p) = sqrt(sum((centroids(k,:) - points(p,:)) .^ 2));
        endfor
        minims = min(delta);         # extrag minimul de pe fiecare coloana
      endfor
      for p = 1 : nrPoints
        for k = 1 : NC
          if minims(p) == delta(k,p) # pe baza distantei minime
            list(p) = k;             # retin indicele coresp. puncutlui 
            break;
          endif
        endfor  
      endfor
      newDim = accumarray(list', 1);  # frecventa de aparitie a clusterelor
      x = zeros(max(newDim),D,NC);
      for i = 1 : NC                  # formez noii centroizi
        for j = 1 : nrPoints
          if i == list(j)
            x(:,:,i) += points(j,:);
          endif
        endfor
        if newDim(i) != 0
          x(:,:,i) = x(:,:,i) / newDim(i);
        endif
      endfor
      x = x(1,:,1:NC);
      x = squeeze(x)';
      if !isequal(x, centroids)     # daca centroizii s-au modificat
        centroids = x;              # actualizez centroizii
        ok = 0;
      endif
      if ok == 1
        break;
      else 
        ok = 1;
      endif
  endwhile
endfunction
