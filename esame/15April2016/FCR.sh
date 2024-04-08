#!/bin/sh

#questo è il file comandi ricorsivo FCR.sh

cd $1

N= #la lunghezza in linee del file
DIR=false # la variabile DIR ci serve per capire se ci sono file
trovato=true #ci serve per capire se tutti i file rispettano la specifica


for i in *
do
      if test -f $i
      then N=`wc -l < $i` #calcoliamo la lunghezza in linee del file
       if test $N -le $2 #verifichiamo che N sia strettamente superiore a X
       then trovato=false
        #abbimao trovato un file che non soddisfa le specifiche e quindi mettiamo a false trovato
       fi
     else
     if test -d $i
      then
         #abbiamo trovato una directory e quindi dobbiamo mettere a true DIR
         DIR=true
fi
fi
done

#se i due booleani sono rimasti ai valori iniziali allora abbiamo trovato una directory giusta
if test $DIR = false -a $trovato = true -a $N -ne 0
then
     pwd >> $3 #salviamo il nome della directory corrente nel file temporaneo
fi


for i in *
do
    if test -d $i -a -x $i
   then FCR.sh `pwd`/$i $2 $3 #invochiamo la parte ricorsiva
    fi
done
