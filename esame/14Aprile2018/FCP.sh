#!/bin/sh
#soluzione della prima prova in itinere del 17 Aprile 2015

#controllo sul numero di parametri
case $# in
0|1|2) echo Errore: numero di parametri non valido
       exit 1;;
*)     echo DEBUG-numerico;;
esac

#controllo sul primo parametro che deve essere strettamente positivo(useremo un case)


case $1 in
*[!0-9]) echo $1 non è numerico oppure non è positivo
         exit 2;;
*)       if test $1 -eq 0
         then Errore: $1 non puo essere nullo
         exit 3
         else
            echo $1 è un numero valido
         fi;;
esac
X=$1 #salviamo il primo parametro
shift
#controllo sui altri N parametri che devono essere nome assoluti di gerarchie

#visto che abbiamo usato lo shift , ora in $* abbiamo solo i  nomi della gerarchie e quindi possiamo fare il controllo sul nome assoluto di ognuna gerarchia

for G #percoriamo la gerarchia G
do
   case $G in
   /*) if test ! -d $G -o ! -x $G
       then echo $G non directory o non attraversabile
       exit 4
       fi;;
   *)  echo $i non nome assoluto
       exit 5;;
   esac
done

#controllo dei parametri finiti possiare alle N fasi
PATH=`pwd`:$PATH #settaggio della variabile PATH
export PATH

> /tmp/conta$$ #creiamo/azzeriamo il file temporaneo.

for N
do
   echo fase per $N
   #invochiamo il file comandi ricorsivo con la gerarchia, il numero e il file temporaneo
   FCR.sh $N $X /tmp/conta$$
done
#terminate tutte le ricerche ricorsive cioe le N fasi
#Andiamo a contare le linee de file /tmp/conta$$
#si riporta sullo standard output il numero totale di file trovati
echo il numero di file totali che soddisfano la specifica = `wc -l \ /tmp/conta$$`

for i in `cat /tmp/conta$$`
do
   #stampiamo i nomi assoluti dei file trovati
   echo trovato il file `pwd`/$i
   #chiediamo all'utente il numero K per ogni file trovato
   echo -n "dammi il numero K (strettamente maggiore di 0 e strettamente minore di $X):"
   read K
   #controllo sul K che deve essere un numero positivo strettamente minore di K
   case $K in
   *[!0-9]*) echo $K non numerico o non positivo
           exit 6;;
          *) if test $K -eq 0
             then echo $K non deve essere negativo
             rm /tmp/conta$$ #cancelliamo il file temporaneo a causa di un errore
            exit 7
             fi;;
   esac

    if test $K -gt $X
    then Errore: $K deve essere strettamente minore de $X
    rm /tmp/conta$$ #cancelliamo il file temporaneo a causa di un errore
    exit 8

   fi

    #selezioniamo direttamente la $K-esimo linea del file corrente
    head -$K $i | tail -1
done

rm /tmp/conta$$ #cancelliamo definitivamente il file temporaneo
