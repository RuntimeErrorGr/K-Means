1) clustering_pc:
	Pentru initializarea clusterelor am folosit o matrice multidimensionala,
fiecare fasie a matricei reprezentand un cluster. Apoi am calculat valorile 
coloanelor centroizilor ca fiind mediile pe fiecare coloana a fiecarui cluster.
	Pentru calcularea valorilor finale a centroizilor am folosit o bucla while
in cadrul careia se calculeaza o matrice cu distantele euclidiene
de la fiecare punct la centroidul k, un k = 1 : nr_centroizi. Deoarece fiecare
punct este asignat listei reprezentata de cel mai apropiat centroid, se calculeaza
minimul acestor distante. Am folosit de asemenea un vector de indici de lungime
numar_puncte in care se retine indicele clusterului in care va fi asignat fiecare
punct. 
	Odaca ce vectorul de indici a fost creat, trebuie sa stabilim dimensiunile
fiecarui cluster determinand frecventa de aparitie a fiecarui indice de cluster
in vector. Noile matrice centroizi vor avea o dimensiune egala cu maximul 
acestor frecvente de aparitie. Daca un cluster contine mai putine elemente decat
maximul, restul liniilor pana la dimensiune maxima sunt initializate cu 0.
	Se itereaza prin fiecare cluster si se calculeaza sumele pe coloane, apoi
pentru a obtine valorile medii si implicit valorile centroizilor de la iteratia 
curenta se impart sumele la numarul de elemente nenule de pe fiecare coloana.
Se verifica daca centroizii obtinuti la iteratia curenta sunt identici cu
centroizii de la iteratia anterioara. Daca da, atunci se iese din program si se 
returneaza matricea de centroizi. Daca nu, se trece la o noua iteratie.


2) "compute_cost_pc" 
	Calculeaza costul minim al clustering-ului, adica distanta de la fiecare punct catre cel mai apropiat centroid, astfel:
	- Se stabileste costul clustering-ului pentru fiecare punct folosind distanta euclidiana
	- Costul trebuie sa fie minim, deci este luat drept cost pentru un punct distanta euclidiana pana la cel mai apropiat centroid
	- Costul total minim se obtine prin insumarea costurilor minime pentru fiecare punct
