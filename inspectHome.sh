#!/bin/bash

####################################################################  
# inspectHome.sh - O script inspeciona o diretorio /home de todos  #                             
# os usuarios procurando arquivos de extensoes .mp3 .mp4 e jpg     #
#                                                                  #
# Author:Marcos Rodrigues (marcosrodg26@gmail.com)                 #
# Data Criação: 11/02/2022                                         #
#                                                                  #
# Descrição: O script dever inspecionar o diretorio /home de todos #
# os usuarios e listar a quantidade de arquivos .mp3 .mp4 .mkv e   #
# .jpg                                                             #
#                                                                  #
# Exemplo de Uso: ./monitoraProcesso.sh  code &                    #
# Alterações:                                                      #
#               ...................................                #                               #
####################################################################

# procurar por todos usuarios no dir /home

for user in /home/*
do
	QNTMP3=0
	QNTMP4=0
	QNTJPG=0
	QNTMKV=0
	
	OLDIFS=$IFS
	IFS=$'\n'

	for file in $(find $user -name '*.jpg' -o -name '*.mp4' -o -name '*.mp3' -o -name '*.mkv')
	do
		case $file in
			*.mp3)
				QNTMP3=$(expr $QNTMP3 + 1)
				;;
			*.mp4)
				QNTMP4=$(expr $QNTMP4 + 1)
				;;
			*.jpg)
				QNTJPG=$(expr $QNTJPG + 1)
				;;
			*.mkv)
				QNTMKV=$(expr $QNTMKV + 1)
				;;
		esac
	done

echo "User : $(basename $user)"
echo "Quantity MP3: $QNTMP3"
echo "Quantity MP4: $QNTMP4"
echo "Quantity JPG: $QNTJPG"
echo "Quantity MVK: $QNTMKV"
echo

done
IFS=$OLDIFS
	
