#!/bin/sh

# Script para baixar e construir golang da fonte. 

# Propriedades
VER="1.9.2"

TAR="go$VER.linux-amd64.tar.gz"
URL="https://storage.googleapis.com/golang/$TAR"

LCL="/usr/local/bin/"
LCL_GO="/usr/local/bin/go/"

echo;echo "\e[34m:: Roteiro de instalação para golang. ::\e[0m";echo

if [ ! -d "$LCL_GO" ];then

  {

    echo;echo '\e[1;33m:: golang não encontrado. ::\e[0m';echo

  } && {

    if [ ! -f "$TAR" ];then

      echo;echo '\e[1;33m:: Tar não encontrado. ::\e[0m';echo

      echo;echo '\e[34m:: Baixar os fontes de golang. ::\e[0m';echo

      # Baixar o fonte na versão especificada
      sudo curl -0 $URL

      echo;echo '\e[1;32m:: Download concluído. ::\e[0m';echo

    else
    
      echo;echo '\e[1;32m:: Tar encontrado. ::\e[0m';echo

    fi

  } && {

   if [ ! -f "go" ];then
   
      echo;echo "\e[1;34m:: Descompactar os fontes. ::\e[0m";echo

      # Descompactar o fonte baixado
      sudo tar -xf $TAR

      echo;echo "\e[1;32m:: $TAR descompactado. ::\e[0m";echo

   else

      echo;echo "\e[1;32m:: Pasta 'go' descompactada encontrada. ::\e[0m";echo

   fi

  } && {
    echo;echo "\e[1;34m:: Mover pasta 'go' para $LCL_GO. ::\e[0m";echo

    if [ -f "$LCL_GO" ];then

      echo;echo "\e[1;33m:: $LCL_GO encontrado. ::\e[0m";echo

      echo;echo "\e[1;34m:: Substituindo. ::\e[0m";

       # Remover a pasta
       sudo rm -rf $LCL_GO

      echo;echo "\e[1;32m:: Removido. ::\e[0m";

    fi

    echo;echo "\e[1;34m:: Movimentando. ::\e[0m";

    # Mover a pasta
    sudo mv go $LCL_GO

    echo;echo "\e[1;32m:: Movimentado. ::\e[0m";

  } && {

    echo;echo "\e[1;34m:: Copiar set_go_env_vars.sh para /etc/profile.d. ::\e[0m";echo

    # Copiar o script https://wiki.debian.org/EnvironmentVariables
    sudo cp cmd/set_go_env_vars.sh /etc/profile.d/set_go_env_vars.sh
    
    echo;echo "\e[1;32m:: Script movimentado. ::\e[0m";echo
    
  } || {

    echo;echo "\e[91m:: Falha na instalação. ::\e[0m";echo

    exit 1

  }

else

  echo;echo "\e[32m:: Go presente e na versão definida neste script. ::\e[0m";echo
  
  exit 0

fi

echo;echo "\e[32m:: Instalação concluída. ::\e[0m";echo

