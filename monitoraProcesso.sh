#!/bin/bash

####################################################################  
# monitoraProcesso.sh - O script recebe um nome de processo como   #                             
#      argumento e verifica se o mesmo esta em execução ou nao     #
#                                                                  #
# Author:Marcos Rodrigues (marcosrodg26@gmail.com)                 #
# Data Criação: 11/02/2022                                         #
#                                                                  #
# Descrição: O script recebe um nome de processo como argumento e  #
# que constantemente irá verificar se o processo está em execução, #
# exibindos constantes mensagens caso nao esteja,o processo deve   #
# rodar como Daemon                                                #
#             						           #
#                                                                  #
# Exemplo de Uso: ./monitoraProcesso.sh  code &                    #
# Alterações:                                                      #
#               ...................................                #                               #
####################################################################

# verifica se o usuario passou o numero correto de parametros
if [ $# -ne 1 ];
then
	echo "Sintax : $0 param & "
	exit 1
fi

while true
do       
	if ps aux | grep $1 | grep -v grep | grep -v $0 > /dev/null
	then
		echo "PID: $(pgrep $1)"
		sleep 3
	else
		echo  ATENÇÃO!!! O processo $1 NÃO esta em execução!
		sleep 3
		echo
	fi
done



