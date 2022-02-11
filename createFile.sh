#!/bin/bash

####################################################################  
# createFile.sh - O script recebe o nome para criação do arquivo   #                             
# os caracteres de preenchimento do arquivo e o tamanho do arquivo #
#                                                                  #
# Author:Marcos Rodrigues (marcosrodg26@gmail.com)                 #
# Data Criação: 11/02/2022                                         #
#                                                                  #
# Descrição:O script cria um arquivo e o preenche com um conjunto  #
# de caracteres até que um determinado tamanho em bytes seja       #
# atingido.O usuário deverá fornecer o nome do arquivo, o conjunto #
# de caracteres que será utilizado para preenchimento do arquivo,e #
# o tamanho final do arquivo em bytes.Se o arquivo já existir, toda#
# a informação anterior será apagada.                              #
#                                                                  #
# Exemplo de Uso: ./monitoraProcesso.sh  code &                    #
# Alterações:                                                      #
#               ...................................                #                               #
####################################################################



read -p "Informe o nome do arquivo a ser criado:" FILE
read -p "Informe um conjunto de caracteres que sera usado para preencher o arquivo:" WORDS
read -p "Informe o tamanho final do arquivo (em bytes):" SIZE

if [ -z $FILE ] || [ -z $WORDS ] || [ -z $SIZE ]
then
	echo "Preencha todos os campos corretamente!"
	exit 1
fi

cat /dev/null > $FILE

PERCENT_SW=0

while [ $SIZE -ge `stat --printf=%s "$FILE"` ]
do
	echo -n  $WORDS >> $FILE
	CURRENTSIZE=$(stat --print=%s $FILE)
	PERCENT=$( expr $CURRENTSIZE \* 100 / $SIZE )
	if [ $( expr $PERCENT % 10) -eq 0 -a $PERCENT_SW -ne $PERCENT ]
	then
		echo "Concluido $PERCENT% - Tamanho do Arquivo: $CURRENTSIZE"
		PERCENT_SW=$PERCENT
	fi
done


		




