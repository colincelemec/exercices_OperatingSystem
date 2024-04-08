#!/bin/sh

#questo è il secondo file ricorsivo FCR.sh

#mi sposto nella directory $1

cd $1

N= #serve per calcore la lunghezza in linee del file

files= #serve come lista per stockare i file trovati

for i in *
do
   if test -f $i -a -r $i #controllo l'esistenza e la leggibilità dl file
   then N=`wc -l < $i`
       if test $N -eq $2 #controllo che N sia pari al parametro K
       then files="$files $i"
            echo `pwd`/$i >> $3
       fi
   fi
done

#se i file sono stati trovati

if test "$files"
then echo siamo nella directory corrente `pwd`
     echo che contiene le specifiche dei files: $files


fi




for i in *
do
   if test -d $i -a -x $i
   then $0 `pwd`/$i $2 $3 #si poteva anche scrivere FCR.sh `pwd`/$i $2 $3
   fi
done
