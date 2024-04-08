#!/bin/sh
#questo è il file comandi FCR.sh che scrive il file ricorsivo
#file comandi ricorsivo che scrive il nome dei file trovati sul file temporaneo

#il cui nome è passato come terzo argomento

cd $1 #mi sposto nella directory corrente.NB: ci deve sempre fare questo

#la variabile NG ci serve per il numero di linee trovate dal grep
NG=

for i in *
do
   #controlliamo solo i nomi dei file leggibili!
    if test -f $i -a -r $i
    then  #controlliamo le linee che terminano con il carattere t!
    NG=`grep 't$' $i | wc -l`
    #controlliamo che le linee trovate dal greo siano ALMENO X
       if test $NG -ge $2
        then #abbiamo trovato un file che soddisfa le specifiche e quindi inseriamo il suo nome assoluto ne file temporaneo

         echo `pwd`/$i >> $3 #scrivo in append nel file temporaneo NB: passaggio importante e sempre necessario

       fi
    fi
done

#faccio la solita chiamata ricorsiva

for i in *
do
    if test -d $i -a -x $i
    then
        #chiamata ricorsiva cui passiamo come primo parametro il nome assoluto della directory

        FCR.sh `pwd`/$i $2 $3
    fi
done
