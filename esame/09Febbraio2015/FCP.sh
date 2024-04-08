#!/bin/sh

#questo è il primo file comandi FCP.sh

#controllo sul numero di parametri
case $# in
2) echo $# è il numero di parametri giusto;;
*) echo Errore sul numero di parametri
   exit 1;;
esac

case $1 in
#controllo  sul primo parametro
/*) if test -d $1 -a -x $1
      then echo $1 è il nome assoluto di una directory
    fi;;
*)  echo Errore sul tipo del nome di $1
    exit 2;;
esac

#controllo sul secondo parametro

case $2 in
*[!0-9]*) echo $2 non è numerico o non è positivo
           exit 3;;
*) if test $2 -eq 0
   then echo $2 non diverso di 0
   exit 4
   else echo debug-numerico $2
   fi;;
esac


#settaggio della variabile path

PATH=`pwd`:$PATH
export PATH

> /tmp/tmp$$ #creazione del file temporaneo che passeremo poi come ultimo parametro al file comandi ricorsivo



#invocazione della funzione ricorsiva

FCR.sh $1 $2 /tmp/tmp$$ #si poteva anche scrivere FCR.sh $*

#al termine dell'intera esplorazione ricorsiva di G, pero ogni dile Fi trovato si deve richiedere all utente un numero Xi intero strettamente positivo e minore o uguale a K

params= #variabile in cui acculiamo file trovati e numeri chiesti all'utente

for i in `cat /tmp/tmp$$`
do
   params="$params $i" # quindi mette nella mia lista params gli elementi trovati
   #il programma , per ognuno dei file, deve richiedere all'utente un numero x intero strettamente positivo o minore di $2
   echo -n "dammi un numero intero strettamente positivo e minore o uguale a $2 per il file $i: "
   read X # leggo la varibile X
   #controllo X sia numerico e positivo
   case $X in
   *[!0-9]*) echo non numerico o non positivo
           rm /tmp/tmp/$$ #si cancella il file
           exit 5;;
  *) if test $X -eq 0
     then echo ERRORE: dato inserito $X uguale a zero
           rm /tmp/tmp$$
          exit 6
     fi;;
   esac

# controllo che X sia minore di $2

if test $X -gt $2
then
     echo ERRORE: questo numero è minore di $2
     rm /tmp/tmp$$
     exit 7
fi
params= "$params $X" # aggiungo nella lista il nome del file anziche il suo numero davanti

done
#cancelliamo il file temporaneo dato che non ne abbiamo piu bisogno
rm /tmp/tmp$$

echo ora dovrei invocare la parte C ma non lo farei quindi...
echo TUTTO FINITO OK
