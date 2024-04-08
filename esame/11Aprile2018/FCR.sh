#!/bin/sh

#questo è il secondo file cioe il file ricorsivo FCR.sh

cd $1


N= #serve per mettere la lunghezza in linee


for i in *
do
   if test -f $i -a -r $i
   then
       N=`wc -l < $i` #calcola la lunghezza in linee
       if test  $N -ge $2
       then
           if test $N -ge 5 #controlliamo la lunghezza in linee del file ora rispetto a 5
           then

     head -5 $i | tail -1 > $i.quinta #creiamo un file con il nome specificato
      echo `pwd`/$i.quinta >> $3 #salviamo il suo nome nel file temporaneo

     else
       > $i.NOquinta
       echo `pwd`/$i.NOquinta >> $3
     fi
   fi
fi
done
#invocazione della parte ricorsiva
for i in *
do
   if test -d $i -a -x $i
   then FCR.sh `pwd`/$i $2 $3
   fi
done
