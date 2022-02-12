#!/bin/bash

#########################################################################  
# funcsVarious.sh - O script fornece varias infos relacionadas a data 	#
#                                                                  	#
# Author:Marcos Rodrigues (marcosrodg26@gmail.com)                 	#
# Data Criação: 11/02/2022                                         	#
#                                                                  	#
# Descrição:O script cria recebe como parametros uma data e a      	#
# retorna em padrao US ou BR depedendo de com a mesma foi informada,	#
# se for informada uma data a funcao tambem pode informar se esta       #
# padrão US ou BR							#
# 								   	#
# Exemplo de Uso: ./funcsVarious --help: retorna o manual da funcao     #
#                 ./funcsVarious -f 08131981                            #
# Alterações:                                                      	#
#               ...................................                	#                             
#########################################################################

DATE=$(echo $2 | sed 's/\///g')  	# Recebe uma data que foi passada no $2 e retira seus / caso tenha
CHAR12=$(echo $DATE | cut -c1-2 )       # Pega os 2 primeiros caracteres
CHAR34=$(echo $DATE | cut -c3-4 )       # Pega o 3° e 4° caractere
CHAR5_8=$(echo $DATE | cut -c5-8 )      # Pega do 5° ao 8° caractere

formatDate(){
	# Função informa em qual formato esta a data US ou BR:

	# Retorna 3 se a data for invalida
	if [ $CHAR12 -gt 12 -a $CHAR34 -gt 12 ]
	then
		return 3 

	# Retorna 2 se a data for em um formato que nao 
	# é possivel determinar 
	elif [ $CHAR12 -le 12 -a $CHAR34 -le 12 ]
	then
		return 2

	# Retorna 1 se for Padrão US
	elif [ $CHAR12 -le 12 -a $CHAR34 -gt 12 ]
	then
		return 1
	
	# Retorna 0 se for Padrão BR
	else
		return 0
	fi
}

invertDate(){
	# A função a data passada como parametro e a inverte
        # se for prão BR invert US ou US invert BR

	# Verifica se a data é valida
        if [ $CHAR12 -gt 12 -a $CHAR34 -gt 12 ]
        then
                echo Undefined date
	else
                echo "$CHAR34/$CHAR12/$CHAR5_8"       # Inverte o dia e mês e vice versa
        fi

}

barInclude(){
	echo "$CHAR12/$CHAR34/$CHAR5_8"               # Coloca / como separador da data
}

myhelp(){
	# Ajuda o usuario entender como usar o Script
 	echo
	echo $0 -[ OPTION ] [ DATE ]
	echo Informe uma  DATA nos formatos DDMMYYYY ou MMDDYYYY, com ou sem /
	echo
	echo Opções:
	echo -f = Retorna 0 para BR, 1 para US e 2 quando impossível determinar, 3 Inválido
	echo -i = Inverte formato BR para US e US para BR. Inclui as Barras
	echo -b = Inclui Barras de Data. Exemplo: de 13081981 para 13/08/1981
	echo -e = Exibe a data em formato extenso. Exemplo de 13081918 para 13 de Agosto de 1981
	echo
}

mesExtensive(){
	# Recebe um numero e retorna qual o mês equivalente 
	# de forma literal
	
	MESATUAL=$(echo ) # A variavel global inicia vazia, e pode ser vista em todo o script
	case $1 in
		01)
			MESATUAL=Janeiro
			;;
		02)
			MESATUAL=Fevereio
                        ;;
		03)
			MESATUAL=Marco
                        ;;
		04)
			MESATUAL=Abril
                        ;;

		05)
			MESATUAL=Maio
                        ;;

		06)
			MESATUAL=Junho
                        ;;

		07)
			MESATUAL=Julho
                        ;;

		08)
			MESATUAL=Agosto
                        ;;

		09)
			MESATUAL=Setembro
                        ;;

		10)
			MESATUAL=Outubro
                        ;;

		11)
			MESATUAL=Novembro
                        ;;

		12)
			MESATUAL=Dezembro
                        ;;			 
	esac
}


extensiveDate(){
	# excreve a data por extenso ex: 13 de Janeiro de 2010


	formatDate		# Chamo a funcao pra saber se qual o formato da data Informada 
        local  OPTION=$?	# Recebo o status code da função

	if [ $OPTION -eq 2 ]	# caso a funcao me retorne o 2, onde dia e mes menores ou igual a 12
	then	
		local OP=0
		until [ $OP -eq 1 -o $OP -eq 2 ] # Enquanto OP nao for 1 ou 2, vou perguntar ao usuario
		do	
			echo
			echo "Impossivel determinar um padrão de data."
			echo "1 - BR (DD/MM/YYYY)"   # Qual o formato da data que ele informou BR
			echo "2 - US (MM/DD/YYYY)"   # ou US
			echo
			read -p "Informe o formato (1 ou 2):" OP # leio a opcao do usuario
		done

		if [ $OP -eq 1 ] # se obtive o 1 como resposta entao é formato BR
		then	
			mesExtensive $CHAR34 # chamo a funcao passando o nmero do mes e ela me retorno  o mes correspondente ao numero

			echo "$CHAR12 de $MESATUAL de $CHAR5_8" # MESATUAL esta na funcao 'mesExtensive'  e foi preenchida com o mes correspondente                                                          

		else	                    # se nao foi 1 entao foi 2 padrao US, faço o processo do 1
			mesExtensive $CHAR12
			echo "$CHAR34 de $MESATUAL de $CHAR5_8"
		fi

	elif [ $OPTION -eq 1 ] # 1 Signoifica que foi informada uma data padrao US ja sei o que fazer
	then
		mesExtensive $CHAR12                    # chamo a funcao passando o mes
		echo "$CHAR34 de $MESATUAL de $CHAR5_8" # formato o retorno

	elif [ $OPTION -eq 0 ] # sigifica que foi uma data padrão BR
	then
		mesExtensive $CHAR34
		echo "$CHAR12 de $MESATUAL de $CHAR5_8"

	else
		echo "Data Invalida"
		echo "Tente \"$0 --help\" para mais informações"
		exit 1
	fi
}

#----------------------------------------------------------#
#              INICIO DO FLUXO DE EXECUÇÃO		   #	
#----------------------------------------------------------#

# Verifica qual o 1 parametro passado pelo usuario
case $1 in
	-f)
		formatDate                # Chamo a função para formatar a data
		;;
	-i)
		invertDate                # Chamo a funcao que inverte a data
		;;
	-b)
		barInclude                # Chamo a funcao que incclui barras a data 
		;;
	-e)
		extensiveDate             # Chamo a funcao que escreve a data por extenso
		;;

	--help)
		myhelp                    # CHamo a funcao de ajuda ao Usuario
		;;

	*)                                # O parametro informado nao foi identificado
		echo "Argument error "
		echo Tente "$0 --help" para mais informações.
		exit 1
		;;
esac

		
