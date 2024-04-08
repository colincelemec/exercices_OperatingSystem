#!/bin/sh
#questo è il secondo file comandi ricorsivo

cd $1 #ci spostiamo nella directory corrente

cont=0 #serve per contare i file che soddisfano la specifica
N= #variabile che serve a mettere la lunghezza in linee del file trovato
files= #serve per stockare i file trovati

      for F in * #faccio un for su tutte les directory eseistente
      do
         if test -f $F #si verifica che sia un file
         then
             case $F in
              ??) #caso giusto

             #controllo che la lunghezza in linee del file trovato sia esattamente uguale a M

             N=`wc -l < $F`
             if test $N -eq $3
             then cont=expr`$cont + 1` #aggiorniamo la variabile count
                  files="$files $F"
            fi;;
            *) ;; #non si deve fare nulla;;
        esac
       fi
     done
    # controllo che cont sia strettamente minore di H e maggiore o uguale di 2


    if test $cont -lt $2 -a  $cont -ge 2
    then echo trovata directory `pwd`

     #ora si dovrebbe invocare la parte shell
    fi


for i in *
do
   if test -d $i -a -x $i
  #invochiamo la parte ricorsiva
  then FCR.sh `pwd`/$i $2 $3
   fi
done
