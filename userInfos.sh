#!/bin/bash

####################################################################  
# userInfos.sh - O script mostra uma lista com todos os usuarios   #                             
#                     humanos e algumas informações                #
#                                                                  #
# Author:Marcos Rodrigues (marcosrodg26@gmail.com)                 #
# Data Criação: 11/02/2022                                         #
# 								   #
# Descrição: O script  mostra todos os usuários “humanos” da       #
#             máquina seguidos de seu UID, Diretório Home e        #
#                 Nome/Descrição o script em um arquivo            #
# 								   #
# Exemplo de Uso: ./userInfos.sh                                   #
# Alterações:  							   #
#  		...................................		   #				   #
####################################################################


# range de UIDs disponibilizados:
MINIMO_UID=$(grep "^UID_MIN" /etc/login.defs | sed 's/\t//g' | cut -d" " -f2)
MAXIMO_UID=$(grep "^UID_MAX" /etc/login.defs | tr -s '\t' | cut  -f2)

# Fazendo um backup do IFS original
OLDIFS=$IFS

# Declarando um novo separador do IFS
IFS=$'\n'

#Cabeçalho
echo -e "USER\t\tUID\t\tDIR HOME\t\tNAME OR DESCRIPTION"

for user in $(cat /etc/passwd)
do
	# Armazeno o valor do UID do usuario
	USERUID=$(echo $user | cut -d':' -f3 )

	# Se o valor de USERUID for maior ou igual ao UID minimo e menor
	# ou igual o UID maximo
	if [ $USERUID -ge $MINIMO_UID -a $USERUID -le $MAXIMO_UID ]
	then
		USER=$(echo $user | cut -d':' -f1)
		DESC=$(echo $user | cut -d':' -f5 | sed 's/,//g')
		HOMEUSER=$(echo $user | cut -d':' -f6)
		echo -e "$USER\t$USERUID\t\t$HOMEUSER\t\t$DESC"
	fi
done
IFS=$OLDIFS




