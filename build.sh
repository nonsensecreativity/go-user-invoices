#!/bin/bash

# Propriedades
DOCKER_COMPOSE_VERSION=1.17.1
COMPOSE_PATH="/usr/local/bin/docker-compose"

COMPOSE_YML_IMAGE="pub/docker-compose-build.yml"
COMPOSE_YML_CONTAINER="pub/docker-compose-up.yml"

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
       -f $COMPOSE_YML_IMAGE \
       build

} || {

  echo;echo ":: Removendo imagens defeituosas criadas. ::";echo

  sudo docker-compose \
       --file $COMPOSE_YML_IMAGE \
       stop 
  sudo docker-compose \
       --file $COMPOSE_YML_IMAGE \
       rm -f
  sudo docker-compose \
       -f $COMPOSE_YML_CONTAINER \
       down -rmi -v 

  echo;echo ":: Falha na construção da imagem. ::";echo

  exit 1

} && { # Ativa serviços dependentes e container da aplicação

  echo;echo ":: Executar construção do container docker ::";echo

  # Executa ativação
  sudo docker-compose \
       -f $COMPOSE_YML_CONTAINER \
       up -d # Detached

} || {

  echo;echo ":: Removendo containeres defeituosos criados. ::";echo

  sudo docker-compose \
       -f $COMPOSE_YML_CONTAINER \
       down -v 

  echo;echo ":: Falha na ativação. ::";echo

  exit 1

}

# :::::::::::::::::::::::::::::::

echo;echo "::: Construção finalizada :::";echo

