#!/bin/sh

#controllo sul numero di parametri che deve essere maggiore o uguale a 3


case $# in
0|1|2) echo $# non è il numero di parametri giusti
       exit 1;;
*)     echo $# è il numero di parametri giusto e si può iniziare a fare il debug;;

esac

#controllo sui primi N parametri che devono essere nomi assoluti di directory


count=0 #serve per contare il numero di parametri
params= #serve a stockare i primi N parametri
X= #variabile per il numero strettamente positivo

for i
do
   count=`expr $count + 1`
   if test $count -ne $#
      then #soliti controllo sul nome assoluto e directory traversabile
      case $i in
       /*) if test ! -d $i -o ! -x $i
           then echo $i non directory o non attraversabile
            exit 2
            fi;;
       *)  echo $i non nome assoluto; exit 3;;
      esac
    params="$params $i" #memorizziamo il parametre corrente nella lista
   else #adesso facciamo il controllo sul l'ultimo parametro che deve essere un numero strettamente positivo

      case $i in
      *[!0-9]*) echo $i non numerico o non positivo
                exit 4;;
            *)  if test $i -eq 0
                then echo il numerico non deve essere uguale a 0
                exit 5
                fi;;
      esac

#i controlli sono andati a buon file, salviamo l'ultimo parametro
     if test $count -eq $#
     then X=$i
     fi
fi
done

#i controllo dei parametri sono finiti

PATH=`pwd`:$PATH #settaggio della variabile PATH
export PATH
> /tmp/count$$ #creiamo/azzeriamo il file temporaneo
for G in $params
do
   echo fase per $G
   FCR.sh $G $X /tmp/count$$
done

#a questi livello siamo alla fine di tutte les N fasi
#per corrimao il file temporaneo e mandiamo sullo standard output il suo nome assoluto

echo il numero di directory totali che soddisfano la specifica = `wc -l < /tmp/count$$`
for i in `cat /tmp/count$$`
do
  #stampiamo i nomi assoluti delle directory trovate
  echo "trovato directory $i; contiene i seguenti file"
  cd $i
  for file in *
  do
   echo "file: `pwd`/$file"
   echo "la cui linea $X-esima a partire della fine è la seguente:"
  tail -$X $file | head -1 #ritorna la X-esima linea a partire dalla fine del file
done

rm /tmp/count$$
