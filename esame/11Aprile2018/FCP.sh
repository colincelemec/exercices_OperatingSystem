
#!/bin/sh

#questo è il primo file comandi FCP.sh
#controllo su numero di parametri
case $# in
0|1|2) echo Errore
       exit 1;;
*) echo OK sul numero di parametri e si puo iniziare a fare il DEBUG

#controllo sul primo parametro che deve essere un numero intero strettamente positivo

case $1 in
*[!0-9]*) echo $1 non numerico oppure non positivo
          exit 2;;
       *) if test $1 -eq 0
          then echo $1 non deve essere un numero intero nullo
          exit 3
          else echo $1 è di sicuro un numero strettamente positivo
          fi;;
esac
Y=$1 #assegno a Y il primo parametro come richiesto dall'esercizio

#controllo sui altri N parametri che devono essere nome assoluty di directory


shift

for G
do
   case $G in
  /*) if test ! -d $G -o ! -x $G
      then echo $G è non è una directory oppure non è attraversabile
      exit 3
      fi;;
   *) echo $G non è nome assoluto
      exit 4;;
    esac
done

PATH=`pwd`:$PATH #settaggio della variabile PATH
export PATH

> /tmp/count$$ #creiamo/azzeriamo il file temporaneo

for N
do
   echo fase per $N
   FCR.sh $N $Y /tmp/count$$ #invocazione ricorsiva
done

#si riporta sullo standard output il numero totale di file creati globalmente


echo il  numero totale di file creati globalmente `wc -l < /tmp/count$$`

for i in `cat  /tmp/count$$`
do
   echo nome assoluto del file creato `pwd`/$i #visualizza il nome assoluto del file
   cat < $i #permette a visualizzare il contenuto del file
done

#rm /tmp/count$$ #alla fine si cancella il file temporaneo
