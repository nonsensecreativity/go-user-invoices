#!/bin/bash

# Propriedades
DOCKER_COMPOSE_VERSION=1.17.1
COMPOSE_PATH="/usr/local/bin/docker-compose"
DOWNLOAD_URL="https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/run.sh"

# Roteiro de construção
echo;echo "::: Inicio da construção da imagem :::";echo

# :::::::::::::::::::::::::::::::

{ # Instala 'docker-compose'

  if [[ ! -f $COMPOSE_PATH ]];then  

    echo;echo ":: Instalar 'docker-compose' ::";echo
  
    sudo apt-get install --upgrade docker

    sudo curl -L --fail $DOWNLOAD_URL -o $COMPOSE_PATH

    sudo chmod +x $COMPOSE_PATH
  fi

} || {

  echo;echo ":: Falha na instalação das ferramentas docker. ::"

  exit 1

} && { # Constroi imagem da aplicação

  echo;echo ":: Executar construção da imagem docker ::";echo

  sudo docker-compose \
       -f pub/docker-compose-build.yml \
       build

} || {

  echo;echo ":: Falha na construção do container. ::"

  exit 1

} && { # Ativa serviços dependentes e container da aplicação

  echo;echo ":: Executar construção do container docker ::";echo

  # Executa ativação
  sudo docker-compose \
       -f pub/docker-compose-up.yml \
       up -d # Detached

} || {

  echo;echo ":: Falha na ativação. ::"

  exit 1

}

# :::::::::::::::::::::::::::::::

echo;echo "::: Construção finalizada :::";echo

