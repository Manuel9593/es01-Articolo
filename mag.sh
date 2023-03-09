#!/bin/bash
FILE="./magazzino.txt" # Creates magazzino.txt file if not exists
if [ ! -f $FILE ]; then
    touch $FILE
fi

MENU=0 # Creates menu at the first use
echo -ne "\033[37;40;1m"
echo "Gestore magazzino"
echo "Inserisci un numero tra quelle indicate nel menu"
echo "1) Inserisci articolo"
echo "2) Cerca articolo"
echo "3) Modifica articolo"
echo "4) Cerca articolo"
echo "5) Cancella articolo"
echo "6) Stampa tutti gli articoli"
echo "7) Esci"
read MENU; # reads menu choice

while [[ $MENU -ne 7 ]] # "for" loop if menu choice is not working
do
    # switch part for exec menu choices
    case $MENU in
    1)  clear
        echo
        echo -n "Inserisci il codice: "
        read -n5 code
        ricerca=$(grep -w -i "$code" magazzino.txt) # Check if magazzino.txt contains already a product with the code inserted

        if [[ -z $ricerca ]]
        then 
            echo -n "Inserisci la descrizione: "
            read -n35 desc
            echo -n "Inserisci la quantità: "
            read -n3 many
            echo -n "Inserisci il prezzo: "
            read -n4 price
            # Output data of product inserted
            echo "$code,$many,$price,\"$desc\"" | tee -a magazzino.txt > /dev/null
        else
            echo -n "Articolo già presente"
            read -n1 dummy
        fi
        ;;
    2)  clear
        echo -n "Inserisci il codice: "
        read -n5 code
        ricerca=$(grep -w -i "$code" magazzino.txt) # Check if magazzino.txt contains already a product with the code inserted
        echo $ricerca | tee -a dummy.txt > /dev/null
        if [[ -z $ricerca ]]
        then
            echo Nessun prodotto trovato con codice $code
            read -n1 dummy
        else
            read codice quantita prezzo descrizione < dummy.txt
            echo -e "\n$codice, $quantita, $prezzo, \"$descrizione\""
            rm dummy.txt
            read -n1 dummy
        fi
        ;;
    3)  clear
        echo
        echo -n "Inserisci il codice: "
        read -n5 code
        ricerca=$(grep -w -i "$code" magazzino.txt) # Check if magazzino.txt contains already a product with the code inserted
        if [[ -z $ricerca ]]
        then
            echo -n "Articolo già presente"
            read -n1 dummy
        else
            while IFS=, read codice quantita prezzo descrizione
            do
                if [ $codicem == $codice]
                then
                    descrizionem=$(echo $descrizione | tr -s "")
                    quantitam=$(echo $quantita | tr -s "")
                    prezzom=$(echo $prezzo | tr -s "")
                fi
            done < "magazzino.txt"
            
        fi
        ;;
    4)  clear
        echo -n "Inserisci il codice"
        read -n5 code
        sed '/^${code}/d';;
    6)  clear
        cat magazzino.txt;;
    *)  clear
        echo "Opzione non riconosciuta";;
    esac
    clear # Displays menu after exec menu choice
    echo "Inserisci un numero tra quelle indicate nel menu"
    echo "1) Inserisci articolo"
    echo "2) Cerca articolo"
    echo "3) Cancella articolo"
    echo "4) Stampa articolo"
    echo "5) Esci"
    read MENU #reads menu choice
done
echo "Signed out" # Line when signing out