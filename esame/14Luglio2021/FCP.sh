
#!/bin/sh

#questo è il primo file comandi FCP.sh
#controllo sui parametri che deve essere maggiore o uguale a 4

case $# in
0|1|2|3) echo $# non è il numero di parametri giusti
         exit 1;;
*) echo $# è il numero di parametri giusti e si può iniziare a fare il debug
;;
esac

#controllo sui primi due parametri che devono essere nomi assoluti di directory
num=1 #serve per non considerare gli ultimi parametri che sono numeri
params= #ci serve per accumulare i parametri a parte gli ultimi due elementi
for i
do
if test $num -lt `expr $# - 1` #ci serve per non considerare gli ultimi due parametri che sono i numeri
        then
                #soliti controlli su nome assoluto e directory traversabile
                case $i in
                /*)     if test ! -d $i -o ! -x $i
                        then
                        echo $i non directory o non attraversabile
                        exit 2
                        fi;;
                *)      echo $i non nome assoluto; exit 3;;
                esac
                params="$params $i" #se i controlli sono andati bene memorizziamo il nome nella lista params
        else
        #abbiamo individuato gli ultimi due parametri e quindi facciamo il solito controllo su numerico e strettamente positivo
                #Controllo penultimo e ultimo parametro
                case $i in
                *[!0-9]*) echo $i non numerico o non positivo
                          exit 4;;
                *) if test $i -eq 0
                   then echo ERRORE: parametro $i uguale a zero
                        exit 5
                   fi ;;
                esac
                #se i controlli sono andati bene salviamo il penultimo e ultimo parametro
                if test $num -eq `expr $# - 1`
                then
                        H=$i    #H nome indicato nel testo
                else
                        M=$i    #M nome indicato nel testo
                fi
        fi
        num=`expr $num + 1` #incrementiamo il contatore del ciclo sui parametri
done

#ora è finito il controllo sui parametri, possiamo passare alle N fasi

#prima facciamo il settaggio della variabile PATH
PATH=`pwd`:$PATH
export PATH



for G in $params
do
   echo fase per  $G
   FCR.sh $G $H $M #invocazione del file comandi ricorsivo
done

#a questo livello è terminato le N fasi e la ricerca ricorsiva


echo FINITO TUTTO
